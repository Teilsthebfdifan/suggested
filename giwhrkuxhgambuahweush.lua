workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("Model") and obj.Name == "AmbushMoving" then
        local rushNew = obj:FindFirstChild("RushNew", true)

        if rushNew and rushNew:IsA("Part") then
            task.spawn(function()
                while rushNew do
                    for _, descendant in ipairs(rushNew:GetDescendants()) do
                        if descendant:IsA("Sound") and #descendant:GetDescendants() > 0 then
                            descendant:Destroy()
                        end
                    end
                    task.wait()
                end
            end)

            for _, descendant in ipairs(rushNew:GetDescendants()) do
                descendant:Destroy()
            end

            local ambushClone = game:GetObjects("rbxassetid://72841756431652")[1]

            if ambushClone then
                ambushClone.Parent = obj
                ambushClone.Position = rushNew.Position

                for _, descendant in ipairs(ambushClone:GetDescendants()) do
                    descendant.Parent = rushNew
                end

                ambushClone.Position = Vector3.new(1000, 0, 1000)
                ambushClone:Destroy()
            end
        end
    end
end)
