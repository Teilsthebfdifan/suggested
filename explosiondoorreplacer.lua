local StarterGui = game:GetService("StarterGui")

local helpParticleTextureId = "rbxassetid://94369070940842"
local moonIconTextureId = "rbxassetid://102362937285907"
local doorGlowTextureId = "rbxassetid://138589322848947"
local circleStuffTextureId = "rbxassetid://129922456625995"
local linesStuffTextureId = "rbxassetid://122887445599135"
local pointLightColor = Color3.fromRGB(255, 126, 0)
local helpParticleColor = Color3.fromRGB(255, 126, 0)

local function updateProperties()
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Name == "GuidingDoorProtection" then
            local helpParticle = descendant:FindFirstChild("HelpParticle")
            if helpParticle then
                if helpParticle:IsA("ParticleEmitter") then
                    helpParticle.Texture = helpParticleTextureId
                    helpParticle.Color = ColorSequence.new(helpParticleColor)
                    helpParticle.Enabled = true
                end
            end

            local attachDoor = descendant:FindFirstChild("AttachDoor")
            if attachDoor then
                local pointLight = attachDoor:FindFirstChildOfClass("PointLight")
                if pointLight then
                    pointLight.Color = pointLightColor
                    pointLight.Enabled = true
                end

                local function updateParticle(particleName, textureId)
                    local particle = attachDoor:FindFirstChild(particleName)
                    if particle then
                        if particle:IsA("ParticleEmitter") then
                            particle.Color = ColorSequence.new(pointLightColor)
                            particle.Texture = textureId
                        end
                    end
                end

                updateParticle("MoonIcon", moonIconTextureId)
                updateParticle("DoorGlow", doorGlowTextureId)
                updateParticle("CircleStuff", circleStuffTextureId)
                updateParticle("LinesStuff", linesStuffTextureId)
            end
        end
    end
end

updateProperties()

workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("BasePart") and descendant.Name == "GuidingDoorProtection" then
        updateProperties()
    end
end)

if someCondition then
    StarterGui:SetCore("SendNotification", {
        Title = "Warning",
        Text = "SCRIPT ONLY WORKS IN THE MINES AND HOTEL",
        Duration = 10,
    })
else
    StarterGui:SetCore("SendNotification", {
        Title = "Warning",
        Text = "Script only works if guiding door protection exists",
        Duration = 10,
    })
end