-- Simulação de emblema ganho (visual no canto inferior direito)

-- Criando a interface de usuário
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local textLabel = Instance.new("TextLabel")

-- Configurando o GUI
gui.Name = "BadgeEffect"
gui.Parent = player:WaitForChild("PlayerGui")

frame.Name = "BadgeFrame"
frame.Parent = gui
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Fundo preto
frame.BackgroundTransparency = 0.5
frame.Size = UDim2.new(0.3, 0, 0.1, 0) -- Tamanho ajustado
frame.Position = UDim2.new(0.7, 0, 0.9, 0) -- Posição no canto inferior direito
frame.AnchorPoint = Vector2.new(0, 1) -- Alinha no canto inferior

textLabel.Name = "BadgeText"
textLabel.Parent = frame
textLabel.Text = "🎉 Você ganhou um emblema! 🎉"
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextSize = 20
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Texto branco
textLabel.BackgroundTransparency = 1
textLabel.Size = UDim2.new(1, 0, 1, 0)

-- Efeito de aparecimento e desaparecimento
frame.Visible = false

local function showBadgeEffect()
    frame.Visible = true
    for i = 0, 1, 0.05 do
        frame.BackgroundTransparency = i
        textLabel.TextTransparency = i
        wait(0.05)
    end
    wait(2) -- Duração do efeito
    for i = 1, 0, -0.05 do
        frame.BackgroundTransparency = i
        textLabel.TextTransparency = i
        wait(0.05)
    end
    frame.Visible = false
end

-- Simula o efeito visual ao rodar o script
showBadgeEffect()
