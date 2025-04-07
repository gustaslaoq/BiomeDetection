return function(privateServerLink, webhookUrl, antiafk)
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    local lastBiome = ""
    local isFirstRun = true
    local scriptExecuted = false

    local function simulateClick()
        local screenSize = workspace.CurrentCamera.ViewportSize
        local clickPosition = Vector2.new(screenSize.X - 10, screenSize.Y - 10)

        mouse1click(clickPosition.X, clickPosition.Y)
    end

    local function sendToWebhook(message, embed)
        local function sendRequest(url, method, headers, body)
            if syn and syn.request then
                return syn.request({
                    Url = url,
                    Method = method,
                    Headers = headers,
                    Body = body
                })
            elseif request then
                return request({
                    Url = url,
                    Method = method,
                    Headers = headers,
                    Body = body
                })
            elseif http_request then
                return http_request({
                    Url = url,
                    Method = method,
                    Headers = headers,
                    Body = body
                })
            elseif fluxus and fluxus.request then
                return fluxus.request({
                    Url = url,
                    Method = method,
                    Headers = headers,
                    Body = body
                })
            elseif delta and delta.request then
                return delta.request({
                    Url = url,
                    Method = method,
                    Headers = headers,
                    Body = body
                })
            elseif arceus and arceus.request then
                return arceus.request({
                    Url = url,
                    Method = method,
                    Headers = headers,
                    Body = body
                })
            elseif xeno and xeno.request then
                return xeno.request({
                    Url = url,
                    Method = method,
                    Headers = headers,
                    Body = body
                })
            elseif jjsploit and jjsploit.request then
                return jjsploit.request({
                    Url = url,
                    Method = method,
                    Headers = headers,
                    Body = body
                })
            else
                return game:GetService("HttpService"):PostAsync(url, body)
            end
        end

        local success, response = pcall(function()
            local data = {
                content = message,
                embeds = embed and { embed } or nil
            }
            local jsonData = HttpService:JSONEncode(data)
            local response = sendRequest(webhookUrl, "POST", {
                ["Content-Type"] = "application/json"
            }, jsonData)
            return response.Body
        end)

        if not success then
            warn("Error:", response)
        else
            print("Message sent to webhook!")
        end
    end

    local function showHint(player, message)
        local playerGui = player:FindFirstChild("PlayerGui")
        if not playerGui then return end

        local hint = Instance.new("Hint", playerGui)
        hint.Text = message
        wait(2)
        hint:Destroy()
    end

    local function createEmbed(biomeName, isEnded)
        local embed = {
            title = os.date("[%H:%M:%S]"),
            description = string.format("> # Biome %s - %s", isEnded and "Ended" or "Started", biomeName),
            color = nil,
            thumbnail = {
                url = nil
            },
            footer = {
                text = "gustaslaoq's biome script"
            }
        }

        if biomeName == "RAINY" then
            embed.color = 0x0000FF
            embed.thumbnail.url = "https://images-ext-1.discordapp.net/external/4Odh9CMKQ-2hwPKcSrpIAG7cTqSnZovcE8GWMUcvu7c/https/maxstellar.github.io/biome_thumb/RAINY.png?format=webp&quality=lossless&width=630&height=630"
        elseif biomeName == "WINDY" or biomeName == "Windy" then
            embed.color = 0x00FFFF
            embed.thumbnail.url = "https://images-ext-1.discordapp.net/external/mWPT3S9vzEkdeAL4uN_wsYCxh2rnJrIv3-PfTvrmxhk/https/maxstellar.github.io/biome_thumb/WINDY.png?format=webp&quality=lossless&width=630&height=630"
        elseif biomeName == "CORRUPTION" or biomeName == "Corruption" then
            embed.color = 0x800080
            embed.thumbnail.url = "https://images-ext-1.discordapp.net/external/JGZec1B_jifKFatj7GU9J5sYZ114allHFRVVPqQIrMM/https/maxstellar.github.io/biome_thumb/CORRUPTION.png?format=webp&quality=lossless&width=630&height=630"
        elseif biomeName == "NULL" then
            embed.color = 0x000000
            embed.thumbnail.url = "https://images-ext-1.discordapp.net/external/CGPXOttsPtxet9LPxO2M71huIh3V7mAqzBst6l24d60/https/maxstellar.github.io/biome_thumb/NULL.png?format=webp&quality=lossless&width=630&height=630"
        elseif biomeName == "SAND STORM" or biomeName == "SANDSTORM" then
            embed.color = 0xD2691E
            embed.thumbnail.url = "https://images-ext-1.discordapp.net/external/To-CvYRI4VKaZEpM_4xoXc_WLMitLGpqi0-rmx7fKNA/https/maxstellar.github.io/biome_thumb/SAND%2520STORM.png?format=webp&quality=lossless&width=630&height=630"
        elseif biomeName == "STARFALL" then
            embed.color = 0x9932CC
            embed.thumbnail.url = "https://images-ext-1.discordapp.net/external/qfBuF8zhb7O39bJaNR9LbkaHTD9JuzA9msA-ldP-xa0/https/maxstellar.github.io/biome_thumb/STARFALL.png?format=webp&quality=lossless&width=630&height=630"
        elseif biomeName == "HELL" then
            embed.color = 0xFF0000
            embed.thumbnail.url = "https://images-ext-1.discordapp.net/external/R6VmSH-cYgxa23jo_zNUwyTBqKicLv4tZFAyESzjVCU/https/maxstellar.github.io/biome_thumb/HELL.png?format=webp&quality=lossless&width=630&height=630"
        elseif biomeName == "DREAMSPACE" then
            embed.color = 0xFF69B4
            embed.thumbnail.url = "https://images-ext-1.discordapp.net/external/VPKTCCFFoUkZkBGliFUYn1KmVE7B8nZDGHwwlBFRkBk/https/maxstellar.github.io/biome_thumb/DREAMSPACE.png?format=webp&quality=lossless&width=378&height=378"
        elseif biomeName == "GLITCHED" then
            embed.color = 0x00FF00
            embed.thumbnail.url = "https://images-ext-1.discordapp.net/external/I5LHZTTaWdUMLrn22Q4_aiw9VqLjYoW3rEYe1c4tQqE/https/maxstellar.github.io/biome_thumb/GLITCHED.png?format=webp&quality=lossless&width=630&height=630"
        elseif biomeName == "SNOWY" then
            embed.color = 0x87CEFA
            embed.thumbnail.url = "https://images-ext-1.discordapp.net/external/b9KDqortpnaczAiSQK6b32R1JDdMW-_sRusyq1yMNVo/https/raw.githubusercontent.com/A1RG3MMM/biome-images/refs/heads/main/SNOWY.png?format=webp&quality=lossless&width=630&height=630"
        end

        return embed
    end

    local function checkBiome(player)
        local playerGui = player:FindFirstChild("PlayerGui")
        if not playerGui then return end

        local mainInterface = playerGui:FindFirstChild("MainInterface")
        if not mainInterface or not mainInterface:IsA("ScreenGui") then return end

        for _, textLabel in ipairs(mainInterface:GetDescendants()) do
            if textLabel:IsA("TextLabel") and #textLabel:GetChildren() == 4 then
                for _, childLabel in ipairs(textLabel:GetChildren()) do
                    if childLabel:IsA("TextLabel") then
                        local text = childLabel.Text
                        local biomeName = text:match("%[ ([^%]]+) %]")
                        if biomeName then
                            if isFirstRun or biomeName ~= lastBiome then
                                if not isFirstRun and biomeName == "NORMAL" and lastBiome ~= "" then
                                    local endedEmbed = createEmbed(lastBiome, true)
                                    sendToWebhook("", endedEmbed)
                                end

                                isFirstRun = false
                                lastBiome = biomeName

                                if text:match("%[ 0%.[0-9]+ %]") then
                                    biomeName = "GLITCHED"
                                end

                                local message = string.format("%sPrivate Server Link: %s", 
                                    (biomeName == "GLITCHED" or biomeName == "DREAMSPACE") and "@everyone " or "", 
                                    privateServerLink)

                                local embed = createEmbed(biomeName, false)
                                sendToWebhook(message, embed)
                                showHint(player, "Message Sent to Webhook!")
                            end
                        end
                    end
                end
            end
        end
    end

    local function main(player)
        local playerGui = player:FindFirstChild("PlayerGui")
        if playerGui and playerGui:FindFirstChild("Executed") then
            return
        end

        local executedGui = Instance.new("ScreenGui")
        executedGui.Name = "Executed"
        executedGui.Parent = playerGui

        showHint(player, "Macro has been started!")
        sendToWebhook("Macro has been started!", nil)

        checkBiome(player)

        while true do
            checkBiome(player)
            if antiafk then
                simulateClick()
            end
            wait(0.1)
        end
    end

    Players.PlayerAdded:Connect(function(player)
        main(player)
    end)

    for _, player in ipairs(Players:GetPlayers()) do
        main(player)
    end
end
