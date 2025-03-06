local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local flying = false
local noclip = false
local speed = 50
local walkSpeed = 16

-- Fly Components
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
bodyGyro.P = 5000

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 250)
Frame.Position = UDim2.new(0.8, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2

-- Create a button function
local function createButton(name, parent, position, callback)
    local button = Instance.new("TextButton", parent)
    button.Size = UDim2.new(0, 180, 0, 40)
    button.Position = UDim2.new(0, 10, 0, position)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = name
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Toggle Fly
local function toggleFly()
    flying = not flying
    if flying then
        bodyVelocity.Parent = humanoidRootPart
        bodyGyro.Parent = humanoidRootPart
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    else
        bodyVelocity.Parent = nil
        bodyGyro.Parent = nil
    end
end

-- Toggle Noclip
local function toggleNoclip()
    noclip = not noclip
    while noclip do
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
        wait()
    end
end

-- Toggle Walkspeed
local function toggleWalkspeed()
    if humanoid.WalkSpeed == 16 then
        humanoid.WalkSpeed = walkSpeed
    else
        humanoid.WalkSpeed = 16
    end
end

-- Fly Movement (Camera Based)
local function updateMovement()
    if not flying then return end
    local cam = workspace.CurrentCamera
    local moveDir = Vector3.new(0, 0, 0)

    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
        moveDir = moveDir + cam.CFrame.LookVector
    end
    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
        moveDir = moveDir - cam.CFrame.LookVector
    end
    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
        moveDir = moveDir - cam.CFrame.RightVector
    end
    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
        moveDir = moveDir + cam.CFrame.RightVector
    end
    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
        moveDir = moveDir + Vector3.new(0, 1, 0)
    end
    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
        moveDir = moveDir - Vector3.new(0, 1, 0)
    end

    bodyVelocity.Velocity = moveDir.Unit * speed
end

game:GetService("RunService").Heartbeat:Connect(updateMovement)

-- Create Buttons
createButton("Toggle Fly", Frame, 10, toggleFly)
createButton("Toggle Noclip", Frame, 60, toggleNoclip)
createButton("Toggle Walkspeed", Frame, 110, toggleWalkspeed)

-- Sliders for Speed Control
local function createSlider(name, parent, position, min, max, callback)
    local box = Instance.new("TextBox", parent)
    box.Size = UDim2.new(0, 180, 0, 40)
    box.Position = UDim2.new(0, 10, 0, position)
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Text = name
    box.FocusLost:Connect(function()
        local value = tonumber(box.Text)
        if value and value >= min and value <= max then
            callback(value)
        else
            box.Text = name
        end
    end)
    return box
end

createSlider("Fly Speed (50)", Frame, 160, 10, 200, function(val) speed = val end)
createSlider("Walk Speed (16)", Frame, 210, 5, 100, function(val) walkSpeed = val end)

-- Footer (RGB Effect)
local Footer = Instance.new("TextLabel", Frame)
Footer.Size = UDim2.new(0, 200, 0, 20)
Footer.Position = UDim2.new(0, 0, 1, -20)
Footer.Text = "Script by WonderfulGamingRPG"
Footer.TextColor3 = Color3.fromRGB(255, 0, 0)
Footer.BackgroundTransparency = 1

local function updateFooterColor()
    while true do
        for i = 0, 255, 5 do
            Footer.TextColor3 = Color3.fromRGB(i, 0, 255 - i)
            wait(0.05)
        end
        for i = 0, 255, 5 do
            Footer.TextColor3 = Color3.fromRGB(255 - i, i, 0)
            wait(0.05)
        end
    end
end

spawn(updateFooterColor)
