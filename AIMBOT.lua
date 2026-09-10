--==================================================
-- DYV HUB - MOBILE EDITION
-- Para usar no seu próprio jogo Roblox
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local GREEN = Color3.fromRGB(50, 255, 120)
local DARK = Color3.fromRGB(8, 12, 10)
local BLACK = Color3.fromRGB(3, 5, 4)

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "DYV_HUB"
gui.ResetOnSpawn = false
gui.Parent = playerGui

--==================================================
-- INTRO
--==================================================

local intro = Instance.new("TextLabel")
intro.Size = UDim2.fromScale(1, 1)
intro.BackgroundColor3 = BLACK
intro.BackgroundTransparency = 1
intro.Text = "DYV HUB"
intro.TextColor3 = GREEN
intro.TextScaled = true
intro.Font = Enum.Font.GothamBold
intro.TextTransparency = 1
intro.Parent = gui

TweenService:Create(
	intro,
	TweenInfo.new(1.5),
	{
		BackgroundTransparency = 0,
		TextTransparency = 0
	}
):Play()

task.wait(5)

TweenService:Create(
	intro,
	TweenInfo.new(1.5),
	{
		BackgroundTransparency = 1,
		TextTransparency = 1
	}
):Play()

task.wait(1.6)
intro:Destroy()

--==================================================
-- MENU
--==================================================

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(350, 420)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = DARK
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 18)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = GREEN
mainStroke.Thickness = 1.5
mainStroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 45)
title.Position = UDim2.fromOffset(18, 10)
title.BackgroundTransparency = 1
title.Text = "DYV HUB"
title.TextColor3 = GREEN
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local smallTitle = Instance.new("TextLabel")
smallTitle.Size = UDim2.fromOffset(80, 25)
smallTitle.Position = UDim2.new(1, -90, 0, 15)
smallTitle.BackgroundTransparency = 1
smallTitle.Text = "DYV HUB"
smallTitle.TextColor3 = GREEN
smallTitle.TextSize = 11
smallTitle.Font = Enum.Font.GothamBold
smallTitle.Parent = main

--==================================================
-- CRIAR BOTÃO
--==================================================

local function createButton(text, y)

	local button = Instance.new("TextButton")

	button.Size = UDim2.new(1, -36, 0, 48)
	button.Position = UDim2.fromOffset(18, y)

	button.BackgroundColor3 = BLACK
	button.Text = text

	button.TextColor3 = GREEN
	button.TextSize = 15
	button.Font = Enum.Font.GothamBold

	button.AutoButtonColor = false
	button.Parent = main

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Color = GREEN
	stroke.Thickness = 1
	stroke.Parent = button

	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(15, 35, 22)
	end)

	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = BLACK
	end)

	return button
end

local flyButton = createButton("✈  FLY", 65)
local speedButton = createButton("⚡  SPEED", 120)
local teleportButton = createButton("◉  TELEPORTAR", 175)
local followButton = createButton("👥  SEGUIR PLAYER", 230)
local calculatorButton = createButton("▣  CALCULADORA", 285)

--==================================================
-- BOTÃO DO MENU (FOTO + SOM)
--==================================================

local toggle = Instance.new("ImageButton")
toggle.Size = UDim2.fromOffset(55, 55)
toggle.Position = UDim2.new(1, -70, 0, 15)
toggle.BackgroundColor3 = BLACK
toggle.Image = "rbxassetid://117030398995934"
toggle.ImageColor3 = GREEN
toggle.AutoButtonColor = false
toggle.Parent = gui

local tc = Instance.new("UICorner")
tc.CornerRadius = UDim.new(0, 14)
tc.Parent = toggle

local ts = Instance.new("UIStroke")
ts.Color = GREEN
ts.Thickness = 1.5
ts.Parent = toggle

-- SOM DO MENU
local openSound = Instance.new("Sound")
openSound.SoundId = "rbxassetid://118702070205579"
openSound.Volume = 1
openSound.Parent = gui

--==================================================
-- ARRASTAR MENU
--==================================================

local dragging = false
local dragStart
local startPos

local function updateDrag(input)
	local delta = input.Position - dragStart
	main.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

main.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then
		updateDrag(input)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then
		updateDrag(input)
	end
end)

