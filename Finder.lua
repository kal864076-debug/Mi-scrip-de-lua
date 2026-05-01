-- XZ FINDER 😁Instakill

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
local KnifeKillRemote = Remotes and Remotes:FindFirstChild("KnifeKill")

local IsActive = false
local Connections = {}
local ActiveCoroutines = {}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "B3tterDex_Instakill"
ScreenGui.Parent = game.CoreGui

local CreditLabel = Instance.new("TextLabel")
CreditLabel.Size = UDim2.new(0, 280, 0, 40)
CreditLabel.Position = UDim2.new(0.5, -140, 0.85, 0)
CreditLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
CreditLabel.BackgroundTransparency = 0.4
CreditLabel.Text = "ZX FINDER CREADOR 🫰"
CreditLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditLabel.Font = Enum.Font.GothamBold
CreditLabel.TextSize = 14
CreditLabel.TextTransparency = 0.1
CreditLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
CreditLabel.TextStrokeTransparency = 0.5
CreditLabel.TextWrapped = true
CreditLabel.Parent = ScreenGui

local CreditCorner = Instance.new("UICorner")
CreditCorner.CornerRadius = UDim.new(0, 12)
CreditCorner.Parent = CreditLabel

local CreditStroke = Instance.new("UIStroke")
CreditStroke.Thickness = 2
CreditStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CreditStroke.Color = Color3.fromRGB(0, 150, 255)
CreditStroke.Transparency = 0.3
CreditStroke.Parent = CreditLabel

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 150, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -75, 0.8, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ToggleButton.BackgroundTransparency = 0.3
ToggleButton.Text = "Instakill: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 18
ToggleButton.TextTransparency = 0.1
ToggleButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextStrokeTransparency = 0.5
ToggleButton.Parent = ScreenGui

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 10)
ButtonCorner.Parent = ToggleButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Thickness = 3
ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ButtonStroke.Color = Color3.fromRGB(0, 150, 255)
ButtonStroke.Transparency = 0.2
ButtonStroke.Parent = ToggleButton

local IsDragging = false
local DragInput, DragStart, StartPosition

ToggleButton.MouseEnter:Connect(function()
TweenService:Create(ToggleButton, TweenInfo.new(0.3), {
BackgroundTransparency = 0.1,
TextTransparency = 0
}):Play()
TweenService:Create(ButtonStroke, TweenInfo.new(0.3), {
Thickness = 4,
Color = Color3.fromRGB(255, 255, 255)
}):Play()
end)

ToggleButton.MouseLeave:Connect(function()
TweenService:Create(ToggleButton, TweenInfo.new(0.3), {
BackgroundTransparency = 0.3,
TextTransparency = 0.1
}):Play()
TweenService:Create(ButtonStroke, TweenInfo.new(0.3), {
Thickness = 3,
Color = Color3.fromRGB(0, 150, 255)
}):Play()
end)

ToggleButton.InputBegan:Connect(function(Input)
if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
IsDragging = true
DragStart = Input.Position
StartPosition = ToggleButton.Position
Input.Changed:Connect(function()
if Input.UserInputState == Enum.UserInputState.End then
IsDragging = false
end
end)
end
end)

ToggleButton.InputChanged:Connect(function(Input)
if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
DragInput = Input
end
end)

UserInputService.InputChanged:Connect(function(Input)
if IsDragging and Input == DragInput then
local Delta = Input.Position - DragStart
ToggleButton.Position = UDim2.new(
StartPosition.X.Scale, StartPosition.X.Offset + Delta.X,
StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y
)
end
end)

local function GetKnifeAndRemote()
for _, Tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
if Tool:IsA("Tool") and Tool:FindFirstChild("kill") then
return Tool, Tool.kill
end
end
if LocalPlayer.Character then
for _, Tool in ipairs(LocalPlayer.Character:GetChildren()) do
if Tool:IsA("Tool") and Tool:FindFirstChild("kill") then
return Tool, Tool.kill
end
end
end
return nil, nil
end

local function GetEnemies()
local Team = LocalPlayer:GetAttribute("Team")
local Enemies = {}
if not Team then return Enemies end
for _, P in ipairs(Players:GetPlayers()) do
if P ~= LocalPlayer and P:GetAttribute("Team") ~= Team and P.Character and P.Character:FindFirstChild("HumanoidRootPart") then
Enemies[#Enemies + 1] = P
end
end
return Enemies
end

local function FireAllKills(KillsPerEnemy)
local KnifeTool, KillRemote = GetKnifeAndRemote()
if not KnifeTool or not KnifeTool:FindFirstChild("Handle") then return end

local Enemies = GetEnemies()
if #Enemies == 0 then return end
local HandlePos = KnifeTool.Handle.Position

for _, Enemy in ipairs(Enemies) do
local HRP = Enemy.Character and Enemy.Character:FindFirstChild("HumanoidRootPart")
if HRP then
local Dir = (HRP.Position - HandlePos).Unit
for _ = 1, KillsPerEnemy do
if KnifeKillRemote then
KnifeKillRemote:FireServer(Enemy, Enemy)
end
if KillRemote then
KillRemote:FireServer(Enemy, Dir)
end
end
end
end

end

local function StartKilling()
if Connections.Heartbeat then Connections.Heartbeat:Disconnect() end
for _, co in ipairs(ActiveCoroutines) do
coroutine.close(co)
end
ActiveCoroutines = {}
Connections = {}

Connections.Heartbeat = RunService.Heartbeat:Connect(function(dt)
local kills = math.floor(35 + dt * 200)
if kills > 50 then kills = 50 end
FireAllKills(kills)
end)

for _ = 1, 8 do
local co = coroutine.create(function()
while IsActive do
local dt = RunService.Heartbeat:Wait()
local kills = math.floor(25 + dt * 150)
if kills > 40 then kills = 40 end
FireAllKills(kills)
end
end)
ActiveCoroutines[#ActiveCoroutines + 1] = co
coroutine.resume(co)
end

for _ = 1, 6 do
local co = coroutine.create(function()
while IsActive do
FireAllKills(20)
task.wait(0)
end
end)
ActiveCoroutines[#ActiveCoroutines + 1] = co
coroutine.resume(co)
end

for _ = 1, 6 do
task.spawn(function()
while IsActive do
FireAllKills(18)
task.wait(0)
end
end)
end

end

local function StopKilling()
if Connections.Heartbeat then Connections.Heartbeat:Disconnect() end
for _, co in ipairs(ActiveCoroutines) do
coroutine.close(co)
end
ActiveCoroutines = {}
Connections = {}
end

ToggleButton.MouseButton1Click:Connect(function()
IsActive = not IsActive
ToggleButton.Text = IsActive and "Instakill: ON" or "Instakill: OFF"
ButtonStroke.Color = IsActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 150, 255)

if IsActive then
StartKilling()
else
StopKilling()
end

end)
