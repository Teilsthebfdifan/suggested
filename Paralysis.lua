local A90Jumpscare = game.Players.LocalPlayer.PlayerGui.MainUI.Jumpscare.Jumpscare_A90
A90Jumpscare.StopIcon.Image = "rbxassetid://125458770071980"
A90Jumpscare.FaceAngry.Image = "rbxassetid://105840119272290"
A90Jumpscare.Face.Image = "rbxassetid://89003774242144"
A90Jumpscare.Static.ImageColor3 = Color3.fromRGB(255, 0, 0)
A90Jumpscare.Static2.ImageColor3 = Color3.fromRGB(255, 0, 0)
A90Jumpscare.StopIcon.StopStatic.ImageColor3 = Color3.fromRGB(255, 0, 0)

function DeathHint(args, Color)
    local func, setupval, getinfo, typeof, getgc, next = nil, debug.setupvalue or setupvalue, debug.getinfo or getinfo, typeof, getgc, next
    for i, v in next, getgc(false) do
        if typeof(v) == "function" then
            local info = getinfo(v)
            if info.currentline == 54 and info.nups == 2 and info.is_vararg == 0 then
                func = v
                break
            end
        end
    end
    local function Hint(hints, type)
        setupval(func, 1, hints)
        if type ~= nil then
            setupval(func, 2, type)
        end
    end
    Hint({unpack(args)}, Color)
end

spawn(function()
    require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.A90)(
        require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game))
end)

spawn(function()
    wait(2)
    Survived = true
end)

repeat task.wait() until A90Jumpscare.FaceAngry.Visible == true or Survived
if Survived then 
    task.spawn(function()
        wait(2)
        A90Jumpscare.StopIcon.Image = "rbxassetid://101705495137520"
        A90Jumpscare.FaceAngry.Image = "rbxassetid://105720178833830"
        A90Jumpscare.Face.Image = "rbxassetid://101481935686742"
        A90Jumpscare.Static.ImageColor3 = Color3.fromRGB(0, 255, 255)
        A90Jumpscare.Static2.ImageColor3 = Color3.fromRGB(0, 0, 255)
        A90Jumpscare.StopIcon.StopStatic.ImageColor3 = Color3.fromRGB(255, 0, 0)
        
        spawn(function()
            require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.A90)(
                require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game))
        end)

        wait(2)

        local ReSt = game:GetService("ReplicatedStorage")
        local playerStats = ReSt.GameStats["Player_" .. game.Players.LocalPlayer.Name].Total
        playerStats.DeathCause.Value = "A-90'"

        pcall(function()
            DeathHint({
                "Oh... Hello again.",
                "Didn't expect to see you twice...",
                "Maybe it's a rare occurrence?",
                "Anyways, you know the drill...",
                "A-90 can be quite persistent, can't it?",
                "Guess you'll have to try again...",
            }, "Yellow")
        end)

        wait(1)

        local character = game.Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                local root = character:FindFirstChild("HumanoidRootPart")
                if root then
                    local startPos = root.Position
                    local startTime = tick()
                    repeat
                        task.wait()
                    until (root.Position - startPos).magnitude > 0.3 or tick() - startTime > 2
                    if (root.Position - startPos).magnitude > 0.3 then
                        humanoid.Health = math.max(humanoid.Health - 50, 0)
                    end
                end
            end
        end

        wait(3)

        A90Jumpscare.StopIcon.Image = "rbxassetid://125458770071980"
        A90Jumpscare.FaceAngry.Image = "rbxassetid://105840119272290"
        A90Jumpscare.Face.Image = "rbxassetid://89003774242144"
        A90Jumpscare.Static.ImageColor3 = Color3.fromRGB(255, 0, 0)
        A90Jumpscare.Static2.ImageColor3 = Color3.fromRGB(255, 0, 0)
        A90Jumpscare.StopIcon.StopStatic.ImageColor3 = Color3.fromRGB(255, 0, 0)
    end)

    return
end

local ReSt = game:GetService("ReplicatedStorage")
ReSt.GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "A-90"

pcall(function()
    DeathHint({
        "Oh... Hello.",
        "I'm surprised you found this place...",
        "It's pretty tedious just to get here, last time I checked",
        "Anyways, what'd you die to?",
        "Oh that one...",
        "I hope that one isn't too confusing...",
        "All I'll let you know is that it starts attacking after room A-90.",
        "So, you could call it A-90.",
        "Anyways, I hope you don't mind trying again. It would be helpful.",
    }, "Yellow")
end)

wait(1)

local character = game.Players.LocalPlayer.Character
if character then
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Health = math.max(humanoid.Health - 60, 0)
    end
end
