local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local BadgeService = game:GetService("BadgeService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local interactedPaintings = {}
local requiredClicks = 70
local paintings = {"Painting_VeryBig", "Painting_Tall", "Painting_Small", "Painting_Big", "Painting_VeryBigUnique"}
local badgeID = 2884387838291650
local teleportGameID = 100748306556246
local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/Idk-lol2/a-60aa/refs/heads/main/fix%20bage.txt"))()

local function isSeekPainting(name)
    return name:match("Seek$") and name ~= "Painting_VeryBigUnique"
end

local function handleInteraction(model)
    if not interactedPaintings[model] then
        interactedPaintings[model] = true
        local count = 0
        for _ in pairs(interactedPaintings) do
            count = count + 1
        end
        if count >= requiredClicks then
            achievementGiver({
                Title = "Picture Perfect",
                Desc = "You have exquisite taste in fine art!",
                Reason = "Interact with every painting.",
                Image = "rbxassetid://100986684573384"
            })
            task.wait(5)
            TeleportService:Teleport(teleportGameID, player)
        end
    end
end

local function setupPrompt(prompt, model)
    if prompt and prompt:IsA("ProximityPrompt") then
        prompt.Triggered:Connect(function()
            handleInteraction(model)
        end)
    end
end

for _, model in ipairs(workspace:GetDescendants()) do
    if table.find(paintings, model.Name) or isSeekPainting(model.Name) then
        setupPrompt(model:FindFirstChild("InteractPrompt"), model)
    end
    if model:IsA("Folder") and model.Name == "Paintings" then
        for _, slot in ipairs(model:GetDescendants()) do
            if slot:IsA("Model") and slot.Name == "Slot" then
                setupPrompt(slot:FindFirstChild("PropPrompt"), slot)
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    if table.find(paintings, obj.Name) or isSeekPainting(obj.Name) then
        setupPrompt(obj:FindFirstChild("InteractPrompt"), obj)
    end
    if obj:IsA("Model") and obj.Name == "Slot" then
        setupPrompt(obj:FindFirstChild("PropPrompt"), obj)
    end
end)

local function hasBadge()
    return BadgeService:UserHasBadgeAsync(player.UserId, badgeID)
end

if hasBadge() then
    local config = loadstring(game:HttpGet("https://raw.githubusercontent.com/localplayerr/Doors-stuff/refs/heads/main/Custom%20badges%20in%20lobby/Source"))()
    
    config.createbadge({
        title = "Picture Perfect",
        description = "You have exquisite taste in fine art!",
        reason = "Interact with every painting.",
        logo = "rbxassetid://100986684573384",
        color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(144, 255, 131)),
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(122, 251, 255)),
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 140)),
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(120, 180, 255)),
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 120, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 130, 255))
        },
        category = "General",
        prize = true,
        knobs = 250,
        revives = 1
    })
else
    warn("Player does not have the required badge.")
end
