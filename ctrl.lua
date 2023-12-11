local CmdSettings = {}


local Connections = {}

local Services = {
	["Players"] = game:GetService("Players")
}

local Variables = {
	Player = game.Players.LocalPlayer
}

local function AirLock(Type)
	if CmdSettings["AirLock"] == nil and Type == true then
		local BP = Variables["Player"].Character.HumanoidRootPart:FindFirstChild("AirLockBP")
		if BP then
			BP:Destroy()
		end
		CmdSettings["AirLock"] = true
		Variables["Player"].Character.HumanoidRootPart.CFrame = Variables["Player"].Character.HumanoidRootPart.CFrame*CFrame.new(0,10,0)
		local BP = Instance.new("BodyPosition",Variables["Player"].Character.HumanoidRootPart)
		BP.Name = "AirLockBP"
		BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		BP.Position = Variables["Player"].Character.HumanoidRootPart.Position
	elseif CmdSettings["AirLock"] == true and Type == false then
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

local function AirLock(Type)
    local BP = game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("AirLockBP")
    if BP then
        BP:Destroy()
    end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
    local BP = Instance.new("BodyPosition", game.Players.LocalPlayer.Character.HumanoidRootPart)
    BP.Name = "AirLockBP"
    BP.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    BP.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    local BP = game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("AirLockBP")
    if BP then
        BP:Destroy()
    end
end

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

if game.PlaceId == 2788229376 then
    getgenv().isDropping = false
    getgenv().airlock = false
    local speed = 50
    local c
    local h
    local bv
    local bav
    local cam
    local flying
    local p = game.Players.LocalPlayer

    local Players = game:GetService('Players')

    Players.PlayerAdded:Connect(function(player)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Someone joined!",
            Text = player.name .. " joined the game.",
            Duration = 5
        })
        print("someone joined the game")
    end)

    local function PlayerAdded(Player)
        local function Chatted(Message)
            local plr = game.Players.LocalPlayer

            if Player.UserId == getgenv().controller then
                local finalMsg = Message:lower()
                for i, v in pairs(getgenv().alts) do
                    if v == plr.UserId then

                        if finalMsg == getgenv().prefix .. "setup bank" then
                            game.Players.LocalPlayer.Character.Head.Anchored = false

                            local controllerId = getgenv().controller -- Replace with the ID of the controller
                            local controller = game:GetService("Players"):GetPlayerByUserId(controllerId)

                            for i, v in pairs(getgenv().alts) do
                                if i == "Alt1" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-389, 21, -338)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt2" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-385, 21, -338)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt3" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-380, 21, -337)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt4" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-376, 21, -338)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt5" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-370, 21, -338)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt6" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-366, 21, -338)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt7" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-361, 21, -338)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt8" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-361, 21, -333)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt9" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-365, 21, -334)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt10" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-370, 21, -334)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt11" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-375, 21, -334)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt12" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-381, 21, -334)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt13" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-386, 21, -334)
                                        AirLock(true)

                                    end
                                end
                                if i == "Alt14" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-390, 21, -334)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt15" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-390, 21, -331)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt16" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-386, 21, -331)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt17" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-382, 21, -331)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt18" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-376, 21, -331)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt19" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-371, 21, -331)
                                        AirLock(true)

                                    end
                                end
                                if i == "Alt20" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-366, 21, -331)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt21" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-361, 21, -331)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt22" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-361, 21, -327)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt23" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-365, 21, -327)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt24" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-371, 21, -326)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt25" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-376, 21, -327)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt26" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-381, 21, -326)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt27" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-385, 21, -327)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt28" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-390, 21, -323)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt29" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-390, 21, -326)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt30" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-390, 21, -323)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt31" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-385, 21, -323)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt32" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-381, 21, -323)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt33" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-375, 21, -324)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt34" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-370, 21, -323)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt35" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-365, 21, -324)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt36" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-360, 21, -324)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt37" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-359, 21, -318)
                                        AirLock(true)
                                    end
                                end
                                if i == "Alt38" then
                                    if v == plr.UserId then
                                        game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            CFrame.new(-364, 21, -319)

                                        AirLock(true)
                                    end
                                end
                            end
                        end

                        if finalMsg == getgenv().prefix .. "drop" then

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


                           if finalMsg == getgenv().prefix .. "airlock" then
                               Airlock(true)

                           end

                            if finalMsg == getgenv().prefix .. "stopairlock" then
                                Airlock(false)
                             end
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

    if game.Players.LocalPlayer.UserId == getgenv().controller then

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
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or
                v:IsA("DepthOfFieldEffect") then
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
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or
                e:IsA("DepthOfFieldEffect") then
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
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or
                e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
    end

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

            game:GetService("RunService"):Set3dRenderingEnabled(false)

            local PSiwshuwDUItgsuiz = Instance.new("ScreenGui")
            local Frame = Instance.new("Frame")
            local TextLabel = Instance.new("TextLabel")

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
            TextLabel.Text = "Kobe's Alt Control Made By tomdevw"
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
    game.Players.LocalPlayer:Kick("Only Works For Da Hood")
    print("rip")
end