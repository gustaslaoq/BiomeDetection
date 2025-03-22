local HttpService = game:GetService("HttpService")

-- Substitua pelo seu webhook do Discord
local webhookURL = "https://discord.com/api/webhooks/1347388287945543842/bcFhoKmjAmSqhxCz07TjKoCZkXqjOe19J50AW2knLYv3zeR3A5cFVmBZV6mjVAQyxETg"

-- Configuração da mensagem
local data = {
    ["content"] = "Hello, Roblox Studio Webhook!"
}

-- Converte para JSON
local jsonData = HttpService:JSONEncode(data)

-- Função para enviar a mensagem
local function sendWebhook()
    local success, response = pcall(function()
        return HttpService:PostAsync(webhookURL, jsonData, Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        print("Mensagem enviada com sucesso!")
    else
        warn("Erro ao enviar a mensagem:", response)
    end
end

-- Chamando a função
sendWebhook()
