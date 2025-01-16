local function updateObject(descendant)
    if descendant:IsA("BasePart") and descendant.Name == "Door" then
        descendant.Material = Enum.Material.Concrete
        descendant.Color = Color3.fromRGB(75, 75, 75)

        local signPart = descendant:FindFirstChild("Sign")
        if signPart then
            signPart.Material = Enum.Material.Concrete
            signPart.Color = Color3.fromRGB(99, 95, 98)

            local surfaceGui = signPart:FindFirstChildOfClass("SurfaceGui")
            if surfaceGui then
                for _, textElement in ipairs(surfaceGui:GetDescendants()) do
                    if textElement:IsA("TextLabel") or textElement:IsA("TextBox") then
                        textElement.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end

        for _, child in ipairs(descendant:GetChildren()) do
            if child:IsA("BasePart") and (child.Name == "Plate" or child.Name == "Knob") then
                child.Material = Enum.Material.Metal
                child.Color = Color3.fromRGB(99, 95, 98)
            elseif child:IsA("Attachment") and child.Name == "LightAttach" then
                local helpLight = child:FindFirstChild("HelpLight")
                local helpParticle = child:FindFirstChild("HelpParticle")
                if helpLight and helpLight:IsA("Light") then
                    helpLight.Color = Color3.fromRGB(255, 0, 0)
                end
                if helpParticle and helpParticle:IsA("ParticleEmitter") then
                    helpParticle.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
                end
            end
        end
    elseif descendant:IsA("BasePart") and descendant.Name == "FakeDoor" then
        descendant.Material = Enum.Material.Concrete
        descendant.Color = Color3.fromRGB(75, 75, 75)

        local signPart = descendant:FindFirstChild("Sign")
        if signPart then
            signPart.Material = Enum.Material.Concrete
            signPart.Color = Color3.fromRGB(99, 95, 98)

            local surfaceGui = signPart:FindFirstChildOfClass("SurfaceGui")
            if surfaceGui then
                for _, textElement in ipairs(surfaceGui:GetDescendants()) do
                    if textElement:IsA("TextLabel") or textElement:IsA("TextBox") then
                        textElement.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end

        for _, child in ipairs(descendant:GetChildren()) do
            if child:IsA("Attachment") and child.Name == "LightAttach" then
                local helpLight = child:FindFirstChild("HelpLight")
                local helpParticle = child:FindFirstChild("HelpParticle")
                if helpLight and helpLight:IsA("Light") then
                    helpLight.Color = Color3.fromRGB(255, 0, 0)
                end
                if helpParticle and helpParticle:IsA("ParticleEmitter") then
                    helpParticle.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
                end
            end
        end
    elseif descendant:IsA("BasePart") and descendant.Name == "HelpfulLight" then
        local helpParticle = descendant:FindFirstChild("HelpParticle")
        local pointLight = descendant:FindFirstChildOfClass("PointLight")
        if helpParticle and helpParticle:IsA("ParticleEmitter") then
            helpParticle.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
        end
        if pointLight and pointLight:IsA("PointLight") then
            pointLight.Color = Color3.fromRGB(255, 0, 0)
        end
    elseif descendant:IsA("SurfaceGui") and descendant.Name == "Sign" then
        local textLabel = descendant:FindFirstChildOfClass("TextLabel")
        if textLabel then
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
end

game.DescendantAdded:Connect(updateObject)
for _, descendant in ipairs(game:GetDescendants()) do
    updateObject(descendant)
end
