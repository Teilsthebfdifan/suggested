loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()

local CuriousCandle = LoadCustomInstance("rbxassetid://71996838490134")
CuriousCandle.Parent = game:GetService("Players").LocalPlayer.Backpack
CuriousCandle.Animations.idle.AnimationId = "rbxassetid://10479585177"

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Curious Candle by kodbol, Modified by AROxMBUSH, Discord: [https://discord.gg/76Mq5tQWAV]", true)

local player = game.Players.LocalPlayer
local tweenService = game:GetService("TweenService")
local toolEquipped = false
local highlights = {}

local Candle = CuriousCandle:FindFirstChild("Candle")

local objectiveNames = {
    KeyObtain = "Key",
    ElectricalKeyObtain = "Electrical Key",
    LeverForGate = "Lever",
    LiveBreakerPolePickup = "Breaker",
    LiveHintBook = "Book",
    FuseObtain = "Fuse",
    MinesAnchor = "Anchor",
    WaterPump = "Pump",
    TimerLever = "Time Lever"
}

local function updateCandleEffects(state)
    if Candle then
        for _, descendant in ipairs(Candle:GetDescendants()) do
            if descendant:IsA("PointLight") or descendant:IsA("SurfaceLight") then
                descendant.Enabled = state
                descendant.Color = Color3.fromRGB(255, 255, 0)
            elseif descendant:IsA("ParticleEmitter") then
                descendant.Enabled = state
                descendant.Color = ColorSequence.new(Color3.fromRGB(255, 255, 0))
            end
        end
    end
end

local function manageHighlight(object)
    if highlights[object] then return end

    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 1
    highlight.Parent = object
    highlights[object] = highlight

    local fadeInTween = tweenService:Create(highlight, TweenInfo.new(0.5), {FillTransparency = 0.5, OutlineTransparency = 0})
    fadeInTween:Play()
end

local function highlightObjects()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Door" then
            local doorPart = obj:FindFirstChild("Door")
            if doorPart then
                manageHighlight(doorPart)
            end
        elseif objectiveNames[obj.Name] then
            manageHighlight(obj)
        end
    end
end

local function fadeOutHighlights()
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    for object, highlight in pairs(highlights) do
        local tween = tweenService:Create(highlight, tweenInfo, {FillTransparency = 1, OutlineTransparency = 1})
        tween:Play()
        tween.Completed:Connect(function()
            if not toolEquipped then
                highlight:Destroy()
                highlights[object] = nil
            end
        end)
    end
end

CuriousCandle.Equipped:Connect(function()
    toolEquipped = true
    updateCandleEffects(true)
    highlightObjects()
    for _, highlight in pairs(highlights) do
        local fadeIn = tweenService:Create(highlight, TweenInfo.new(0.5), {FillTransparency = 0.5, OutlineTransparency = 0})
        fadeIn:Play()
    end
end)

CuriousCandle.Unequipped:Connect(function()
    toolEquipped = false
    updateCandleEffects(false)
    fadeOutHighlights()
end)

workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("Model") and obj.Name == "Door" and toolEquipped then
        task.wait(0.1)
        local doorPart = obj:FindFirstChild("Door")
        if doorPart then
            manageHighlight(doorPart)
        end
    elseif objectiveNames[obj.Name] and toolEquipped then
        manageHighlight(obj)
    end
end)