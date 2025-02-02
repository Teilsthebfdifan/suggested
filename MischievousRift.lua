local riftModelId = "rbxassetid://111957202154062"
local riftPosition = Vector3.new(238.338, -0.4735, -15.749)

local Rift = game:GetObjects(riftModelId)[1]
Rift.Parent = game.Workspace
Rift:SetPrimaryPartCFrame(CFrame.new(riftPosition))

local Center = Rift:FindFirstChild("Center")
if Center then
    local MusicClose = Center:FindFirstChild("MusicClose")
    if MusicClose and MusicClose:IsA("Sound") then
        MusicClose.SoundId = "rbxassetid://11869807210"
        MusicClose.PlaybackSpeed = 0.87
    end
end

local function activateRift()
    local player = game.Players.LocalPlayer
    local gui = player.PlayerGui.MainUI.MainFrame
    local healthBar = gui.Healthbar.Effects
    local tweenService = game:GetService("TweenService")

    local function applyEffects()
        local newEffect = healthBar.HerbGreenEffect:Clone()
        newEffect.Name = "MischievousRiftEffect"
        newEffect.ImageColor3 = Color3.fromRGB(255, 255, 255)
        newEffect.Image = "rbxassetid://74062787660956"
        newEffect.Visible = true
        newEffect.Parent = healthBar
    end

    local redVignette = gui.WhiteVignette:Clone()
    redVignette.Name = "RedVignette"
    redVignette.ImageColor3 = Color3.fromRGB(255, 0, 0)
    redVignette.Visible = true
    redVignette.Parent = gui

    local fadeIn = tweenService:Create(redVignette, TweenInfo.new(0.3), { ImageTransparency = 0 })
    fadeIn:Play()
    fadeIn.Completed:Wait()

    applyEffects()

    task.wait(2)

    local fadeOut = tweenService:Create(redVignette, TweenInfo.new(3.5), { ImageTransparency = 1 })
    fadeOut:Play()
    fadeOut.Completed:Wait()

    redVignette:Destroy()

    local rng = math.random(1, 100)
    if rng == 1 then
        player.Character.Humanoid.Health = 0
        if game.ReplicatedStorage:FindFirstChild("GameStats") then
            if game.ReplicatedStorage.GameStats:FindFirstChild("Player_" .. player.Name) then
                game.ReplicatedStorage.GameStats["Player_" .. player.Name].Total.DeathCause.Value = "Mischievous Light"
            end
        end
    elseif rng <= 10 then
        player.Character.Humanoid.Health = player.Character.Humanoid.Health - 50
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Teilsthebfdifan/suggested/refs/heads/main/Mischievous%20candle.lua"))()
        player.Character.Humanoid.Health = player.Character.Humanoid.Health - 10
    end

    task.wait(1)
    Rift:Destroy()

    local soundBreak = Instance.new("Sound")
    soundBreak.SoundId = "rbxassetid://18554564922"
    soundBreak.Volume = 1
    soundBreak.Parent = game.Workspace
    soundBreak:Play()

    task.wait(5)
    soundBreak:Destroy()
end

local RiftPrompt = Rift:FindFirstChild("Rift"):FindFirstChild("RiftPrompt")
if RiftPrompt then
    RiftPrompt.Triggered:Connect(activateRift)
end
