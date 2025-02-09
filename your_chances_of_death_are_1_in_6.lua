local player = game.Players.LocalPlayer
local tool = (game:GetObjects("rbxassetid://129343128640285"))[1]
tool.Parent = player.Backpack

local deathSound = Instance.new("Sound")
deathSound.SoundId = "rbxassetid://7521476935"

local reloadSound = Instance.new("Sound")
reloadSound.SoundId = "rbxassetid://2041035308"

local canActivate = true

tool.Activated:Connect(function()
    if not canActivate then return end
    canActivate = false
    
    local humanoid = player.Character:WaitForChild("Humanoid")
    
    local toolAnim = Instance.new("Animation")
    toolAnim.AnimationId = "rbxassetid://10482563149"
    local toolAnimTrack = humanoid:LoadAnimation(toolAnim)
    toolAnimTrack:Play()
    
    if tool:FindFirstChild("Barrel") and tool.Barrel:FindFirstChild("Shoot") then
        local shootParticle = tool.Barrel.Shoot
        shootParticle.Enabled = true
        wait(0.1)
        shootParticle.Enabled = false
    end
    
    if math.random(1, 6) == 1 then
        humanoid.Health = 0
        
        local deathAnim = Instance.new("Animation")
        deathAnim.AnimationId = "rbxassetid://18885083603"
        local deathAnimTrack = humanoid:LoadAnimation(deathAnim)
        deathAnimTrack:Play()
        
        deathSound.Parent = player.Character:WaitForChild("HumanoidRootPart")
        deathSound:Play()
    else
        if tool:FindFirstChild("Handle") and tool.Handle:FindFirstChild("NoAmmo") then
            tool.Handle.NoAmmo:Play()
        end
        
        wait(0.5)
        reloadSound.Parent = tool.Handle
        reloadSound:Play()
        
        local reloadAnim = Instance.new("Animation")
        reloadAnim.AnimationId = "rbxassetid://15398596534"
        local reloadAnimTrack = humanoid:LoadAnimation(reloadAnim)
        reloadAnimTrack:Play()
    end
    
    wait(3)
    canActivate = true
end)

tool.Equipped:Connect(function()
    local humanoid = player.Character:WaitForChild("Humanoid")
    
    local toolAnim = Instance.new("Animation")
    toolAnim.AnimationId = "rbxassetid://10479585177"
    local toolAnimTrack = humanoid:LoadAnimation(toolAnim)
    toolAnimTrack:Play()
    toolAnimTrack.Looped = true
end)

tool.Unequipped:Connect(function()
    local humanoid = player.Character:WaitForChild("Humanoid")
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        if track.Animation.AnimationId == "rbxassetid://10479585177" then
            track:Stop()
        end
    end
end)
