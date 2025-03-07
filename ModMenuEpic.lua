--// Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local uis = game:GetService("UserInputService")
local runService = game:GetService("RunService")

--// UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Mod Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1

--// Close Button
local CloseButton = Instance.new("TextButton", MainFrame)
CloseButton.Size = UDim2.new(0, 60, 0, 30)
CloseButton.Position = UDim2.new(1, -65, 0, 5)
CloseButton.Text = "Close"
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

--// Minimize Button
local MinimizeButton = Instance.new("TextButton", MainFrame)
MinimizeButton.Size = UDim2.new(0, 60, 0, 30)
MinimizeButton.Position = UDim2.new(1, -130, 0, 5)
MinimizeButton.Text = "Minimize"

local Minimized = false
local MinimizedIcon = Instance.new("TextButton", ScreenGui)
MinimizedIcon.Size = UDim2.new(0, 50, 0, 50)
MinimizedIcon.Position = UDim2.new(0.9, 0, 0.1, 0)
MinimizedIcon.Text = "RPG"
MinimizedIcon.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
MinimizedIcon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinimizedIcon.Visible = false

MinimizeButton.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    MainFrame.Visible = not Minimized
    MinimizedIcon.Visible = Minimized
end)

MinimizedIcon.MouseButton1Click:Connect(function()
    Minimized = false
    MainFrame.Visible = true
    MinimizedIcon.Visible = false
end)

--// Fly Variables
local flying = false
local speed = 50
local bodyVelocity = Instance.new("BodyVelocity")
local bodyGyro = Instance.new("BodyGyro")

bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

--// Toggle Fly
local function toggleFly()
    flying = not flying
    if flying then
        bodyVelocity.Parent = humanoidRootPart
        bodyGyro.Parent = humanoidRootPart
    else
        bodyVelocity.Parent = nil
        bodyGyro.Parent = nil
    end
end

--// Fly Movement
local function updateMovement()
    if not flying then return end
    local cam = workspace.CurrentCamera
    local moveDir = Vector3.new(0, 0, 0)

    if uis:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
    if uis:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
    if uis:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
    if uis:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
    if uis:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
    if uis:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end

    bodyVelocity.Velocity = moveDir.Unit * speed
end

runService.Heartbeat:Connect(updateMovement)

--// Noclip
local noclip = false
local function toggleNoclip()
    noclip = not noclip
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = not noclip
        end
    end
end

--// WalkSpeed
local function setWalkSpeed(value)
    if character:FindFirstChildOfClass("Humanoid") then
        character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
    end
end

--// UI Elements
local FlyButton = Instance.new("TextButton", MainFrame)
FlyButton.Size = UDim2.new(1, -10, 0, 30)
FlyButton.Position = UDim2.new(0, 5, 0, 40)
FlyButton.Text = "Toggle Fly"
FlyButton.MouseButton1Click:Connect(toggleFly)

local FlySpeedSlider = Instance.new("TextButton", MainFrame)
FlySpeedSlider.Size = UDim2.new(1, -10, 0, 30)
FlySpeedSlider.Position = UDim2.new(0, 5, 0, 80)
FlySpeedSlider.Text = "Fly Speed: "..speed
FlySpeedSlider.MouseButton1Click:Connect(function()
    speed = speed + 10
    if speed > 100 then speed = 10 end
    FlySpeedSlider.Text = "Fly Speed: "..speed
end)

local NoclipButton = Instance.new("TextButton", MainFrame)
NoclipButton.Size = UDim2.new(1, -10, 0, 30)
NoclipButton.Position = UDim2.new(0, 5, 0, 120)
NoclipButton.Text = "Toggle Noclip"
NoclipButton.MouseButton1Click:Connect(toggleNoclip)

local WalkSpeedSlider = Instance.new("TextButton", MainFrame)
WalkSpeedSlider.Size = UDim2.new(1, -10, 0, 30)
WalkSpeedSlider.Position = UDim2.new(0, 5, 0, 160)
WalkSpeedSlider.Text = "WalkSpeed: 16"
WalkSpeedSlider.MouseButton1Click:Connect(function()
    local newSpeed = (character:FindFirstChildOfClass("Humanoid").WalkSpeed + 5) % 50
    setWalkSpeed(newSpeed)
    WalkSpeedSlider.Text = "WalkSpeed: "..newSpeed
end)

--// Footer
local Footer = Instance.new("TextLabel", MainFrame)
Footer.Size = UDim2.new(1, 0, 0, 20)
Footer.Position = UDim2.new(0, 0, 1, -20)
Footer.Text = "Script By WonderfulGamingRPG"
Footer.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
Footer.BackgroundTransparency = 1
