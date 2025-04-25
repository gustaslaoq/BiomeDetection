-- CONFIG
local webhookUrl = "YOUR_WEBHOOK_URL_HERE"
local enableWebhook = true

-- SERVICES
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

-- TRACKING
local lastBiome = nil

-- ANTI-AFK SETUP
player.Idled:Connect(function()
	VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	wait(1)
	VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	print("[Anti-AFK] Simulated input.")
end)

-- SEND TO WEBHOOK
local function sendToWebhook(biome)
	if not enableWebhook or webhookUrl == "" then return end

	local pingEveryone = biome == "GLITCHED" or biome == "DREAMSPACE"
	local contentMessage = (pingEveryone and "@everyone " or "") .. "**[Sol's RNG] Biome Detected: **" .. biome

	local data = {
		content = contentMessage
	}
	local body = HttpService:JSONEncode(data)

	local requestFunc = syn and syn.request or request or http_request
	if requestFunc then
		requestFunc({
			Url = webhookUrl,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = body
		})
	end
end

-- DETECT BIOME
local function getBiomeFromUI()
	local gui = player:WaitForChild("PlayerGui", 10)
	if not gui then return nil end

	local mainInterface = gui:FindFirstChild("MainInterface")
	if not mainInterface then return nil end

	for _, label in ipairs(mainInterface:GetDescendants()) do
		if label:IsA("TextLabel") then
			local biome = label.Text:match("^%[ ([A-Z%s]+) %]$")
			if biome and biome ~= "NORMAL" then
				return biome
			end
		end
	end

	return nil
end

-- MAIN LOOP
while true do
	local biome = getBiomeFromUI()
	if biome and biome ~= lastBiome then
		lastBiome = biome
		print("[Sol's RNG] Biome Started -", biome)
		sendToWebhook(biome)
	end
	wait(1)
end
