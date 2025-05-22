local player = game.Players.LocalPlayer
local button = player:WaitForChild("PlayerGui"):WaitForChild("Teleport_UI"):WaitForChild("Frame"):WaitForChild("Seeds")

-- Pegar as conexões do evento Activated ou MouseButton1Click
local getConnections = getconnections or get_signal_cons

if getConnections then
    local connections = getConnections(button.Activated) -- Ou MouseButton1Click, teste qual existe

    if connections and #connections > 0 then
        for i, conn in ipairs(connections) do
            if conn.Function then
                print("Chamando função da conexão "..i)
                -- Executar direto a função conectada ao evento
                coroutine.wrap(conn.Function)()
            end
        end
    else
        print("Nenhuma conexão encontrada no Activated")
    end
else
    print("Função getconnections não disponível no executor")
end
