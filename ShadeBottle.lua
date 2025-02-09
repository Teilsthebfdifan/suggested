local player = game.Players.LocalPlayer
local backpack = player:FindFirstChild("Backpack")
local tool = game:GetObjects("rbxassetid://133126441514156")[1]

local lastClickTime = 0
local doubleClickThreshold = 0.5
local cooldownTime = 5
local toolReady = true
local clickCount = 0

if tool and backpack then
    tool.Parent = backpack
    tool.GripPos = Vector3.new(-0.369087, -0.222754, -0.0308838)
    tool.ManualActivationOnly = false

    local animationsFolder = tool:FindFirstChild("Animations")
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    
    if humanoid and animationsFolder then
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then
            animator = Instance.new("Animator")
            animator.Parent = humanoid
        end

        local idleAnim = animationsFolder:FindFirstChild("idle")
        local openAnim = animationsFolder:FindFirstChild("open")
        
        if idleAnim then
            idleAnim.AnimationId = "rbxassetid://10479585177"
        end
        if openAnim then
            openAnim.AnimationId = "rbxassetid://10482563149"
        end

        local idleTrack
        if idleAnim then
            idleTrack = animator:LoadAnimation(idleAnim)
        end
        
        tool.Equipped:Connect(function()
            if idleTrack then
                idleTrack.Looped = true
                idleTrack:Play()
            end
        end)

        tool.Unequipped:Connect(function()
            if idleTrack then
                idleTrack:Stop()
            end
        end)

        tool.Activated:Connect(function()
            local currentTime = tick()

            if currentTime - lastClickTime <= doubleClickThreshold then
                clickCount = clickCount + 1
            else
                clickCount = 1
            end

            lastClickTime = currentTime

            if clickCount == 2 and toolReady then
                toolReady = false

                local effectsFolder = player.PlayerGui.MainUI.MainFrame.Healthbar.Effects
                local healthbarEffect = effectsFolder.HerbGreenEffect:Clone()
                healthbarEffect.Image = "rbxassetid://2581223252"
                healthbarEffect.ImageColor3 = Color3.fromRGB(0, 217, 255)
                healthbarEffect.Name = "SlimShadeyEffect"
                healthbarEffect.Visible = true
                healthbarEffect.Parent = effectsFolder

                local whiteVignette = player.PlayerGui.MainUI.MainFrame.WhiteVignette:Clone()
                whiteVignette.ImageColor3 = healthbarEffect.ImageColor3
                whiteVignette.Parent = player.PlayerGui.MainUI.MainFrame
                whiteVignette.ImageTransparency = 0
                whiteVignette.Visible = true

                if openAnim then
                    local openTrack = animator:LoadAnimation(openAnim)
                    openTrack:Play()

                    local sound = Instance.new("Sound")
                    sound.SoundId = "rbxassetid://16746825852"
                    sound.Volume = 1
                    sound.Name = "sound_drink"
                    sound.Parent = game.Workspace
                    sound:Play()
                end

                task.delay(0.9, function()
                    tool:Destroy()

                    local lighting = game:GetService("Lighting")
                    local mainColorCorrection = lighting:FindFirstChild("MainColorCorrection")

                    local shadeing
                    if mainColorCorrection then
                        shadeing = mainColorCorrection:Clone()
                        shadeing.Name = "Shadeing"
                        shadeing.TintColor = Color3.fromRGB(0, 127, 128)
                        shadeing.Brightness = 0.4
                        shadeing.Contrast = 0.8
                        shadeing.Saturation = -0.3
                        shadeing.Parent = lighting
                    end

                    local light = Instance.new("PointLight")
                    light.Brightness = 2
                    light.Color = Color3.fromRGB(0, 255, 255)
                    light.Range = 40
                    light.Parent = humanoid.RootPart

                    task.delay(10, function()
                        local fadeOutTween = game:GetService("TweenService"):Create(
                            whiteVignette,
                            TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                            {ImageTransparency = 1}
                        )
                        fadeOutTween:Play()

                        fadeOutTween.Completed:Connect(function()
                            whiteVignette:Destroy()
                            healthbarEffect.Visible = false
                            if light then
                                light:Destroy()
                            end
                            if shadeing then
                                shadeing:Destroy()
                            end
                        end)
                    end)
                end)

                task.delay(cooldownTime, function()
                    toolReady = true
                end)
            end
        end)
    end
end
