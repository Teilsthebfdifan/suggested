local TweenService = game:GetService("TweenService")
local tool = game:GetObjects("rbxassetid://75078116163466")[1]
local player = game.Players.LocalPlayer
local animations = tool:WaitForChild("Animations")

local function removeHighlights()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Highlight") then v:Destroy() end
    end
end

local function tweenTransparency(instance, endValue, duration)
    TweenService:Create(instance, TweenInfo.new(duration, Enum.EasingStyle.Linear), { Transparency = endValue }):Play()
end

if tool then
    tool.Equipped:Connect(function()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character and character:FindFirstChild("Humanoid")
        if humanoid then
            local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
            local idleAnim = animations:FindFirstChild("tempidle")
            if idleAnim then
                local track = animator:LoadAnimation(idleAnim)
                track.Looped = true
                track:Play()
                tool.Unequipped:Connect(function() track:Stop() end)
            end
        end
    end)

    tool.Activated:Connect(function()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character and character:FindFirstChild("Humanoid")
        if humanoid then
            local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
            local openAnim = animations:FindFirstChild("tempopen")
            if openAnim then animator:LoadAnimation(openAnim):Play() end
        end
        
        task.wait(0.9)
        tool:Destroy()

        local ui = player.PlayerGui:WaitForChild("MainUI")
        local mainFrame = ui:WaitForChild("MainFrame")
        local vignette = mainFrame:WaitForChild("WhiteVignette"):Clone()
        vignette.Name = "GuidingVignetteInsertContent"
        vignette.ImageColor3 = Color3.fromRGB(33, 188, 255)
        vignette.Parent = mainFrame
        vignette.Visible = true
        vignette.Transparency = 0

        local healthBar = mainFrame:WaitForChild("Healthbar")
        local effects = healthBar:WaitForChild("Effects")
        local originalEffect = effects:WaitForChild("HerbGreenEffect")
        local newEffect = originalEffect:Clone()
        newEffect.Name = "GuidingEffectInsertContent"
        newEffect.Image = "rbxassetid://78334799251835"
        newEffect.ImageColor3 = Color3.fromRGB(33, 188, 255)
        newEffect.Parent = effects
        newEffect.Visible = true

        for _, v in ipairs(workspace:GetDescendants()) do
            if v.Name == "Door" then
                local highlight = Instance.new("Highlight", v)
                highlight.FillColor = Color3.fromRGB(0, 255, 255)
            end
        end

        tweenTransparency(vignette, 1, 10)
        task.wait(10)
        vignette.Visible = false
        vignette:Destroy()
        newEffect.Visible = false
        newEffect:Destroy()
        removeHighlights()
    end)
end
