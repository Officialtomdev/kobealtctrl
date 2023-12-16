local localplr = game.Players.LocalPlayer

-- Wait until the character is available
localplr.CharacterAdded:Connect(function(character)
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local rootCFrame = humanoidRootPart.CFrame
    print("X:", rootCFrame.X, "Y:", rootCFrame.Y, "Z:", rootCFrame.Z)
    setclipboard("X:", rootCFrame.X, "Y:", rootCFrame.Y, "Z:", rootCFrame.Z)
end)

-- If the character is already available
if localplr.Character then
    local humanoidRootPart = localplr.Character:WaitForChild("HumanoidRootPart")
    local rootCFrame = humanoidRootPart.CFrame
    print("X:", rootCFrame.X, "Y:", rootCFrame.Y, "Z:", rootCFrame.Z)
    setclipboard(rootCFrame.X, rootCFrame.Y, rootCFrame.Z)
    setclipboard("X:" .. rootCFrame.X, rootCFrame.Y, rootCFrame)
end








--function notif(title,text)
--    if text then
--        game:GetService("StarterGui"):SetCore("SendNotification",{tostring(title),tostring(text)})
--    else
--        game:GetService("StarterGui"):SetCore("SendNotification",{tostring(title),tostring(title)})
--    end
--end
--local notdestroyed = true
--local localplr = game.Players.LocalPlayer
--cframegui = Instance.new("ScreenGui")
--cframegui.Parent = game.CoreGui
--local mainframe = Instance.new("Frame")
--mainframe.Parent = cframegui
--mainframe.Size = UDim2.new(.2,0,.15,0)
--mainframe.Position = UDim2.new(.4,0,.435)
--mainframe.Active = true
--mainframe.Draggable = true
--mainframe.BackgroundColor3 = Color3.fromRGB(40,40,40)
--local credits = Instance.new("TextLabel")
--credits.Parent = mainframe
--credits.Size = UDim2.new(1,0,.3)
--credits.Text = "Original by Jmuse, Remake by 2AreYouMental110"
--credits.BackgroundColor3 = Color3.fromRGB(50,50,50)
--credits.TextColor3 = Color3.fromRGB(255,255,255)
--credits.TextScaled = true
--local copycframe = Instance.new("TextButton")
--copycframe.Parent = mainframe
--copycframe.Size = UDim2.new(1,0,.7)
--copycframe.Position = UDim2.new(0,0,0.3)
--copycframe.BackgroundColor3 = Color3.fromRGB(60,60,60)
--copycframe.TextColor3 = Color3.fromRGB(255,255,255)
--copycframe.TextScaled = true
--copycframe.Text = "Click To Copy"
--local a = copycframe.MouseButton1Click:Connect(function()
--    if localplr.Character ~= nil and localplr.Character:FindFirstChild("HumanoidRootPart") then
--        setclipboard("CFrame.new("..tostring(localplr.Character.HumanoidRootPart.CFrame)..")")
--        copycframe.Text = "Copied!"
--        notif("Copied!")
--    else
--        copycframe.Text = "Can't find character or humanoidrootpart!"
--    end
--end)
--local b = cframegui.Destroying:Connect(function()
--    notdestroyed = false
--end)
--wait(4)
--while notdestroyed do
--    wait(1)
--    if localplr.Character ~= nil and localplr.Character:FindFirstChild("HumanoidRootPart") then
--        copycframe.Text = tostring(localplr.Character.HumanoidRootPart.CFrame)
--    else
--        copycframe.Text = "Can't find character or humanoidrootpart!"
--    end
--end
--a:Disconnect()
--b:Disconnect()


function notif(title, text)
    if text then
        game:GetService("StarterGui"):SetCore("SendNotification", {tostring(title), tostring(text)})
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {tostring(title), tostring(title)})
    end
end

local localplr = game.Players.LocalPlayer

local cframegui = Instance.new("ScreenGui")
cframegui.Parent = game.CoreGui

local mainframe = Instance.new("Frame")
mainframe.Parent = cframegui
mainframe.Size = UDim2.new(.2, 0, .15, 0)
mainframe.Position = UDim2.new(.4, 0, .435, 0)
mainframe.Active = true
mainframe.Draggable = true
mainframe.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local credits = Instance.new("TextLabel")
credits.Parent = mainframe
credits.Size = UDim2.new(1, 0, .3, 0)
credits.Text = "meee"
credits.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
credits.TextColor3 = Color3.fromRGB(255, 255, 255)
credits.TextScaled = true

local copycframe = Instance.new("TextBox") -- Using TextBox for selectable text
copycframe.Parent = mainframe
copycframe.Size = UDim2.new(1, 0, .7, 0)
copycframe.Position = UDim2.new(0, 0, 0.3, 0)
copycframe.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
copycframe.TextColor3 = Color3.fromRGB(255, 255, 255)
copycframe.TextScaled = true
copycframe.TextEditable = false -- Making the text uneditable

local updateFrame = true

local updateCFrameDisplay = function()
    if localplr.Character and localplr.Character:FindFirstChild("HumanoidRootPart") then
        local cframe = localplr.Character.HumanoidRootPart.CFrame
        local posX, posY, posZ = cframe.Position.X, cframe.Position.Y, cframe.Position.Z
        copycframe.Text = string.format("X: %.2f, Y: %.2f, Z: %.2f", posX, posY, posZ)
    else
        copycframe.Text = "Can't find character or HumanoidRootPart!"
    end
end

updateCFrameDisplay() -- Initial update

spawn(function()
    while updateFrame do
        wait(0.0001)
        updateCFrameDisplay()
    end
end)

copycframe.MouseButton1Click:Connect(function()
    if copycframe.Text ~= "Can't find character or HumanoidRootPart!" then
        notif("Copied!")
        copycframe:CaptureFocus() -- Focus on the textbox
        copycframe:SelectAll() -- Select all text
        wait() -- Wait a frame for selection to happen
        game:GetService("GuiService"):AddSelectionParent("CFrameSelection", copycframe) -- Allow copying
    end
end)

cframegui.AncestryChanged:Connect(function(_, parent)
    if parent == nil then
        updateFrame = false
    end
end)
