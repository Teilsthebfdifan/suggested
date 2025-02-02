loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()

local MischievousCandle = LoadCustomInstance("rbxassetid://136497329701936")
MischievousCandle.Parent = game:GetService("Players").LocalPlayer.Backpack
MischievousCandle.Animations.idle.AnimationId = "rbxassetid://10479585177"

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Candle made by kodbol, Reworked by AROxMBUSH, Discord: [https://discord.gg/76Mq5tQWAV]", true)
task.wait(1)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("ok who asked", true)

local player = game.Players.LocalPlayer
local tweenService = game:GetService("TweenService")
local toolEquipped = false
local highlights = {}
local Candle = MischievousCandle:FindFirstChild("Candle")

local entityNames = {
    RushMoving = "Rush",
    AmbushMoving = "Ambush",
    GlitchAmbush = "Glitch Ambush",
    GlitchedRush = "Glitched Rush",
    FigureRig = "Figure",
    BackdoorRush = "Blitz",
    A120 = "A120",
    A60 = "A60"
}

game.ReplicatedStorage.RemotesFolder.Revive:Destroy()

local function updateCandleEffects(state, color)
    if Candle then
        for _, descendant in ipairs(Candle:GetDescendants()) do
            if descendant:IsA("PointLight") or descendant:IsA("SurfaceLight") then
                descendant.Enabled = state
                descendant.Color = color
            elseif descendant:IsA("ParticleEmitter") then
                descendant.Enabled = state
                descendant.Color = ColorSequence.new(color)
            end
        end
    end
end

updateCandleEffects(true, Color3.fromRGB(255, 0, 0))

local function manageHighlight(obj)
    if highlights[obj] then return end
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 1
    highlight.Parent = obj
    highlights[obj] = highlight
    tweenService:Create(highlight, TweenInfo.new(0.5), {FillTransparency = 0.5, OutlineTransparency = 0}):Play()
end

local function highlightDoors()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "DoorFake" then
            local doorPart = obj:FindFirstChild("Door")
            if doorPart then manageHighlight(doorPart) end
        end
    end
end

local function fadeOutHighlights()
    for obj, highlight in pairs(highlights) do
        tweenService:Create(highlight, TweenInfo.new(0.5), {FillTransparency = 1, OutlineTransparency = 1}):Play()
        task.delay(0.5, function()
            if not toolEquipped then highlight:Destroy() highlights[obj] = nil end
        end)
    end
end

MischievousCandle.Equipped:Connect(function()
    toolEquipped = true
    highlightDoors()
    for _, highlight in pairs(highlights) do
        tweenService:Create(highlight, TweenInfo.new(0.5), {FillTransparency = 0.5, OutlineTransparency = 0}):Play()
    end
end)

MischievousCandle.Unequipped:Connect(function()
    toolEquipped = false
    fadeOutHighlights()
end)

workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("Model") and obj.Name == "DoorFake" and toolEquipped then
        task.wait(0.1)
        local doorPart = obj:FindFirstChild("Door")
        if doorPart then manageHighlight(doorPart) end
    end
end)

local function trapTrigger(hit)
    if hit and hit.Parent and hit.Parent:IsA("Model") and hit.Parent.Parent and hit.Parent.Parent.Name == "SideroomDupe" then
        player.Character:FindFirstChild("Humanoid").Health = 0
    end
end

player.CharacterAdded:Connect(function(char)
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Touched:Connect(trapTrigger)
        end
    end
end)

player.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
    if player.Character.Humanoid.Health <= 0 then
        task.wait(1)
        player:Kick("mischievous : skill issue lol🔥🔥🔥")
    end
end)

workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("Model") and entityNames[obj.Name] then
        for _, prompt in ipairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") and prompt.Parent and prompt.Parent:IsA("Model") and prompt.Parent.Name == "Wardrobe" then
                prompt:Destroy()
            end
        end
    end
end)
loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAcceleration/Hotel-Plus-Plus/refs/heads/main/Backend/MischeviousLight.lua"))()
