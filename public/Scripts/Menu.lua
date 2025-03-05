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
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

    local TitleBar = Instance.new("Frame", MainFrame)
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TitleBar.BorderSizePixel = 0

    local Title = Instance.new("TextLabel", TitleBar)
    Title.Size = UDim2.new(1, -60, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = "Scripts Central GUI"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.SourceSans
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local MinimizeButton = Instance.new("TextButton", TitleBar)
    MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
    MinimizeButton.Position = UDim2.new(1, -40, 0, 0)
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.TextSize = 18

    local CloseButton = Instance.new("TextButton", TitleBar)
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Position = UDim2.new(1, -10, 0, 0)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.TextSize = 18

    local ContentFrame = Instance.new("Frame", MainFrame)
    ContentFrame.Size = UDim2.new(1, -150, 1, -30)
    ContentFrame.Position = UDim2.new(0, 150, 0, 30)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 150, 1, -30)
    Sidebar.Position = UDim2.new(0, 0, 0, 30)
    Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

    local function createButton(name, parent, position)
        local Button = Instance.new("TextButton", parent)
        Button.Size = UDim2.new(1, 0, 0, 50)
        Button.Position = position
        Button.Text = name
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Button.Font = Enum.Font.SourceSansBold
        Button.TextSize = 18
        return Button
    end

    local ScriptsButton = createButton("Scripts", Sidebar, UDim2.new(0, 0, 0, 0))
    local ConfigButton = createButton("Configurações", Sidebar, UDim2.new(0, 0, 0, 50))
    local CreditsButton = createButton("Créditos", Sidebar, UDim2.new(0, 0, 0, 100))

    local ScriptsPage = Instance.new("Frame", ContentFrame)
    ScriptsPage.Size = UDim2.new(1, 0, 1, 0)
    ScriptsPage.BackgroundTransparency = 1

    local ConfigPage = Instance.new("Frame", ContentFrame)
    ConfigPage.Size = UDim2.new(1, 0, 1, 0)
    ConfigPage.BackgroundTransparency = 1
    ConfigPage.Visible = false

    local CreditsPage = Instance.new("Frame", ContentFrame)
    CreditsPage.Size = UDim2.new(1, 0, 1, 0)
    CreditsPage.BackgroundTransparency = 1
    CreditsPage.Visible = false

    ScriptsButton.MouseButton1Click:Connect(function()
        ScriptsPage.Visible = true
        ConfigPage.Visible = false
        CreditsPage.Visible = false
    end)

    ConfigButton.MouseButton1Click:Connect(function()
        ScriptsPage.Visible = false
        ConfigPage.Visible = true
        CreditsPage.Visible = false
    end)

    CreditsButton.MouseButton1Click:Connect(function()
        ScriptsPage.Visible = false
        ConfigPage.Visible = false
        CreditsPage.Visible = true
    end)

    -- Dragging
    local UIS = game:GetService("UserInputService")
    local dragging = false
    local dragStart = nil
    local startPos = nil

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Minimize functionality
    local isMinimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        ContentFrame.Visible = not isMinimized
        Sidebar.Visible = not isMinimized
        if isMinimized then
            MainFrame.Size = UDim2.new(0, 500, 0, 30)
        else
            MainFrame.Size = UDim2.new(0, 500, 0, 300)
        end
    end)

    -- Close functionality
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

else
    print("Este script deve ser executado em um executor externo.")
end
