local CmdSettings = {}

function sendNotif(title, text)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

function dropMoney()
    game:GetService("ReplicatedStorage").MainEvent:FireServer("DropMoney", "10000")
    sendNotif("Money dropped!", "$ 1000 dropped!")

end

local Connections = {}

local Services = {
    ["Players"] = game:GetService("Players")
}

local Variables = {
    Player = game.Players.LocalPlayer
}

local function putinair(Type)
    if CmdSettings["AirLock"] == nil and Type == true then
        print("pulling bro up")
        print("pulling bro up")
        print("pulling bro up")
        print("pulling bro up")
        print("pulling bro up")
        print("pulling bro up")
        print("pulling bro up")
        local BP = Variables["Player"].Character.HumanoidRootPart:FindFirstChild("AirLockBP")
        if BP then
            BP:Destroy()
        end
        CmdSettings["AirLock"] = true
        Variables["Player"].Character.HumanoidRootPart.CFrame =
            Variables["Player"].Character.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
        local BP = Instance.new("BodyPosition", Variables["Player"].Character.HumanoidRootPart)
        BP.Name = "AirLockBP"
        BP.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BP.Position = Variables["Player"].Character.HumanoidRootPart.Position
    elseif CmdSettings["AirLock"] == true and Type == false then
        print("pulling bro down")
        print("pulling bro down")
        print("pulling bro down")
        print("pulling bro down")
        print("pulling bro down")
        print("pulling bro down")
        CmdSettings["AirLock"] = nil
        local BP = Variables["Player"].Character.HumanoidRootPart:FindFirstChild("AirLockBP")
        if BP then
            BP:Destroy()
        end
    end
end

if not game:IsLoaded() then
    repeat
        wait()
    until game:IsLoaded()
end

local SpoofTable = {
    WalkSpeed = 16,
    JumpPower = 50
}

-- // Configuration
local Flags = {"CHECKER_1", "TeleportDetect", "OneMoreTime"}

-- // __namecall hook
local __namecall
__namecall = hookmetamethod(game, "__namecall", function(...)
    -- // Vars
    local args = {...}
    local self = args[1]
    local method = getnamecallmethod()
    local caller = getcallingscript()

    -- // See if the game is trying to alert the server
    if (method == "FireServer" and tablefind(Flags, args[2])) then
        return
    end

    -- // Anti Crash
    if (not checkcaller() and getfenv(2).crash) then
        -- // Hook the crash function to make it not work
        hookfunction(getfenv(2).crash, function()
            warn("Crash Attempt")
        end)
    end

    -- //
    return __namecall(...)
end)

-- // __index hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Make sure it's trying to get our humanoid's ws/jp
    if (not checkcaller() and t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower")) then
        -- // Return spoof values
        return SpoofTable[k]
    end

    -- //
    return __index(t, k)
end)

