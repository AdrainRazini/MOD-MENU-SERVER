local player = game.Players.LocalPlayer
local gui

-- Função para criar o GUI do emblema
local function createEmblem()
    -- Cria o ScreenGui
    gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

    -- Cria o Frame do emblema
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 400, 0, 150)
    frame.Position = UDim2.new(0.5, -200, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0

    -- Cria o ImageLabel (imagem do jogador)
    local imageLabel = Instance.new("ImageLabel", frame)
    imageLabel.Size = UDim2.new(0, 100, 0, 100)
    imageLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=1393562880&width=420&height=420&format=png"

    -- Adiciona texto
    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Size = UDim2.new(0.7, 0, 1, 0)
    textLabel.Position = UDim2.new(0.3, 0, 0, 0)
    textLabel.Text = "🎉 Script Executado! 🎉\nAdrianRazini"
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.BackgroundTransparency = 1
    textLabel.TextScaled = true
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Center

    -- Função para executar o script remoto
    local function executarScript()
        -- Substitua a URL pelo script que você quer carregar
        local scriptUrl = "https://mod-menu-server.onrender.com/scripts/Menu.lua"
        -- Executa o script remoto
        loadstring(game:HttpGet(scriptUrl))()
    end

    -- Animação de aparecimento e desaparecimento do emblema
    frame.Visible = false
    local function showEmblem()
        frame.Visible = true
        for i = 0, 1, 0.05 do
            frame.BackgroundTransparency = i
            textLabel.TextTransparency = i
            imageLabel.ImageTransparency = i
            wait(0.05)
        end
        wait(2) -- Duração do emblema visível
        for i = 1, 0, -0.05 do
            frame.BackgroundTransparency = i
            textLabel.TextTransparency = i
            imageLabel.ImageTransparency = i
            wait(0.05)
        end
        frame.Visible = false

        -- Executa o script remoto após o desaparecimento do emblema
        executarScript()

        -- Destroi o GUI
        gui:Destroy()
    end

    -- Mostra o emblema
    showEmblem()
end

-- Recriar GUI do emblema ao respawn do jogador
player.CharacterAdded:Connect(function()
    -- Se houver uma GUI anterior, destrua-a
    if gui then
        gui:Destroy()
    end
    -- Cria um novo emblema
    createEmblem()
end)

-- Cria o emblema inicialmente
createEmblem()
