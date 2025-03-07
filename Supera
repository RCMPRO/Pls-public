--// Main Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:FindFirstChildOfClass("Humanoid")
local flying = false
local noclip = false
local flySpeed = 50
local walkSpeed = 16

--// GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local ModMenu = Instance.new("Frame")
ModMenu.Size = UDim2.new(0, 200, 0, 250)
ModMenu.Position = UDim2.new(0.1, 0, 0.1, 0)
ModMenu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ModMenu.Active = true
ModMenu.Draggable = true
ModMenu.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Text = "Mod Menu"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Parent = ModMenu

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "-"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
MinimizeButton.Parent = ModMenu

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Parent = ModMenu

local FlyToggle = Instance.new("TextButton")
FlyToggle.Text = "Fly [OFF]"
FlyToggle.Size = UDim2.new(1, 0, 0, 40)
FlyToggle.Position = UDim2.new(0, 0, 0, 40)
FlyToggle.Parent = ModMenu

local FlySpeedSlider = Instance.new("TextButton")
FlySpeedSlider.Text = "Fly Speed: 50"
FlySpeedSlider.Size = UDim2.new(1, 0, 0, 40)
FlySpeedSlider.Position = UDim2.new(0, 0, 0, 80)
FlySpeedSlider.Parent = ModMenu

local NoclipToggle = Instance.new("TextButton")
NoclipToggle.Text = "Noclip [OFF]"
NoclipToggle.Size = UDim2.new(1, 0, 0, 40)
NoclipToggle.Position = UDim2.new(0, 0, 0, 120)
NoclipToggle.Parent = ModMenu

local WalkSpeedSlider = Instance.new("TextButton")
WalkSpeedSlider.Text = "WalkSpeed: 16"
WalkSpeedSlider.Size = UDim2.new(1, 0, 0, 40)
WalkSpeedSlider.Position = UDim2.new(0, 0, 0, 160)
WalkSpeedSlider.Parent = ModMenu

local Footer = Instance.new("TextLabel")
Footer.Text = "Script By WonderfulGamingRPG"
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.BackgroundTransparency = 1
Footer.Parent = ModMenu

--// Minimize Feature
local Minimized = false
local RPGButton = nil

MinimizeButton.MouseButton1Click:Connect(function()
    if Minimized then
        ModMenu.Visible = true
        if RPGButton then RPGButton:Destroy() end
    else
        ModMenu.Visible = false
        RPGButton = Instance.new("TextButton")
        RPGButton.Text = "RPG"
        RPGButton.Size = UDim2.new(0, 50, 0, 50)
        RPGButton.Position = UDim2.new(0.5, -25, 0.5, -25)
        RPGButton.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        RPGButton.TextColor3 = Color3.new(1, 1, 1)
        RPGButton.Parent = ScreenGui
        RPGButton.Draggable = true
        RPGButton.MouseButton1Click:Connect(function()
            ModMenu.Visible = true
            RPGButton:Destroy()
        end)
    end
    Minimized = not Minimized
end)

--// Close Button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

--// Fly System
local function ToggleFly()
    flying = not flying
    if flying then
        FlyToggle.Text = "Fly [ON]"
        local BodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
        BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        game:GetService("RunService").RenderStepped:Connect(function()
            if flying then
                local cam = workspace.CurrentCamera
                local direction = cam.CFrame.LookVector
                BodyVelocity.Velocity = direction * flySpeed
            end
        end)
    else
        FlyToggle.Text = "Fly [OFF]"
        humanoidRootPart:FindFirstChild("BodyVelocity"):Destroy()
    end
end
FlyToggle.MouseButton1Click:Connect(ToggleFly)

--// Fly Speed Adjust
FlySpeedSlider.MouseButton1Click:Connect(function()
    flySpeed = flySpeed + 10
    if flySpeed > 100 then flySpeed = 10 end
    FlySpeedSlider.Text = "Fly Speed: " .. flySpeed
end)

--// Noclip
local function ToggleNoclip()
    noclip = not noclip
    NoclipToggle.Text = noclip and "Noclip [ON]" or "Noclip [OFF]"
    while noclip do
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
        task.wait()
    end
end
NoclipToggle.MouseButton1Click:Connect(ToggleNoclip)

--// WalkSpeed Adjust
WalkSpeedSlider.MouseButton1Click:Connect(function()
    walkSpeed = walkSpeed + 5
    if walkSpeed > 50 then walkSpeed = 16 end
    humanoid.WalkSpeed = walkSpeed
    WalkSpeedSlider.Text = "WalkSpeed: " .. walkSpeed
end)
