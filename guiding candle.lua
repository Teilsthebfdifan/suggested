loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()

local GuidingCandle = LoadCustomInstance("rbxassetid://100368646934066")
GuidingCandle.Parent = game:GetService("Players").LocalPlayer.Backpack
GuidingCandle.Animations.idle.AnimationId = "rbxassetid://10479585177"

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Candle made by kodbol, Reworked by AROxMBUSH, Discord: [https://discord.gg/76Mq5tQWAV]", true)
task.wait(1)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("ok who asked", true)

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local tweenService = game:GetService("TweenService")
local distanceThreshold = 120
local flicker = false
local stopFlickering = false
local toolEquipped = false
local highlights = {}

local Candle = GuidingCandle:FindFirstChild("Candle")

local entityNames = {
    RushMoving = "Rush",
    AmbushMoving = "Ambush",
    Eyes = "Eyes",
    FigureRig = "Figure",
    BackdoorRush = "Blitz",
    BackdoorLookman = "Lookman",
    A60 = "A60",
    A120 = "A120",
    GlitchAmbush = "GlitchAmbush",
    GlitchedRush = "GlitchedRush",
    Screech = "Screech",
    GlitchScreech = "GlitchScreech",
    GloombatSwarm = "Gloombats",
    JeffTheKiller = "JeffTheKiller",
    Dread = "Dread",
    CustomEntity = "CustomAdminEntity"
}

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

local function flickerCandle()
    stopFlickering = false
    updateCandleEffects(true, Color3.fromRGB(255, 0, 0))
    task.wait(0.1)
    while flicker do
        if stopFlickering then break end
        updateCandleEffects(true, Color3.fromRGB(255, 0, 0))
        task.wait(0.1)
        if stopFlickering then break end
        updateCandleEffects(true, Color3.fromRGB(0, 0, 0))
        task.wait(0.1)
    end
    updateCandleEffects(true, Color3.fromRGB(0, 255, 255))
end

local function checkEntities()
    task.spawn(function()
        while task.wait(0.02) do
            local found = false
            
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and entityNames[obj.Name] then
                    found = true
                    break
                end
            end
            
            for _, obj in ipairs(game.Workspace.Camera:GetDescendants()) do
                if obj:IsA("Model") and (obj.Name == "Screech" or obj.Name == "GlitchScreech") then
                    found = true
                    break
                end
            end
            
            if found then
                if not flicker then
                    flicker = true
                    task.spawn(flickerCandle)
                end
            else
                if flicker then
                    flicker = false
                    stopFlickering = true
                    updateCandleEffects(true, Color3.fromRGB(0, 255, 255))
                end
            end
        end
    end)
end

checkEntities()

local function manageHighlight(doorPart)
    if highlights[doorPart] then return end

    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(0, 255, 255)
    highlight.OutlineColor = Color3.fromRGB(0, 255, 255)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 1
    highlight.Parent = doorPart
    highlights[doorPart] = highlight

    local fadeInTween = tweenService:Create(highlight, TweenInfo.new(0.5), {FillTransparency = 0.5, OutlineTransparency = 0})
    fadeInTween:Play()
end

local function highlightDoors()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Door" then
            local doorPart = obj:FindFirstChild("Door")
            if doorPart then
                manageHighlight(doorPart)
            end
        end
    end
end

local function fadeOutHighlights()
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    for doorPart, highlight in pairs(highlights) do
        local tween = tweenService:Create(highlight, tweenInfo, {FillTransparency = 1, OutlineTransparency = 1})
        tween:Play()
        tween.Completed:Connect(function()
            if not toolEquipped then
                highlight:Destroy()
                highlights[doorPart] = nil
            end
        end)
    end
end

GuidingCandle.Equipped:Connect(function()
    toolEquipped = true
    highlightDoors()
    for _, highlight in pairs(highlights) do
        local fadeIn = tweenService:Create(highlight, TweenInfo.new(0.5), {FillTransparency = 0.5, OutlineTransparency = 0})
        fadeIn:Play()
    end
end)

GuidingCandle.Unequipped:Connect(function()
    toolEquipped = false
    fadeOutHighlights()
end)

workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("Model") and obj.Name == "Door" and toolEquipped then
        task.wait(0.1)
        local doorPart = obj:FindFirstChild("Door")
        if doorPart then
            manageHighlight(doorPart)
        end
    end
end)
