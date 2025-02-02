local shade = game:GetObjects("rbxassetid://117998786918052")[1]
shade.Name = "shadefakelol"
shade.Parent = game.ReplicatedStorage.Entities

if game.ReplicatedStorage.Entities:FindFirstChild("Shade") then
    game.ReplicatedStorage.Entities.Shade.Name = "Shade_Old"
end

shade.Name = "Shade"

local ambienceShade = game.ReplicatedStorage.ClientModules.EntityModules.Shade:FindFirstChild("AmbienceShade")
if ambienceShade and ambienceShade:IsA("ColorCorrectionEffect") then
    ambienceShade.TintColor = Color3.new(0, 1, 0)
end
