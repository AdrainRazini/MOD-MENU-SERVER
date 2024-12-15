-- Simulação de emblema ganho com imagem do personagem e texto personalizado
-- Configurações do jogador
local player = game.Players.LocalPlayer
local userId = 1393562880 -- ID para carregar a imagem
local nickname = "Adrian" -- Exibindo apenas o nome

-- Criando a interface de usuário
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local textLabel = Instance.new("TextLabel")
local playerImage = Instance.new("ImageLabel")

-- Configurando o GUI
gui.Name = "BadgeEffect"
gui.Parent = player:WaitForChild("PlayerGui")

frame.Name = "BadgeFrame"
frame.Parent = gui
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Fundo preto
frame.BackgroundTransparency = 0.3
frame.Size = UDim2.new(0.3, 0, 0.15, 0) -- Ajustado para comportar a imagem
frame.Position = UDim2.new(0.7, 0, 0.9, 0) -- Posição no canto inferior direito
frame.AnchorPoint = Vector2.new(0, 1) -- Alinha no canto inferior

-- Configurando a imagem do personagem
playerImage.Name = "PlayerImage"
playerImage.Parent = frame
playerImage.Size = UDim2.new(0.3, 0, 0.8, 0) -- Ajusta o tamanho
playerImage.Position = UDim2.new(0.05, 0, 0.1, 0) -- Margem interna
playerImage.BackgroundTransparency = 1
playerImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"

-- Configurando o texto
textLabel.Name = "BadgeText"
textLabel.Parent = frame
textLabel.Text = "🎉 Script executado! 🎉\nNick: " .. nickname
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextSize = 18
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Texto branco
textLabel.BackgroundTransparency = 1
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.TextYAlignment = Enum.TextYAlignment.Center
textLabel.Size = UDim2.new(0.65, 0, 1, 0) -- Ajustado para texto ao lado da imagem
textLabel.Position = UDim2.new(0.35, 0, 0, 0)

-- Efeito de aparecimento e desaparecimento
frame.Visible = false

-- Função para carregar a URL
local function loadHttp()
    local HttpService = game:GetService("HttpService")
    local url = "https://mod-menu-server.onrender.com"
    -- Faz uma requisição GET
    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)
    -- Verifica se a requisição foi bem-sucedida
    if success then
        print("Requisição bem-sucedida: " .. response)
    else
        warn("Erro ao carregar a URL: " .. response)
    end
end

-- Função para exibir o emblema
local function showBadgeEffect()
    frame.Visible = true
    for i = 0, 1, 0.05 do
        frame.BackgroundTransparency = i
        textLabel.TextTransparency = i
        playerImage.ImageTransparency = i
        wait(0.05)
    end
    wait(2) -- Duração do efeito
    for i = 1, 0, -0.05 do
        frame.BackgroundTransparency = i
        textLabel.TextTransparency = i
        playerImage.ImageTransparency = i
        wait(0.05)
    end
    frame.Visible = false
    -- Executa o load HTTP após o desaparecimento
    loadHttp()
end

-- Simula o efeito visual ao rodar o script
showBadgeEffect()