--==================================================
-- ABRIR / FECHAR
--==================================================

local menuOpen = true

toggle.MouseButton1Click:Connect(function()

	menuOpen = not menuOpen

	if menuOpen then

		-- Toca o som
		openSound:Play()

		main.Visible = true
		main.BackgroundTransparency = 1

		TweenService:Create(
			main,
			TweenInfo.new(0.4),
			{BackgroundTransparency = 0}
		):Play()

	else

		TweenService:Create(
			main,
			TweenInfo.new(0.4),
			{BackgroundTransparency = 1}
		):Play()

		task.wait(0.4)

		if not menuOpen then
			main.Visible = false
		end
	end
end)

--==================================================
-- FLY MOBILE
--==================================================

local flying = false
local flyVelocity
local flyConnection

local flyControls = Instance.new("Frame")
flyControls.Size = UDim2.fromOffset(170, 130)
flyControls.Position = UDim2.new(0, 20, 1, -150)
flyControls.BackgroundTransparency = 1
flyControls.Visible = false
flyControls.Parent = gui

local function flyControl(text, pos)

	local button = Instance.new("TextButton")

	button.Size = UDim2.fromOffset(55, 45)
	button.Position = pos

	button.BackgroundColor3 = BLACK
	button.Text = text
	button.TextColor3 = GREEN
	button.TextSize = 20
	button.Font = Enum.Font.GothamBold

	button.Parent = flyControls

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Color = GREEN
	stroke.Thickness = 1
	stroke.Parent = button

	return button
end

local upButton = flyControl("▲", UDim2.fromOffset(58, 0))
local leftButton = flyControl("◀", UDim2.fromOffset(0, 48))
local downButton = flyControl("▼", UDim2.fromOffset(58, 48))
local rightButton = flyControl("▶", UDim2.fromOffset(116, 48))

local goingUp = false
local goingDown = false

upButton.MouseButton1Down:Connect(function()
	goingUp = true
end)

upButton.MouseButton1Up:Connect(function()
	goingUp = false
end)

downButton.MouseButton1Down:Connect(function()
	goingDown = true
end)

downButton.MouseButton1Up:Connect(function()
	goingDown = false
end)

local moveLeft = false
local moveRight = false

leftButton.MouseButton1Down:Connect(function()
	moveLeft = true
end)

leftButton.MouseButton1Up:Connect(function()
	moveLeft = false
end)

rightButton.MouseButton1Down:Connect(function()
	moveRight = true
end)

rightButton.MouseButton1Up:Connect(function()
	moveRight = false
end)

flyButton.MouseButton1Click:Connect(function()

	flying = not flying

	local character = player.Character
	if not character then return end

	local root = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if not root or not humanoid then return end

	if flying then

		flyButton.Text = "✈  FLY: ON"
		flyControls.Visible = true

		flyVelocity = Instance.new("BodyVelocity")
		flyVelocity.Name = "DYV_MobileFly"
		flyVelocity.MaxForce = Vector3.new(
			math.huge,
			math.huge,
			math.huge
		)
		flyVelocity.Velocity = Vector3.zero
		flyVelocity.Parent = root

		humanoid.PlatformStand = true

		flyConnection = RunService.RenderStepped:Connect(function()

			if not flying or not root.Parent then
				return
			end

			local camera = workspace.CurrentCamera

			local velocity = Vector3.zero

			velocity += camera.CFrame.LookVector * 45

			if moveLeft then
				velocity -= camera.CFrame.RightVector * 35
			end

			if moveRight then
				velocity += camera.CFrame.RightVector * 35
			end

			if goingUp then
				velocity += Vector3.new(0, 40, 0)
			end

			if goingDown then
				velocity -= Vector3.new(0, 40, 0)
			end

			flyVelocity.Velocity = velocity

		end)

	else

		flyButton.Text = "✈  FLY"
		flyControls.Visible = false

		if flyConnection then
			flyConnection:Disconnect()
			flyConnection = nil
		end

		if flyVelocity then
			flyVelocity:Destroy()
			flyVelocity = nil
		end

		humanoid.PlatformStand = false
	end
end)

--==================================================
-- SPEED
--==================================================

