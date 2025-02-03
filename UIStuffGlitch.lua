local player = game.Players.LocalPlayer
local mainUI = player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("MainUI")
if not mainUI then return end  

local jumpscareFrame = mainUI:FindFirstChild("Jumpscare")
if not jumpscareFrame then return end  

local function loopJumpscareColor(frame, colors)
    task.spawn(function()
        local index = 1
        while frame do
            frame.BackgroundColor3 = Color3.fromRGB(colors[index][1], colors[index][2], colors[index][3])
            index = index % #colors + 1
            task.wait(0.1)
        end
    end)
end

local function loopImage(frame, imageId)
    task.spawn(function()
        while frame do
            for _, imgLabel in ipairs(frame:GetDescendants()) do
                if imgLabel:IsA("ImageLabel") then
                    imgLabel.Image = "rbxassetid://" .. imageId
                end
            end
            task.wait(0.1)
        end
    end)
end

loopJumpscareColor(jumpscareFrame:FindFirstChild("Jumpscare_Rush"), {{0, 0, 32}})
loopImage(jumpscareFrame:FindFirstChild("Jumpscare_Rush"), "124950865264416")

loopJumpscareColor(jumpscareFrame:FindFirstChild("Jumpscare_Ambush"), {{32, 0, 0}})
loopImage(jumpscareFrame:FindFirstChild("Jumpscare_Ambush"), "113811605793938")

local seekJumpscare = jumpscareFrame:FindFirstChild("Jumpscare_Seek")
if seekJumpscare then
    local seekLabel = seekJumpscare:FindFirstChild("ImageLabel")
    if seekLabel then
        task.spawn(function()
            local seekColors = {{255, 0, 0}, {0, 0, 0}}
            local index = 1
            while seekLabel do
                seekLabel.ImageColor3 = Color3.fromRGB(seekColors[index][1], seekColors[index][2], seekColors[index][3])
                index = index % #seekColors + 1
                task.wait(0.1)
            end
        end)
    end
end

local shadeJumpscare = jumpscareFrame:FindFirstChild("Jumpscare_Shade")
if shadeJumpscare then
    shadeJumpscare.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    task.spawn(function()
        local shadeColors = {{255, 0, 0}, {0, 0, 0}, {0, 255, 0}, {0, 0, 255}}
        while shadeJumpscare do
            for _, imgLabel in ipairs(shadeJumpscare:GetDescendants()) do
                if imgLabel:IsA("ImageLabel") then
                    imgLabel.ImageColor3 = Color3.fromRGB(unpack(shadeColors[math.random(1, #shadeColors)]))
                end
            end
            task.wait(0.1)
        end
    end)
end

local floorTitle = mainUI:FindFirstChild("FloorTitle")
if floorTitle and floorTitle:IsA("ImageLabel") then
    local tweenService = game:GetService("TweenService")
    local colors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0)}
    
    task.spawn(function()
        local index = 1
        while floorTitle do
            local tween = tweenService:Create(floorTitle, TweenInfo.new(0.1), {ImageColor3 = colors[index]})
            tween:Play()
            task.wait(0.1)
            index = index % #colors + 1
        end
    end)
end