-- // __newindex hook
local __newindex
__newindex = hookmetamethod(game, "__newindex", function(t, k, v)
    -- // Make sure it's trying to set our humanoid's ws/jp
    if (not checkcaller() and t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower")) then
        -- // Add values to spoof table
        SpoofTable[k] = v

        -- // Disallow the set
        return
    end

    -- //
    return __newindex(t, k, v)
end)

if game.PlaceId == 2788229376 then
    getgenv().adverting = false
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)

    getgenv().isDropping = false
    local speed = 50
    local c
    local h
    local bv
    local bav
    local cam
    local flying
    local p = game.Players.LocalPlayer
    local buttons = {
        W = false,
        S = false,
        A = false,
        D = false,
        Moving = false
    }

    local startFly = function()
        if not p.Character or not p.Character.Head or flying then
            return
        end
        c = p.Character
        h = c.Humanoid
        h.PlatformStand = true
        cam = workspace:WaitForChild('Camera')
        bv = Instance.new("BodyVelocity")
        bav = Instance.new("BodyAngularVelocity")
        bv.Velocity, bv.MaxForce, bv.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
        bav.AngularVelocity, bav.MaxTorque, bav.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
        bv.Parent = c.Head
        bav.Parent = c.Head
        flying = true
        h.Died:connect(function()
            flying = false
        end)
    end

    local Players = game:GetService('Players')

    local endFly = function()
        if not p.Character or not flying then
            return
        end
        h.PlatformStand = false
        bv:Destroy()
        bav:Destroy()
        flying = false
    end

    game:GetService("UserInputService").InputBegan:connect(function(input, GPE)
        if GPE then
            return
        end
        for i, e in pairs(buttons) do
            if i ~= "Moving" and input.KeyCode == Enum.KeyCode[i] then
                buttons[i] = true
                buttons.Moving = true
            end
        end
    end)

    game:GetService("UserInputService").InputEnded:connect(function(input, GPE)
        if GPE then
            return
        end
        local a = false
        for i, e in pairs(buttons) do
            if i ~= "Moving" then
                if input.KeyCode == Enum.KeyCode[i] then
                    buttons[i] = false
                end
                if buttons[i] then
                    a = true
                end
            end
        end
        buttons.Moving = a
    end)

    local setVec = function(vec)
        return vec * (speed / vec.Magnitude)
    end

    game:GetService("RunService").Heartbeat:connect(function(step)
        if flying and c and c.PrimaryPart then
            local p = c.PrimaryPart.Position
            local cf = cam.CFrame
            local ax, ay, az = cf:toEulerAnglesXYZ()
            c:SetPrimaryPartCFrame(CFrame.new(p.x, p.y, p.z) * CFrame.Angles(ax, ay, az))
            if buttons.Moving then
                local t = Vector3.new()
                if buttons.W then
                    t = t + (setVec(cf.lookVector))
                end
                if buttons.S then
                    t = t - (setVec(cf.lookVector))
                end
                if buttons.A then
                    t = t - (setVec(cf.rightVector))
                end
                if buttons.D then
                    t = t + (setVec(cf.rightVector))
                end
                c:TranslateBy(t * step)
            end
        end
    end)
    Players.PlayerAdded:Connect(function(player)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Someone joined!",
            Text = player.name .. " joined the game.",
            Duration = 5
        })
    end)

    local function PlayerAdded(Player)
        local function Chatted(Message)
            local plr = game.Players.LocalPlayer
            local character = plr.Character or plr.CharacterAdded:Wait()
            local humanoid = character:FindFirstChild("Humanoid")
            local PlayerHumanoid = plr.Character:WaitForChild("Humanoid")
            local targetHumanoid = Player.Character:WaitForChild("Humanoid")
            local LastTargetPosition = targetHumanoid.RootPart.CFrame
            local Length = 3

            if Player.UserId == getgenv().controller then

                local finalMsg = Message:lower()

                for i, v in pairs(getgenv().alts) do
                    if v == plr.UserId then
                        if finalMsg == getgenv().prefix .. "fly " .. plr.Name:lower() then
                            startFly()

                        end
                        if finalMsg == getgenv().prefix .. "fly" then
                            startFly()

                        end
                        if finalMsg == getgenv().prefix .. "setup admin" then
                            game.Players.LocalPlayer.Character.Head.Anchored = false
                            for i, v in pairs(getgenv().alts) do
                                if i == "Alt1" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-883, -38, -623)
                                    end
                                end
                                if i == "Alt2" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-878, -38, -623)
                                    end
                                end
                                if i == "Alt3" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-873, -38, -623)
                                    end
                                end
                                if i == "Alt4" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-868, -38, -624)
                                    end
                                end
                                if i == "Alt5" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-862, -38, -624)
                                    end
                                end
                                if i == "Alt6" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-857, -38, -624)
                                    end
                                end
                                if i == "Alt7" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-857, -38, -618)
                                    end
                                end
                                if i == "Alt8" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-862, -38, -618)
                                    end
                                end
                                if i == "Alt9" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-867, -38, -618)
                                    end
                                end
                                if i == "Alt10" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-872, -38, -618)
                                    end
                                end
                                if i == "Alt11" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-877, -38, -618)
                                    end
                                end
                                if i == "Alt12" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-882, -38, -618)
                                    end
                                end
                                if i == "Alt13" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-882, -38, -612)
                                    end
                                end
                                if i == "Alt14" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-878, -38, -611)
                                    end
                                end
                                if i == "Alt15" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-872, -38, -611)
                                    end
                                end
                                if i == "Alt16" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-867, -38, -612)
                                    end
                                end
                                if i == "Alt17" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-861, -38, -612)
                                    end
                                end
                                if i == "Alt18" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-861, -38, -607)
                                    end
                                end
                                if i == "Alt19" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-867, -38, -607)
                                    end
                                end
                                if i == "Alt20" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-872, -38, -607)
                                    end
                                end
                                if i == "Alt21" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-878, -38, -608)
                                    end
                                end
                                if i == "Alt22" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-883, -38, -608)
                                    end
                                end
                                if i == "Alt23" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-883, -38, -603)
                                    end
                                end
                                if i == "Alt24" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-878, -38, -603)
                                    end
                                end
                                if i == "Alt25" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-873, -38, -602)
                                    end
                                end
                                if i == "Alt26" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-867, -38, -602)
                                    end
                                end
                                if i == "Alt27" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-861, -38, -602)
                                    end
                                end
                                if i == "Alt28" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-862, -38, -598)
                                    end
                                end
                                if i == "Alt29" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-867, -38, -598)
                                    end
                                end
                                if i == "Alt30" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-872, -38, -598)
                                    end
                                end
                                if i == "Alt31" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-878, -38, -599)
                                    end
                                end
                                if i == "Alt32" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-884, -38, -599)
                                    end
                                end
                                if i == "Alt33" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-884, -38, -594)
                                    end
                                end
                                if i == "Alt34" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-880, -38, -594)
                                    end
                                end
                                if i == "Alt35" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-874, -38, -594)
                                    end
                                end
                                if i == "Alt36" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-869, -38, -594)
                                    end
                                end
                                if i == "Alt37" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-864, -38, -594)
                                    end
                                end
                                if i == "Alt38" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-858, -38, -594)
                                    end
                                end
                            end
                        end

                        if finalMsg == getgenv().prefix .. "setup bank" then
                            game.Players.LocalPlayer.Character.Head.Anchored = false
                            for i, v in pairs(getgenv().alts) do
                                if i == "Alt1" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-389, 21, -338)
                                    end
                                end
                                if i == "Alt2" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-385, 21, -338)
                                    end
                                end
                                if i == "Alt3" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-380, 21, -337)
                                    end
                                end
                                if i == "Alt4" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-376, 21, -338)
                                    end
                                end
                                if i == "Alt5" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-370, 21, -338)
                                    end
                                end
                                if i == "Alt6" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-366, 21, -338)
                                    end
                                end
                                if i == "Alt7" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-361, 21, -338)
                                    end
                                end
                                if i == "Alt8" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-361, 21, -333)
                                    end
                                end
                                if i == "Alt9" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-365, 21, -334)
                                    end
                                end
                                if i == "Alt10" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-370, 21, -334)
                                    end
                                end
                                if i == "Alt11" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-375, 21, -334)
                                    end
                                end
                                if i == "Alt12" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-381, 21, -334)
                                    end
                                end
                                if i == "Alt13" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-386, 21, -334)
                                    end
                                end
                                if i == "Alt14" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-390, 21, -334)
                                    end
                                end
                                if i == "Alt15" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-390, 21, -331)
                                    end
                                end
                                if i == "Alt16" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-386, 21, -331)
                                    end
                                end
                                if i == "Alt17" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-382, 21, -331)
                                    end
                                end
                                if i == "Alt18" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-376, 21, -331)
                                    end
                                end
                                if i == "Alt19" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-371, 21, -331)
                                    end
                                end
                                if i == "Alt20" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-366, 21, -331)
                                    end
                                end
                                if i == "Alt21" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-361, 21, -331)
                                    end
                                end
                                if i == "Alt22" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-361, 21, -327)
                                    end
                                end
                                if i == "Alt23" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-365, 21, -327)
                                    end
                                end
                                if i == "Alt24" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-371, 21, -326)
                                    end
                                end
                                if i == "Alt25" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-376, 21, -327)
                                    end
                                end
                                if i == "Alt26" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-381, 21, -326)
                                    end
                                end
                                if i == "Alt27" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-385, 21, -327)
                                    end
                                end
                                if i == "Alt28" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-390, 21, -323)
                                    end
                                end
                                if i == "Alt29" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-390, 21, -326)
                                    end
                                end
                                if i == "Alt30" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-390, 21, -323)
                                    end
                                end
                                if i == "Alt31" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-385, 21, -323)
                                    end
                                end
                                if i == "Alt32" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-381, 21, -323)
                                    end
                                end
                                if i == "Alt33" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-375, 21, -324)
                                    end
                                end
                                if i == "Alt34" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-370, 21, -323)
                                    end
                                end
                                if i == "Alt35" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-365, 21, -324)
                                    end
                                end
                                if i == "Alt36" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-360, 21, -324)
                                    end
                                end
                                if i == "Alt37" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-359, 21, -318)
                                    end
                                end
                                if i == "Alt38" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-364, 21, -319)
                                    end
                                end
                            end
                        end

                        if finalMsg == getgenv().prefix .. "drop" then

                            if getgenv().isDropping == false then

                                getgenv().isDropping = true

                            --   if getgenv().isDropping == true then
                            --       game:GetService("VirtualInputManager"):SendKeyEvent(true, 102, false, yomama)
                            --       local args = {
                            --           [1] = "Started Dropping!",
                            --           [2] = "All"
                            --       }

                            --       game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                            --           unpack(args))
                            --   end
                                while getgenv().isDropping == true do

                                  --  if game:GetService("Players").LocalPlayer.DataFolder.Currency.Value < 10000 then
                                  --      local args = {
                                  --          [1] = "Ran out of money, stopped dropping.",
                                  --          [2] = "All"
                                  --      }
