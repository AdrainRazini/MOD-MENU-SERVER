-- Simulação de emblema ganho (apenas visual)

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
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Size = UDim2.new(0.4, 0, 0.2, 0)
frame.Position = UDim2.new(0.3, 0, 0.4, 0)

textLabel.Name = "BadgeText"
textLabel.Parent = frame
textLabel.Text = "🎉 Parabéns! Você ganhou um emblema! 🎉"
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextSize = 24
textLabel.TextColor3 = Color3.new(1, 1, 1)
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