speedButton.MouseButton1Click:Connect(function()

	local box = Instance.new("TextBox")

	box.Size = UDim2.fromOffset(220, 50)
	box.Position = UDim2.fromScale(0.5, 0.5)
	box.AnchorPoint = Vector2.new(0.5, 0.5)

	box.BackgroundColor3 = BLACK
	box.TextColor3 = GREEN

	box.PlaceholderText = "Digite a velocidade"
	box.PlaceholderColor3 = Color3.fromRGB(130,130,130)

	box.TextSize = 16
	box.Font = Enum.Font.Gotham

	box.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = box

	local stroke = Instance.new("UIStroke")
	stroke.Color = GREEN
	stroke.Thickness = 1
	stroke.Parent = box

	box:CaptureFocus()

	box.FocusLost:Connect(function()

		local value = tonumber(box.Text)

		if value then

			local character = player.Character

			if character then

				local humanoid =
					character:FindFirstChildOfClass("Humanoid")

				if humanoid then
					humanoid.WalkSpeed = value
				end
			end

			speedButton.Text = "⚡ SPEED: " .. value
		end

		box:Destroy()
	end)
end)

--==================================================
-- ENCONTRAR PLAYER
--==================================================

local function findPlayer(text)

	text = text:lower()

	if #text < 4 then
		return nil
	end

	for _, target in ipairs(Players:GetPlayers()) do

		if target ~= player then

			local username = target.Name:lower()
			local displayName = target.DisplayName:lower()

			if username:sub(1, #text) == text
				or displayName:sub(1, #text) == text then

				return target
			end
		end
	end

	return nil
end

--==================================================
-- TELEPORTAR
--==================================================

teleportButton.MouseButton1Click:Connect(function()

	local box = Instance.new("TextBox")

	box.Size = UDim2.fromOffset(250, 50)
	box.Position = UDim2.fromScale(0.5, 0.5)
	box.AnchorPoint = Vector2.new(0.5, 0.5)

	box.BackgroundColor3 = BLACK
	box.TextColor3 = GREEN

	box.PlaceholderText = "Mínimo 4 letras do nick"
	box.PlaceholderColor3 = Color3.fromRGB(130,130,130)

	box.TextSize = 14
	box.Font = Enum.Font.Gotham

	box.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = box

	local stroke = Instance.new("UIStroke")
	stroke.Color = GREEN
	stroke.Thickness = 1
	stroke.Parent = box

	box:CaptureFocus()

	box.FocusLost:Connect(function()

		local target = findPlayer(box.Text)

		if target then

			local myCharacter = player.Character
			local targetCharacter = target.Character

			if myCharacter and targetCharacter then

				local myRoot =
					myCharacter:FindFirstChild("HumanoidRootPart")

				local targetRoot =
					targetCharacter:FindFirstChild("HumanoidRootPart")

				if myRoot and targetRoot then
					myRoot.CFrame =
						targetRoot.CFrame + Vector3.new(0, 3, 0)
				end
			end
		end

		box:Destroy()
	end)
end)

--==================================================
-- SEGUIR PLAYER
--==================================================

local following = false
local followConnection
local followedPlayer

followButton.MouseButton1Click:Connect(function()

	if following then

		following = false
		followedPlayer = nil

		if followConnection then
			followConnection:Disconnect()
			followConnection = nil
		end

		followButton.Text = "👥  SEGUIR PLAYER"

		return
	end

	local box = Instance.new("TextBox")

	box.Size = UDim2.fromOffset(250, 50)
	box.Position = UDim2.fromScale(0.5, 0.5)
	box.AnchorPoint = Vector2.new(0.5, 0.5)

	box.BackgroundColor3 = BLACK
	box.TextColor3 = GREEN

	box.PlaceholderText = "Mínimo 4 letras do nick"
	box.PlaceholderColor3 = Color3.fromRGB(130,130,130)

	box.TextSize = 14
	box.Font = Enum.Font.Gotham

	box.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = box

	local stroke = Instance.new("UIStroke")
	stroke.Color = GREEN
	stroke.Thickness = 1
	stroke.Parent = box

	box:CaptureFocus()

	box.FocusLost:Connect(function()

		local target = findPlayer(box.Text)

		if target then

			followedPlayer = target
			following = true

			followButton.Text =
				"👥 SEGUINDO: " .. target.Name

			followConnection = RunService.Heartbeat:Connect(function()

				if not following then
					return
				end

				local myCharacter = player.Character
				local targetCharacter = target.Character

				if not myCharacter or not targetCharacter then
					return
				end

				local myRoot =
					myCharacter:FindFirstChild("HumanoidRootPart")

				local targetRoot =
					targetCharacter:FindFirstChild("HumanoidRootPart")

				if myRoot and targetRoot then

					local targetPosition =
						targetRoot.CFrame
						* CFrame.new(0, 0, 4)

					myRoot.CFrame =
						myRoot.CFrame:Lerp(
							targetPosition,
							0.15
						)
				end
			end)

		end

		box:Destroy()
	end)
end)

--==================================================
-- CALCULADORA
--==================================================

calculatorButton.MouseButton1Click:Connect(function()

	local calc = Instance.new("Frame")

	calc.Size = UDim2.fromOffset(280, 260)
	calc.Position = UDim2.fromScale(0.5, 0.5)
	calc.AnchorPoint = Vector2.new(0.5, 0.5)

	calc.BackgroundColor3 = DARK
	calc.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 16)
	corner.Parent = calc

	local stroke = Instance.new("UIStroke")
	stroke.Color = GREEN
	stroke.Thickness = 1.5
	stroke.Parent = calc

	local input = Instance.new("TextBox")

	input.Size = UDim2.new(1, -30, 0, 45)
	input.Position = UDim2.fromOffset(15, 25)

	input.BackgroundColor3 = BLACK
	input.TextColor3 = GREEN

	input.PlaceholderText = "Ex: 10 × 5"
	input.PlaceholderColor3 = Color3.fromRGB(130,130,130)

	input.TextSize = 17
	input.Font = Enum.Font.Gotham

	input.Parent = calc

	local ic = Instance.new("UICorner")
	ic.CornerRadius = UDim.new(0, 10)
	ic.Parent = input

	local result = Instance.new("TextLabel")

	result.Size = UDim2.new(1, -30, 0, 40)
	result.Position = UDim2.fromOffset(15, 80)

	result.BackgroundTransparency = 1
	result.Text = "Resultado: —"

	result.TextColor3 = GREEN
	result.TextSize = 18
	result.Font = Enum.Font.GothamBold

	result.Parent = calc

	local calculate = Instance.new("TextButton")

	calculate.Size = UDim2.new(1, -30, 0, 45)
	calculate.Position = UDim2.fromOffset(15, 135)

	calculate.BackgroundColor3 = BLACK
	calculate.Text = "CALCULAR"

	calculate.TextColor3 = GREEN
	calculate.TextSize = 15
	calculate.Font = Enum.Font.GothamBold

	calculate.Parent = calc

	local cc = Instance.new("UICorner")
	cc.CornerRadius = UDim.new(0, 10)
	cc.Parent = calculate

	local cs = Instance.new("UIStroke")
	cs.Color = GREEN
	cs.Thickness = 1
	cs.Parent = calculate

	local close = Instance.new("TextButton")

	close.Size = UDim2.fromOffset(35, 35)
	close.Position = UDim2.new(1, -45, 0, 8)

	close.BackgroundTransparency = 1
	close.Text = "X"

	close.TextColor3 = GREEN
	close.TextSize = 16
	close.Font = Enum.Font.GothamBold

	close.Parent = calc

	close.MouseButton1Click:Connect(function()
		calc:Destroy()
	end)

	calculate.MouseButton1Click:Connect(function()

		local text = input.Text

		text = text:gsub("×", "*")
		text = text:gsub("÷", "/")

		local a, op, b =
			text:match(
				"^%s*(-?[%d%.]+)%s*([%+%-%*/])%s*(-?[%d%.]+)%s*$"
			)

		if a and op and b then

			a = tonumber(a)
			b = tonumber(b)

			local answer

			if op == "+" then
				answer = a + b

			elseif op == "-" then
				answer = a - b

			elseif op == "*" then
				answer = a * b

			elseif op == "/" then

				if b ~= 0 then
					answer = a / b
				end
			end

			if answer then
				result.Text = "Resultado: " .. answer
			else
				result.Text = "Resultado: inválido"
			end

		else
			result.Text = "Resultado: inválido"
		end
	end)
end)