--
                                  --      game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents
                                  --          .SayMessageRequest:FireServer(unpack(args))
                                  --  end

                                    local args = {
                                        [1] = "DropMoney",
                                        [2] = "10000"
                                    }

                                    game:GetService("ReplicatedStorage").MainEvent:FireServer(unpack(args))
                                    wait(15)
                                end
                            else

                                getgenv().isDropping = false
                                if getgenv().isDropping == false then
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 102, false, yomama)
                                    local args = {
                                        [1] = "Stopped Dropping!",
                                        [2] = "All"
                                    }

                                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                        unpack(args))
                                end

                            end

                        end

                        if finalMsg == getgenv().prefix .. "drop " .. plr.Name:lower() then

                            if getgenv().isDropping == false then

                                getgenv().isDropping = true

                                if getgenv().isDropping == true then
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 102, false, yomama)
                                    local args = {
                                        [1] = "Started Dropping!",
                                        [2] = "All"
                                    }

                                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                        unpack(args))
                                end
                                while getgenv().isDropping == true do

                                    if game:GetService("Players").LocalPlayer.DataFolder.Currency.Value < 10000 then
                                        local args = {
                                            [1] = "Ran out of money, stopped dropping.",
                                            [2] = "All"
                                        }

                                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents
                                            .SayMessageRequest:FireServer(unpack(args))
                                    end

                                    local args = {
                                        [1] = "DropMoney",
                                        [2] = "10000"
                                    }

                                    game:GetService("ReplicatedStorage").MainEvent:FireServer(unpack(args))
                                    wait(15)
                                end
                            else

                                getgenv().isDropping = false
                                if getgenv().isDropping == false then
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 102, false, yomama)
                                    local args = {
                                        [1] = "Stopped Dropping!",
                                        [2] = "All"
                                    }

                                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                        unpack(args))
                                end

                            end

                        end

                        if finalMsg == getgenv().prefix .. "advert" then

                            if getgenv().adverting == false then

                                getgenv().adverting = true

                                while getgenv().adverting == true do

                                    local args = {
                                        [1] = getgenv().adMessage,
                                        [2] = "All"
                                    }

                                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                        unpack(args))
                                    wait(getgenv().adMessageCooldown)

                                end
                            else

                                getgenv().adverting = false

                            end

                        end

                        if finalMsg == getgenv().prefix .. "advert " .. plr.Name:lower() then

                            if getgenv().adverting == false then

                                getgenv().adverting = true

                                while getgenv().adverting == true do

                                    local args = {
                                        [1] = getgenv().adMessage,
                                        [2] = "All"
                                    }

                                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                        unpack(args))
                                    wait(getgenv().adMessageCooldown)

                                end
                            else

                                getgenv().adverting = false

                            end

                        end

                        if finalMsg == getgenv().prefix .. "vibe" then

                            game:GetService("Players"):Chat("/e dance2")

                        end
                        if finalMsg == getgenv().prefix .. "vibe " .. plr.Name:lower() then

                            game:GetService("Players"):Chat("/e dance2")

                        end

                        if finalMsg == getgenv().prefix .. "wallet " .. plr.Name:lower() then
                            for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v.name == "Wallet" then
                                    v.Parent = game.Players.LocalPlayer.Character
                                else
                                    local localPlayer = game.Players.LocalPlayer
                                    local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
                                    if humanoid then
                                        humanoid:UnequipTools()
                                    end
                                end
                            end

                        end

                        if finalMsg == getgenv().prefix .. "wallet" then
                            for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v.name == "Wallet" then
                                    v.Parent = game.Players.LocalPlayer.Character
                                else
                                    local localPlayer = game.Players.LocalPlayer
                                    local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
                                    if humanoid then
                                        humanoid:UnequipTools()
                                    end
                                end
                            end

                        end

                        if finalMsg == getgenv().prefix .. "setspot " .. plr.Name:lower() then
                            local args = {
                                [1] = "Set spot successfully!",
                                [2] = "All"
                            }

                            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                unpack(args))
                            local Players = game:GetService("Players")
                            local function getPlayerByUserId(userId)
                                for _, player in pairs(Players:GetPlayers()) do
                                    if player.UserId == userId then
                                        return player
                                    end
                                end
                            end

                            local plrrlrllr = getPlayerByUserId(getgenv().controller)

                            getgenv().poss = plrrlrllr.Character.HumanoidRootPart.Position

                        end
                        if finalMsg == getgenv().prefix .. "setspot" then
                            local args = {
                                [1] = "Set spot successfully!",
                                [2] = "All"
                            }

                            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                unpack(args))
                            local Players = game:GetService("Players")
                            local function getPlayerByUserId(userId)
                                for _, player in pairs(Players:GetPlayers()) do
                                    if player.UserId == userId then
                                        return player
                                    end
                                end
                            end

                            local plrrlrllr = getPlayerByUserId(getgenv().controller)

                            getgenv().poss = plrrlrllr.Character.HumanoidRootPart.Position

                        end

                        if finalMsg == getgenv().prefix .. "money? " .. plr.Name:lower() then

                            local args = {
                                [1] = "I have " ..
                                    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.MoneyText.Text,
                                [2] = "All"
                            }

                            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                unpack(args))

                        end

                        if finalMsg == getgenv().prefix .. "money?" then

                            local args = {
                                [1] = "I have " ..
                                    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.MoneyText.Text,
                                [2] = "All"
                            }

                            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                unpack(args))

                        end
                        if finalMsg == getgenv().prefix .. "tospot " .. plr.Name:lower() then

                            game.Players.LocalPlayer.Character.Head.Anchored = false
                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                                getgenv().poss)
                            wait(0.5)
                            game.Players.LocalPlayer.Character.Head.Anchored = true

                        end
                        if finalMsg == getgenv().prefix .. "tospot" then

                            game.Players.LocalPlayer.Character.Head.Anchored = false
                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                                getgenv().poss)
                            wait(0.5)
                            game.Players.LocalPlayer.Character.Head.Anchored = true

                        end
                        if finalMsg == getgenv().prefix .. "unfly" then
                            endFly()
                        end
                        if finalMsg == getgenv().prefix .. "unfly " .. plr.Name:lower() then
                            endFly()
                        end
                        if finalMsg == getgenv().prefix .. "airlock " .. plr.Name:lower() then
                            game.Players.LocalPlayer.Character.Head.Anchored = false
                            local player = game.Players.LocalPlayer
                            local character = player.Character
                            local humanoid = character:FindFirstChild("Humanoid")
                            local LPlr = game.Players.LocalPlayer
                            local Character = LPlr.Character
                            local HRP = Character:WaitForChild("HumanoidRootPart")
                            humanoid.Jump = true
                            wait(0.3)
                            game.Players.LocalPlayer.Character.Head.Anchored = true

                        end
                        if finalMsg == getgenv().prefix .. "airlock" then
                            game.Players.LocalPlayer.Character.Head.Anchored = false
                            local player = game.Players.LocalPlayer
                            local character = player.Character
                            local humanoid = character:FindFirstChild("Humanoid")
                            local LPlr = game.Players.LocalPlayer
                            local Character = LPlr.Character
                            local HRP = Character:WaitForChild("HumanoidRootPart")
                            humanoid.Jump = true
                            wait(0.3)
                            game.Players.LocalPlayer.Character.Head.Anchored = true

                        end
                        if finalMsg == getgenv().prefix .. "kill" then
                            humanoid.Health = 0
                        end



                        if finalMsg == getgenv().prefix .. "kill " .. plr.Name:lower() then
                            humanoid.Health = 0
                        end

                        if finalMsg == getgenv().prefix .. "kick" then
                            plr:Kick("You've been kicked by the Controller.")
                        end
                        if finalMsg == getgenv().prefix .. "kick " .. plr.Name:lower() then
                            plr:Kick("You've been kicked by the Controller.")
                        end

                        if finalMsg == getgenv().prefix .. "bringalts" then
                            game.Players.LocalPlayer.Character.Head.Anchored = false
                            PlayerHumanoid.RootPart.CFrame = LastTargetPosition + LastTargetPosition.LookVector * Length
                            PlayerHumanoid.RootPart.CFrame =
                                CFrame.new(PlayerHumanoid.RootPart.CFrame.Position, Vector3.new(
                                    LastTargetPosition.Position.X, PlayerHumanoid.RootPart.CFrame.Position.Y,
                                    LastTargetPosition.Position.Z))
                        end

                        if finalMsg == getgenv().prefix .. "bring " .. plr.Name:lower() then
                            game.Players.LocalPlayer.Character.Head.Anchored = false
                            PlayerHumanoid.RootPart.CFrame = LastTargetPosition + LastTargetPosition.LookVector * Length
                            PlayerHumanoid.RootPart.CFrame =
                                CFrame.new(PlayerHumanoid.RootPart.CFrame.Position, Vector3.new(
                                    LastTargetPosition.Position.X, PlayerHumanoid.RootPart.CFrame.Position.Y,
                                    LastTargetPosition.Position.Z))
                        end

                        if finalMsg == getgenv().prefix .. "freeze" then

                            game.Players.LocalPlayer.Character.Head.Anchored = true

                        end

                        if finalMsg == getgenv().prefix .. "freeze " .. plr.Name:lower() then

                            game.Players.LocalPlayer.Character.Head.Anchored = true

                        end
                        if finalMsg == getgenv().prefix .. "unfreeze" then

                            game.Players.LocalPlayer.Character.Head.Anchored = false

                        end
                        if finalMsg == getgenv().prefix .. "unfreeze " .. plr.Name:lower() then

                            game.Players.LocalPlayer.Character.Head.Anchored = false

                        end
                    end
                end

            end
        end
        Player.Chatted:Connect(Chatted)
    end

    local GetPlayers = Players:GetPlayers()
    for i = 1, #GetPlayers do
        local Player = GetPlayers[i]
        coroutine.resume(coroutine.create(function()
            PlayerAdded(Player)
        end))
    end
    Players.PlayerAdded:Connect(PlayerAdded)

    for i, v in pairs(getgenv().alts) do

        if v == game.Players.LocalPlayer.UserId then

            Clip = false

            local speaker = game.Players.LocalPlayer
            wait(0.1)
            local function NoclipLoop()
                if Clip == false and speaker.Character ~= nil then
                    for _, child in pairs(speaker.Character:GetDescendants()) do
                        if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
                            child.CanCollide = false
                        end
                    end
                end
            end
            Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
            workspace:FindFirstChildOfClass('Terrain').WaterWaveSize = 0
            workspace:FindFirstChildOfClass('Terrain').WaterWaveSpeed = 0
            workspace:FindFirstChildOfClass('Terrain').WaterReflectance = 0
            workspace:FindFirstChildOfClass('Terrain').WaterTransparency = 0
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").FogEnd = 9e9
            settings().Rendering.QualityLevel = 1
            for i, v in pairs(game:GetDescendants()) do
                if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or
                    v:IsA("TrussPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                elseif v:IsA("Decal") then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
                elseif v:IsA("Explosion") then
                    v.BlastPressure = 1
                    v.BlastRadius = 1
                end
            end
            for i, v in pairs(game:GetService("Lighting"):GetDescendants()) do
                if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or
                    v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                    v.Enabled = false
                end
            end
            workspace.DescendantAdded:Connect(function(child)
                coroutine.wrap(function()
                    if child:IsA('ForceField') then
                        game:GetService('RunService').Heartbeat:Wait()
                        child:Destroy()
                    elseif child:IsA('Sparkles') then
                        game:GetService('RunService').Heartbeat:Wait()
                        child:Destroy()
                    elseif child:IsA('Smoke') or child:IsA('Fire') then
                        game:GetService('RunService').Heartbeat:Wait()
                        child:Destroy()
                    end
                end)()
            end)

            local timeBegan = tick()
            for i, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = "SmoothPlastic"
                end
            end
            for i, v in ipairs(game:GetService("Lighting"):GetChildren()) do
                v:Destroy()
            end
            local timeEnd = tick() - timeBegan
            local timeMS = math.floor(timeEnd * 1000)

            local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
            local g = game
            local w = g.Workspace
            local l = g.Lighting
            local t = w.Terrain
            t.WaterWaveSize = 0
            t.WaterWaveSpeed = 0
            t.WaterReflectance = 0
            t.WaterTransparency = 0
            l.GlobalShadows = false
            l.FogEnd = 9e9
            l.Brightness = 0
            settings().Rendering.QualityLevel = "Level01"
            for i, v in pairs(g:GetDescendants()) do
                if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
                elseif v:IsA("Explosion") then
                    v.BlastPressure = 1
                    v.BlastRadius = 1
                elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                    v.Enabled = false
                elseif v:IsA("MeshPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                    v.TextureID = 10385902758728957
                end
            end
            for i, e in pairs(l:GetChildren()) do
                if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or
                    e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                    e.Enabled = false
                end
            end

            local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
            local g = game
            local w = g.Workspace
            local l = g.Lighting
            local t = w.Terrain
            t.WaterWaveSize = 0
            t.WaterWaveSpeed = 0
            t.WaterReflectance = 0
            t.WaterTransparency = 0
            l.GlobalShadows = false
            l.FogEnd = 9e9
            l.Brightness = 0
            settings().Rendering.QualityLevel = "Level01"
            for i, v in pairs(g:GetDescendants()) do
                if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
                elseif v:IsA("Explosion") then
                    v.BlastPressure = 1
                    v.BlastRadius = 1
                elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                    v.Enabled = false
                elseif v:IsA("MeshPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                    v.TextureID = 10385902758728957
                end
            end
            for i, e in pairs(l:GetChildren()) do
                if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or
                    e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                    e.Enabled = false
                end
            end


            -- Gui to Lua
            -- Version: 3.2
            game:GetService("RunService"):Set3dRenderingEnabled(false)
            -- Instances:

            local PSiwshuwDUItgsuiz = Instance.new("ScreenGui")
            local Frame = Instance.new("Frame")
            local TextLabel = Instance.new("TextLabel")
            local TextButton = Instance.new("TextButton")
            local UICorner = Instance.new("UICorner")
            local TextButton_2 = Instance.new("TextButton")
            local UICorner_2 = Instance.new("UICorner")
            local TextButton_3 = Instance.new("TextButton")
            local UICorner_3 = Instance.new("UICorner")
            local TextLabel_2 = Instance.new("TextLabel")
            local TextLabel_3 = Instance.new("TextLabel")
            local TextLabel_4 = Instance.new("TextLabel")

            -- Properties:

            PSiwshuwDUItgsuiz.Parent = game.CoreGui
            PSiwshuwDUItgsuiz.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            PSiwshuwDUItgsuiz.IgnoreGuiInset = true
            Frame.Parent = PSiwshuwDUItgsuiz
            Frame.AnchorPoint = Vector2.new(0.5, 0.5)
            Frame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
            Frame.Size = UDim2.new(1, 0, 1, 36)

            TextLabel.Parent = Frame
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1.000
            TextLabel.BorderSizePixel = 0
            TextLabel.Position = UDim2.new(0.379002213, 0, 0.0237247907, 0)
            TextLabel.Size = UDim2.new(0, 325, 0, 54)
            TextLabel.Font = Enum.Font.Code
            TextLabel.Text = "newww"
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14.000
            TextLabel.TextWrapped = true

            local RunService = game:GetService("RunService")
            local MaxFPS = getgenv().altFPS
            while true do
                local t0 = tick()
                RunService.Heartbeat:Wait()
                repeat
                until (t0 + 1 / MaxFPS) < tick()
            end
        end
    end

else
    game.Players.LocalPlayer:Kick("Only da hood.")
end
