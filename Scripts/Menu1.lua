local guiName = "ScriptsCentralGUI"
local apiUrl = "https://mod-menu-server.onrender.com/scripts"

if identifyexecutor then
    if game:GetService("CoreGui"):FindFirstChild(guiName) then
        return
    end

    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = guiName

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150) -- Centralizado
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

    local SideBar = Instance.new("Frame", MainFrame)
    SideBar.Size = UDim2.new(0, 100, 1, 0)
    SideBar.Position = UDim2.new(0, 0, 0, 0)
    SideBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

    local ContentFrame = Instance.new("Frame", MainFrame)
    ContentFrame.Size = UDim2.new(1, -100, 1, 0)
    ContentFrame.Position = UDim2.new(0, 100, 0, 0)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

    -- Botões da barra lateral
    local function createSideButton(name, order)
        local Button = Instance.new("TextButton", SideBar)
        Button.Size = UDim2.new(1, 0, 0, 50)
        Button.Position = UDim2.new(0, 0, 0, (order - 1) * 50)
        Button.Text = name
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        return Button
    end

    local ScriptsButton = createSideButton("Scripts", 1)
    local ConfigButton = createSideButton("Configurações", 2)
    local CreditButton = createSideButton("Créditos", 3)

    -- Seções do conteúdo
    local ScriptsFrame = Instance.new("Frame", ContentFrame)
    ScriptsFrame.Size = UDim2.new(1, 0, 1, 0)
    ScriptsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ScriptsFrame.Visible = true

    local ConfigFrame = Instance.new("Frame", ContentFrame)
    ConfigFrame.Size = UDim2.new(1, 0, 1, 0)
    ConfigFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ConfigFrame.Visible = false

    local CreditFrame = Instance.new("Frame", ContentFrame)
    CreditFrame.Size = UDim2.new(1, 0, 1, 0)
    CreditFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    CreditFrame.Visible = false

    -- Conteúdo da seção Scripts
    local ScrollingFrame = Instance.new("ScrollingFrame", ScriptsFrame)
    ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.ScrollBarThickness = 5
    ScrollingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

    local Layout = Instance.new("UIListLayout", ScrollingFrame)
    Layout.Padding = UDim.new(0, 10)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    local activeScripts = {}

    local function createButton(scriptName)
        local Button = Instance.new("TextButton", ScrollingFrame)
        Button.Size = UDim2.new(1, -10, 0, 50)
        Button.Text = "Ativar: " .. scriptName
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        activeScripts[scriptName] = false

        Button.MouseButton1Click:Connect(function()
            if activeScripts[scriptName] then
                activeScripts[scriptName] = false
                Button.Text = "Ativar: " .. scriptName
                Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                print("Script desativado:", scriptName)
            else
                activeScripts[scriptName] = true
                Button.Text = "Desativar: " .. scriptName
                Button.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
                local scriptUrl = apiUrl .. "/" .. scriptName
                local success, result = pcall(function()
                    return loadstring(game:HttpGet(scriptUrl))()
                end)

                if success then
                    print("Script ativado:", scriptName)
                else
                    warn("Erro ao ativar o script:", result)
                end
            end
        end)
    end

    local success, response = pcall(function()
        return game:HttpGet(apiUrl)
    end)

    if success then
        local scripts = game:GetService("HttpService"):JSONDecode(response)
        for _, scriptName in ipairs(scripts) do
            createButton(scriptName)
        end
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #scripts * 60)
    else
        warn("Erro ao buscar os scripts:", response)
    end

    -- Navegação entre as seções
    ScriptsButton.MouseButton1Click:Connect(function()
        ScriptsFrame.Visible = true
        ConfigFrame.Visible = false
        CreditFrame.Visible = false
    end)

    ConfigButton.MouseButton1Click:Connect(function()
        ScriptsFrame.Visible = false
        ConfigFrame.Visible = true
        CreditFrame.Visible = false
    end)

    CreditButton.MouseButton1Click:Connect(function()
        ScriptsFrame.Visible = false
        ConfigFrame.Visible = false
        CreditFrame.Visible = true
    end)
else
    print("Este script deve ser executado em um executor externo.")
end
