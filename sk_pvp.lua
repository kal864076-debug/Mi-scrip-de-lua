--// Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local playerGui = player:WaitForChild("PlayerGui")

--// Crear ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "SK_FloatingGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

--// Botón circular SK arcoíris
local skButton = Instance.new("TextButton")
skButton.Size = UDim2.new(0, 60, 0, 60)
skButton.Position = UDim2.new(0.85, 0, 0.5, 0)
skButton.Text = "SK"
skButton.TextColor3 = Color3.new(1,1,1)
skButton.TextScaled = true
skButton.Font = Enum.Font.GothamBold
skButton.ZIndex = 999
skButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
skButton.Parent = gui

-- Hacerlo circular
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1,0)
corner.Parent = skButton

-- Animación arcoíris en el botón
local hue = 0
RunService.RenderStepped:Connect(function(dt)
	hue = (hue + dt*0.5) % 1
	skButton.BackgroundColor3 = Color3.fromHSV(hue,1,1)
end)

-- Hacerlo arrastrable
local dragging = false
local dragStart, startPos

skButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = skButton.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

skButton.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		skButton.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

--// Panel PVP Velocidad
local speedFrame = Instance.new("Frame")
speedFrame.Size = UDim2.new(0, 220, 0, 140)
speedFrame.Position = UDim2.new(0.7, 0, 0.4, 0)
speedFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
speedFrame.BorderSizePixel = 0
speedFrame.Visible = false
speedFrame.ZIndex = 998
speedFrame.Parent = gui

-- Logo arcoíris
local logo = Instance.new("Frame")
logo.Size = UDim2.new(0,200,0,20)
logo.Position = UDim2.new(0.05,0,0.05,0)
logo.BackgroundColor3 = Color3.fromRGB(255,0,0)
logo.BorderSizePixel = 0
logo.Parent = speedFrame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
	ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255,165,0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,0)),
	ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0,255,0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,255))
}
gradient.Rotation = 45
gradient.Parent = logo

-- Texto de velocidad arcoíris
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.4,0,0,30)
speedLabel.Position = UDim2.new(0.05,0,0.35,0)
speedLabel.Text = "16"
speedLabel.TextColor3 = Color3.fromRGB(255,0,0)
speedLabel.BackgroundTransparency = 1
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextScaled = true
speedLabel.Parent = speedFrame

-- Caja para ajustar velocidad
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.5,0,0,30)
speedBox.Position = UDim2.new(0.45,0,0.35,0)
speedBox.Text = "16"
speedBox.TextColor3 = Color3.new(0,0,0)
speedBox.BackgroundColor3 = Color3.fromRGB(200,200,200)
speedBox.Font = Enum.Font.Gotham
speedBox.TextScaled = true
speedBox.ClearTextOnFocus = false
speedBox.Parent = speedFrame

-- Botón PVP Velocidad arcoíris
local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(0.9,0,0,30)
speedButton.Position = UDim2.new(0.05,0,0.65,0)
speedButton.Text = "PVP Velocidad"
speedButton.TextColor3 = Color3.new(1,1,1)
speedButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
speedButton.Font = Enum.Font.GothamBold
speedButton.TextScaled = true
speedButton.Parent = speedFrame

-- Animar color arcoíris del botón
local hue2 = 0
RunService.RenderStepped:Connect(function(dt)
	hue2 = (hue2 + dt*0.5) % 1
	speedButton.BackgroundColor3 = Color3.fromHSV(hue2,1,1)
end)

-- Mostrar / ocultar panel
skButton.MouseButton1Click:Connect(function()
	speedFrame.Visible = not speedFrame.Visible
end)

-- Función para colores arcoíris en label
local function rainbowLabel(label)
	local hue = 0
	RunService.RenderStepped:Connect(function(dt)
		hue = (hue + dt*0.5) % 1
		label.TextColor3 = Color3.fromHSV(hue,1,1)
	end)
end

rainbowLabel(speedLabel)

-- Mensaje SK en pantalla abajo
local function showMessage(text, duration)
	local msgLabel = Instance.new("TextLabel")
	msgLabel.Size = UDim2.new(0.4,0,0,50)
	msgLabel.Position = UDim2.new(0.3,0,0.85,0)
	msgLabel.Text = text
	msgLabel.TextScaled = true
	msgLabel.TextColor3 = Color3.fromRGB(255,255,255)
	msgLabel.BackgroundTransparency = 0.5
	msgLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
	msgLabel.Font = Enum.Font.GothamBold
	msgLabel.ZIndex = 999
	msgLabel.Parent = gui

	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TweenService:Create(msgLabel, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1})
	tween:Play()
	tween.Completed:Connect(function()
		msgLabel:Destroy()
	end)
end

-- Animación grande SK al presionar el botón
local function showSKAnimation(duration)
	local skAnim = Instance.new("TextLabel")
	skAnim.Size = UDim2.new(0.3,0,0.2,0)
	skAnim.Position = UDim2.new(0.35,0,0.4,0)
	skAnim.Text = "SK"
	skAnim.TextScaled = true
	skAnim.Font = Enum.Font.GothamBlack
	skAnim.TextColor3 = Color3.fromRGB(255,255,255)
	skAnim.BackgroundTransparency = 0.7
	skAnim.Parent = gui
	skAnim.ZIndex = 1000

	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TweenService:Create(skAnim, tweenInfo, {TextTransparency = 1, BackgroundTransparency = 1})
	tween:Play()
	tween.Completed:Connect(function()
		skAnim:Destroy()
	end)
end

-- Activar boost de velocidad PVP
speedButton.MouseButton1Click:Connect(function()
	local value = tonumber(speedBox.Text)
	if value and value >= 1 and value <= 100 then
		humanoid.WalkSpeed = value
		speedLabel.Text = tostring(value)
		showMessage("SK Activado", 2)
		showSKAnimation(5)
	else
		warn("Ingresa un valor válido entre 1 y 100")
	end
end)
