loadstring(game:HttpGet("https://raw.githubusercontent.com/snthnova/Snthtools-gui/refs/heads/main/Code.lua"))()
-- Franzken's Compact Mutation + Age Changer GUI with Welcome Glow
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- 🟢 Welcome Popup
local welcomeGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
welcomeGui.Name = "WelcomePopup"

local welcomeLabel = Instance.new("TextLabel", welcomeGui)
welcomeLabel.Size = UDim2.new(0.3, 0, 0.15, 0)
welcomeLabel.Position = UDim2.new(0.35, 0, 0.4, 0)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Text = "Welcome"
welcomeLabel.Font = Enum.Font.GothamBlack
welcomeLabel.TextSize = 48
welcomeLabel.TextColor3 = Color3.new(1, 1, 1)
welcomeLabel.TextTransparency = 1
welcomeLabel.TextStrokeTransparency = 1

TweenService:Create(welcomeLabel, TweenInfo.new(0.6), {
	TextTransparency = 0,
	TextStrokeTransparency = 0.4,
	TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
}):Play()

wait(2.5)

TweenService:Create(welcomeLabel, TweenInfo.new(0.6), {
	TextTransparency = 1,
	TextStrokeTransparency = 1
}):Play()

wait(1)
welcomeGui:Destroy()

-- 🧩 Main GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FranzkenCompactGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 230)
frame.Position = UDim2.new(0.02, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- 🟦 Pet Label
local petLabel = Instance.new("TextLabel", frame)
petLabel.Position = UDim2.new(0, 0, 0, 30)
petLabel.Size = UDim2.new(1, 0, 0, 20)
petLabel.Text = "Equipped Pet: [None]"
petLabel.Font = Enum.Font.Gotham
petLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
petLabel.TextScaled = true
petLabel.BackgroundTransparency = 1

local function getEquippedPet()
	for _, tool in ipairs(char:GetChildren()) do
		if tool:IsA("Tool") and tool.Name:find("Age") then
			return tool
		end
	end
end

-- 📌 Pet ESP
local function petESP()
	local tool = getEquippedPet()
	local head = char:FindFirstChild("Head")
	if tool and head and not head:FindFirstChild("PetESP") then
		local esp = Instance.new("BillboardGui", head)
		esp.Name = "PetESP"
		esp.Size = UDim2.new(0, 140, 0, 30)
		esp.StudsOffset = Vector3.new(0, 2.5, 0)
		esp.AlwaysOnTop = true
		local label = Instance.new("TextLabel", esp)
		label.Size = UDim2.new(1, 0, 1, 0)
		label.BackgroundTransparency = 1
		label.Font = Enum.Font.GothamBold
		label.TextColor3 = Color3.new(1, 1, 1)
		label.TextStrokeTransparency = 0.4
		label.Text = tool.Name
		label.TextScaled = true
	end
end

-- ⏱️ Age Button (15s Countdown)
local ageBtn = Instance.new("TextButton", frame)
ageBtn.Size = UDim2.new(0.9, 0, 0, 30)
ageBtn.Position = UDim2.new(0.05, 0, 0, 60)
ageBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
ageBtn.Text = "⏱ Set Age to 50"
ageBtn.Font = Enum.Font.GothamBold
ageBtn.TextColor3 = Color3.new(0, 0, 0)
ageBtn.TextSize = 13
Instance.new("UICorner", ageBtn).CornerRadius = UDim.new(0, 6)

ageBtn.MouseButton1Click:Connect(function()
	local tool = getEquippedPet()
	if tool then
		for i = 15, 1, -1 do
			ageBtn.Text = "Changing in " .. i .. "s"
			wait(1)
		end
		tool.Name = tool.Name:gsub("%[Age%s%d+%]", "[Age 50]")
		petLabel.Text = "Equipped Pet: " .. tool.Name
		ageBtn.Text = "⏱ Set Age to 50"
	else
		ageBtn.Text = "No Pet!"
		wait(2)
		ageBtn.Text = "⏱ Set Age to 50"
	end
end)

-- 🌈 Mutation Label
local hue = 0
local mutationLabel = Instance.new("TextLabel", frame)
mutationLabel.Position = UDim2.new(0, 0, 0, 100)
mutationLabel.Size = UDim2.new(1, 0, 0, 25)
mutationLabel.Text = "Mutation: [None]"
mutationLabel.Font = Enum.Font.GothamBold
mutationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
mutationLabel.TextScaled = true
mutationLabel.BackgroundTransparency = 1

local mutations = {
	"Shiny", "Frozen", "Windy", "Golden", "Mega", "Tranquil",
	"IronSkin", "Radiant", "Rainbow", "Shocked", "Ascended"
}

-- 🌈 Update rainbow glow
RunService.RenderStepped:Connect(function()
	hue = (hue + 0.01) % 1
	mutationLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
end)

-- 🎲 Reroll Mutation
local rerollBtn = Instance.new("TextButton", frame)
rerollBtn.Size = UDim2.new(0.9, 0, 0, 30)
rerollBtn.Position = UDim2.new(0.05, 0, 0, 130)
rerollBtn.BackgroundColor3 = Color3.fromRGB(140, 120, 255)
rerollBtn.Text = "🎲 Reroll Mutation"
rerollBtn.Font = Enum.Font.GothamBold
rerollBtn.TextColor3 = Color3.new(1, 1, 1)
rerollBtn.TextSize = 13
Instance.new("UICorner", rerollBtn).CornerRadius = UDim.new(0, 6)

rerollBtn.MouseButton1Click:Connect(function()
	rerollBtn.Text = "🔁 Rolling..."
	for i = 1, 10 do
		mutationLabel.Text = "Mutation: " .. mutations[math.random(#mutations)]
		wait(0.05)
	end
	local chosen = mutations[math.random(#mutations)]
	mutationLabel.Text = "Mutation: " .. chosen
	rerollBtn.Text = "🎲 Reroll Mutation"
end)

-- 🧬 Mutation ESP (synced with GUI)
local function mutationESP()
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj.Name:lower():find("mutation") then
			local part = obj:FindFirstChildWhichIsA("BasePart")
			if part and not part:FindFirstChild("MutESP") then
				local esp = Instance.new("BillboardGui", part)
				esp.Name = "MutESP"
				esp.Size = UDim2.new(0, 180, 0, 35)
				esp.StudsOffset = Vector3.new(0, 3, 0)
				esp.AlwaysOnTop = true
				local label = Instance.new("TextLabel", esp)
				label.Size = UDim2.new(1, 0, 1, 0)
				label.BackgroundTransparency = 1
				label.Font = Enum.Font.GothamBold
				label.TextScaled = true
				label.TextStrokeTransparency = 0.3
				label.TextStrokeColor3 = Color3.new(0, 0, 0)
				RunService.RenderStepped:Connect(function()
					label.Text = mutationLabel.Text
					label.TextColor3 = Color3.fromHSV(hue, 1, 1)
				end)
			end
		end
	end
end

-- 🖋️ Footer
local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.Text = "Created by Franzken"
credit.Font = Enum.Font.Gotham
credit.TextColor3 = Color3.fromRGB(255, 255, 255)
credit.TextTransparency = 0.2
credit.BackgroundTransparency = 1
credit.TextSize = 12

-- 🟢 Start
task.wait(1)
petESP()
mutationESP()
