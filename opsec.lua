local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,350,0,320)
frame.Position = UDim2.new(0.5,-175,0.5,-160)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(20,20,20)
title.Text = "Player Account Viewer"
title.TextColor3 = Color3.new(1,1,1)
title.Parent = frame

-- username search
local usernameBox = Instance.new("TextBox")
usernameBox.Size = UDim2.new(0.6,0,0,30)
usernameBox.Position = UDim2.new(0.05,0,0.12,0)
usernameBox.PlaceholderText = "Enter Username"
usernameBox.Parent = frame

local searchButton = Instance.new("TextButton")
searchButton.Size = UDim2.new(0.3,0,0,30)
searchButton.Position = UDim2.new(0.65,0,0.12,0)
searchButton.Text = "Search"
searchButton.Parent = frame

-- avatar
local avatar = Instance.new("ImageLabel")
avatar.Size = UDim2.new(0,100,0,100)
avatar.Position = UDim2.new(0.05,0,0.28,0)
avatar.BackgroundTransparency = 1
avatar.Parent = frame

-- info
local info = Instance.new("TextLabel")
info.Size = UDim2.new(0.55,0,0.6,0)
info.Position = UDim2.new(0.4,0,0.28,0)
info.TextColor3 = Color3.new(1,1,1)
info.BackgroundTransparency = 1
info.TextXAlignment = Enum.TextXAlignment.Left
info.TextYAlignment = Enum.TextYAlignment.Top
info.TextWrapped = true
info.Text = "Click a player or search a username"
info.Parent = frame


-- LOADING SCREEN
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1,0,1,0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
loadingFrame.Visible = false
loadingFrame.Parent = frame

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1,0,0.6,0)
loadingText.Position = UDim2.new(0,0,0.2,0)
loadingText.BackgroundTransparency = 1
loadingText.TextColor3 = Color3.new(1,1,1)
loadingText.TextScaled = true
loadingText.Text = "Scanning Account..."
loadingText.Parent = loadingFrame

local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1,0,0.2,0)
credit.Position = UDim2.new(0,0,0.7,0)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(170,170,170)
credit.TextScaled = true
credit.Text = "nigga dick"
credit.Parent = loadingFrame


-- fake info generators
local securityLevels = {"ass","tits","balls"}
local devices = {"PC","Mobile","Console"}

local function showInfo(targetPlayer)

	if not targetPlayer then return end

	-- show loading screen
	loadingFrame.Visible = true
	info.Visible = false
	avatar.Visible = false

	task.wait(2)

	local security = securityLevels[math.random(1,#securityLevels)]
	local device = devices[math.random(1,#devices)]
	local ping = math.random(20,120)

	info.Text =
	"Username: "..targetPlayer.Name.."\n\n"..
	"Display Name: "..targetPlayer.DisplayName.."\n\n"..
	"User ID: "..targetPlayer.UserId.."\n\n"..
	"Account Age: "..targetPlayer.AccountAge.." days\n\n"..
	"Premium: "..tostring(targetPlayer.MembershipType == Enum.MembershipType.Premium).."\n\n"..
	"Team: "..(targetPlayer.Team and targetPlayer.Team.Name or "None").."\n\n"..
	"Security Level: "..security.."\n\n"..
	"Device: "..device.."\n\n"..
	"Ping: "..ping.." ms"

	local thumb = Players:GetUserThumbnailAsync(
		targetPlayer.UserId,
		Enum.ThumbnailType.HeadShot,
		Enum.ThumbnailSize.Size150x150
	)

	avatar.Image = thumb

	-- hide loading
	loadingFrame.Visible = false
	info.Visible = true
	avatar.Visible = true
end


-- search
searchButton.MouseButton1Click:Connect(function()

	local name = usernameBox.Text
	local target = Players:FindFirstChild(name)

	if target then
		showInfo(target)
	else
		info.Text = "Player not in this server"
	end

end)


-- click scan
mouse.Button1Down:Connect(function()

	local target = mouse.Target
	if not target then return end

	local character = target:FindFirstAncestorWhichIsA("Model")
	if not character then return end

	local targetPlayer = Players:GetPlayerFromCharacter(character)

	if targetPlayer then
		showInfo(targetPlayer)
	end

end)
