workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("Model") and obj.Name == "RushMoving" then
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

            local rushClone = game:GetObjects("rbxassetid://124676630322298")[1]

            if rushClone then
                rushClone.Parent = obj
                rushClone.Position = rushNew.Position

                for _, descendant in ipairs(rushClone:GetDescendants()) do
                    descendant.Parent = rushNew
                end

                rushClone.Position = Vector3.new(1000, 0, 1000)
                rushClone:Destroy()
            end
        end
    end
end)
