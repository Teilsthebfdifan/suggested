local storage = game.ReplicatedStorage:FindFirstChild("Entities")
local screechModels = {
    "rbxassetid://113708765916469",
    "rbxassetid://133174471932523",
    "rbxassetid://91140181871985"
}

local currentIndex = 1

local function swapScreech()
    if not storage then return end

    local existingScreech = storage:FindFirstChild("Screech")
    if existingScreech then
        existingScreech.Name = "ScreechyReal"
    end

    local newScreech = game:GetObjects(screechModels[currentIndex])[1]
    if newScreech then
        newScreech.Parent = storage
        newScreech.Name = "Screech"
    end

    currentIndex = (currentIndex % #screechModels) + 1
end

while true do
    swapScreech()
    task.wait(0.1)
end
