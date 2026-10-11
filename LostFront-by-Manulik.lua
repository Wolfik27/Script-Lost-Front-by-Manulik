local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

function loadCheat()
    local SETTINGS = {
        ENEMIES_ESP = false,
        TEAM_ESP = false,
        ENEMIES_COLOR = Color3.fromRGB(255, 0, 0),
        TEAM_COLOR = Color3.fromRGB(0, 255, 0),
        MENU_COLOR = Color3.fromRGB(20, 20, 20),
        NO_LEAVES = false,
        NO_FOG = false,
        LANG = "EN",
    }
    
    local TEXTS = {
        EN = {
            ESP = "ESP",
            OTHERS = "OTHERS",
            SETTINGS = "SETTINGS",
            ENEMIES_ESP = "Enemies ESP",
            TEAM_ESP = "Team ESP",
            ENEMIES_COLOR = "Enemies Color",
            TEAM_COLOR = "Team Color",
            NO_LEAVES = "No Leaves",
            NO_FOG = "No Fog",
            MENU_COLOR = "Menu Color:",
            LANGUAGE = "Language:",
            ON = "ON",
            OFF = "OFF",
        },
        RU = {
            ESP = "ESP",
            OTHERS = "ДРУГОЕ",
            SETTINGS = "НАСТРОЙКИ",
            ENEMIES_ESP = "Враги ESP",
            TEAM_ESP = "Команда ESP",
            ENEMIES_COLOR = "Цвет врагов",
            TEAM_COLOR = "Цвет команды",
            NO_LEAVES = "Убрать листья",
            NO_FOG = "Убрать туман",
            MENU_COLOR = "Цвет меню:",
            LANGUAGE = "Язык:",
            ON = "ВКЛ",
            OFF = "ВЫКЛ",
        }
    }
    
    local espObjects = {}
    local hiddenLeaves = {}
    local originalFog = {
        End = Lighting.FogEnd,
        Start = Lighting.FogStart,
        Color = Lighting.FogColor,
    }
    
    local cheatGui = Instance.new("ScreenGui")
    cheatGui.Name = "ManulCheat"
    cheatGui.ResetOnSpawn = false
    cheatGui.IgnoreGuiInset = true
    cheatGui.Parent = playerGui
    
    local circleBtn = Instance.new("TextButton")
    circleBtn.Size = UDim2.fromOffset(55, 55)
    circleBtn.Position = UDim2.new(0, 20, 0.5, -27)
    circleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    circleBtn.Text = "M"
    circleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    circleBtn.Font = Enum.Font.GothamBold
    circleBtn.TextSize = 24
    circleBtn.AutoButtonColor = false
    circleBtn.ZIndex = 10
    circleBtn.Active = true
    circleBtn.Draggable = true
    circleBtn.Parent = cheatGui
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circleBtn
    
    local circleStroke = Instance.new("UIStroke")
    circleStroke.Color = Color3.fromRGB(0, 220, 90)
    circleStroke.Thickness = 2.5
    circleStroke.Parent = circleBtn
    
    local menuFrame = Instance.new("Frame")
    menuFrame.Size = UDim2.new(0.7, 0, 0.7, 0)
    menuFrame.Position = UDim2.new(0.15, 0, 0.15, 0)
    menuFrame.BackgroundColor3 = SETTINGS.MENU_COLOR
    menuFrame.BorderSizePixel = 0
    menuFrame.Visible = false
    menuFrame.Active = true
    menuFrame.Draggable = true
    menuFrame.ZIndex = 5
    menuFrame.Parent = cheatGui
    
    local menuCorner = Instance.new("UICorner")
    menuCorner.CornerRadius = UDim.new(0, 12)
    menuCorner.Parent = menuFrame
    
    local menuStroke = Instance.new("UIStroke")
    menuStroke.Color = Color3.fromRGB(0, 220, 90)
    menuStroke.Thickness = 2
    menuStroke.Parent = menuFrame
    
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 110, 1, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    sidebar.BorderSizePixel = 0
    sidebar.ZIndex = 6
    sidebar.Parent = menuFrame
    
    local sideCorner = Instance.new("UICorner")
    sideCorner.CornerRadius = UDim.new(0, 12)
    sideCorner.Parent = sidebar
    
    local sideCover = Instance.new("Frame")
    sideCover.Size = UDim2.new(0, 20, 1, 0)
    sideCover.Position = UDim2.new(1, -20, 0, 0)
    sideCover.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    sideCover.BorderSizePixel = 0
    sideCover.ZIndex = 6
    sideCover.Parent = sidebar
    
    local menuTitle = Instance.new("TextLabel")
    menuTitle.Size = UDim2.new(1, 0, 0, 30)
    menuTitle.Position = UDim2.new(0, 0, 0, 10)
    menuTitle.BackgroundTransparency = 1
    menuTitle.Font = Enum.Font.GothamBold
    menuTitle.Text = "MANUL HUB"
    menuTitle.TextColor3 = Color3.fromRGB(0, 220, 90)
    menuTitle.TextSize = 13
    menuTitle.ZIndex = 7
    menuTitle.Parent = sidebar
    
    local espTab = Instance.new("TextButton")
    espTab.Size = UDim2.new(1, -20, 0, 40)
    espTab.Position = UDim2.new(0, 10, 0, 55)
    espTab.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    espTab.Text = TEXTS[SETTINGS.LANG].ESP
    espTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    espTab.Font = Enum.Font.GothamBold
    espTab.TextSize = 14
    espTab.ZIndex = 7
    espTab.Parent = sidebar
    
    local espTabCorner = Instance.new("UICorner")
    espTabCorner.CornerRadius = UDim.new(0, 8)
    espTabCorner.Parent = espTab
    
    local othersTab = Instance.new("TextButton")
    othersTab.Size = UDim2.new(1, -20, 0, 40)
    othersTab.Position = UDim2.new(0, 10, 0, 100)
    othersTab.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    othersTab.Text = TEXTS[SETTINGS.LANG].OTHERS
    othersTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    othersTab.Font = Enum.Font.GothamBold
    othersTab.TextSize = 12
    othersTab.ZIndex = 7
    othersTab.Parent = sidebar
    
    local othersTabCorner = Instance.new("UICorner")
    othersTabCorner.CornerRadius = UDim.new(0, 8)
    othersTabCorner.Parent = othersTab
    
    local settingsTab = Instance.new("TextButton")
    settingsTab.Size = UDim2.new(1, -20, 0, 40)
    settingsTab.Position = UDim2.new(0, 10, 0, 145)
    settingsTab.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    settingsTab.Text = TEXTS[SETTINGS.LANG].SETTINGS
    settingsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    settingsTab.Font = Enum.Font.GothamBold
    settingsTab.TextSize = 11
    settingsTab.ZIndex = 7
    settingsTab.Parent = sidebar
    
    local settingsTabCorner = Instance.new("UICorner")
    settingsTabCorner.CornerRadius = UDim.new(0, 8)
    settingsTabCorner.Parent = settingsTab
    
    local byLabel = Instance.new("TextLabel")
    byLabel.Size = UDim2.new(1, -20, 0, 20)
    byLabel.Position = UDim2.new(0, 10, 1, -30)
    byLabel.BackgroundTransparency = 1
    byLabel.Font = Enum.Font.Gotham
    byLabel.Text = "by Manul"
    byLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
    byLabel.TextSize = 12
    byLabel.TextXAlignment = Enum.TextXAlignment.Left
    byLabel.ZIndex = 7
    byLabel.Parent = sidebar
    
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.fromOffset(35, 35)
    minimizeBtn.Position = UDim2.new(1, -50, 0, 10)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    minimizeBtn.Text = "−"
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 24
    minimizeBtn.ZIndex = 15
    minimizeBtn.Active = true
    minimizeBtn.Parent = menuFrame
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 8)
    minCorner.Parent = minimizeBtn
    
    local minStroke = Instance.new("UIStroke")
    minStroke.Color = Color3.fromRGB(0, 220, 90)
    minStroke.Thickness = 1.5
    minStroke.Parent = minimizeBtn
    
    local resizeBR = Instance.new("TextButton")
    resizeBR.Size = UDim2.fromOffset(20, 20)
    resizeBR.Position = UDim2.new(1, -20, 1, -20)
    resizeBR.BackgroundColor3 = Color3.fromRGB(0, 220, 90)
    resizeBR.Text = ""
    resizeBR.ZIndex = 9
    resizeBR.Parent = menuFrame
    
    local resizeBRCorner = Instance.new("UICorner")
    resizeBRCorner.CornerRadius = UDim.new(0, 4)
    resizeBRCorner.Parent = resizeBR
    
    local espContent = Instance.new("Frame")
    espContent.Size = UDim2.new(1, -130, 1, -20)
    espContent.Position = UDim2.new(0, 120, 0, 10)
    espContent.BackgroundTransparency = 1
    espContent.ZIndex = 7
    espContent.Parent = menuFrame
    
    local enemiesBtn = Instance.new("TextButton")
    enemiesBtn.Size = UDim2.new(1, 0, 0, 40)
    enemiesBtn.Position = UDim2.new(0, 0, 0, 0)
    enemiesBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    enemiesBtn.Text = TEXTS[SETTINGS.LANG].ENEMIES_ESP .. ": " .. TEXTS[SETTINGS.LANG].OFF
    enemiesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    enemiesBtn.Font = Enum.Font.GothamBold
    enemiesBtn.TextSize = 13
    enemiesBtn.ZIndex = 8
    enemiesBtn.Parent = espContent
    
    local enemiesCorner = Instance.new("UICorner")
    enemiesCorner.CornerRadius = UDim.new(0, 8)
    enemiesCorner.Parent = enemiesBtn
    
    local teamBtn = Instance.new("TextButton")
    teamBtn.Size = UDim2.new(1, 0, 0, 40)
    teamBtn.Position = UDim2.new(0, 0, 0, 45)
    teamBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    teamBtn.Text = TEXTS[SETTINGS.LANG].TEAM_ESP .. ": " .. TEXTS[SETTINGS.LANG].OFF
    teamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    teamBtn.Font = Enum.Font.GothamBold
    teamBtn.TextSize = 13
    teamBtn.ZIndex = 8
    teamBtn.Parent = espContent
    
    local teamCorner = Instance.new("UICorner")
    teamCorner.CornerRadius = UDim.new(0, 8)
    teamCorner.Parent = teamBtn
    
    local enemiesColorBtn = Instance.new("TextButton")
    enemiesColorBtn.Size = UDim2.new(1, 0, 0, 40)
    enemiesColorBtn.Position = UDim2.new(0, 0, 0, 90)
    enemiesColorBtn.BackgroundColor3 = SETTINGS.ENEMIES_COLOR
    enemiesColorBtn.Text = TEXTS[SETTINGS.LANG].ENEMIES_COLOR
    enemiesColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    enemiesColorBtn.Font = Enum.Font.GothamBold
    enemiesColorBtn.TextSize = 13
    enemiesColorBtn.ZIndex = 8
    enemiesColorBtn.Parent = espContent
    
    local enemiesColorCorner = Instance.new("UICorner")
    enemiesColorCorner.CornerRadius = UDim.new(0, 8)
    enemiesColorCorner.Parent = enemiesColorBtn
    
    local teamColorBtn = Instance.new("TextButton")
    teamColorBtn.Size = UDim2.new(1, 0, 0, 40)
    teamColorBtn.Position = UDim2.new(0, 0, 0, 135)
    teamColorBtn.BackgroundColor3 = SETTINGS.TEAM_COLOR
    teamColorBtn.Text = TEXTS[SETTINGS.LANG].TEAM_COLOR
    teamColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    teamColorBtn.Font = Enum.Font.GothamBold
    teamColorBtn.TextSize = 13
    teamColorBtn.ZIndex = 8
    teamColorBtn.Parent = espContent
    
    local teamColorCorner = Instance.new("UICorner")
    teamColorCorner.CornerRadius = UDim.new(0, 8)
    teamColorCorner.Parent = teamColorBtn
    
    local othersContent = Instance.new("Frame")
    othersContent.Size = UDim2.new(1, -130, 1, -20)
    othersContent.Position = UDim2.new(0, 120, 0, 10)
    othersContent.BackgroundTransparency = 1
    othersContent.Visible = false
    othersContent.ZIndex = 7
    othersContent.Parent = menuFrame
    
    local leavesBtn = Instance.new("TextButton")
    leavesBtn.Size = UDim2.new(1, 0, 0, 45)
    leavesBtn.Position = UDim2.new(0, 0, 0, 0)
    leavesBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    leavesBtn.Text = TEXTS[SETTINGS.LANG].NO_LEAVES .. ": " .. TEXTS[SETTINGS.LANG].OFF
    leavesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    leavesBtn.Font = Enum.Font.GothamBold
    leavesBtn.TextSize = 14
    leavesBtn.ZIndex = 8
    leavesBtn.Parent = othersContent
    
    local leavesCorner = Instance.new("UICorner")
    leavesCorner.CornerRadius = UDim.new(0, 8)
    leavesCorner.Parent = leavesBtn
    
    local fogBtn = Instance.new("TextButton")
    fogBtn.Size = UDim2.new(1, 0, 0, 45)
    fogBtn.Position = UDim2.new(0, 0, 0, 55)
    fogBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    fogBtn.Text = TEXTS[SETTINGS.LANG].NO_FOG .. ": " .. TEXTS[SETTINGS.LANG].OFF
    fogBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    fogBtn.Font = Enum.Font.GothamBold
    fogBtn.TextSize = 14
    fogBtn.ZIndex = 8
    fogBtn.Parent = othersContent
    
    local fogCorner = Instance.new("UICorner")
    fogCorner.CornerRadius = UDim.new(0, 8)
    fogCorner.Parent = fogBtn
    
    local settingsContent = Instance.new("Frame")
    settingsContent.Size = UDim2.new(1, -130, 1, -20)
    settingsContent.Position = UDim2.new(0, 120, 0, 10)
    settingsContent.BackgroundTransparency = 1
    settingsContent.Visible = false
    settingsContent.ZIndex = 7
    settingsContent.Parent = menuFrame
    
    local menuColorLabel = Instance.new("TextLabel")
    menuColorLabel.Size = UDim2.new(1, 0, 0, 25)
    menuColorLabel.Position = UDim2.new(0, 0, 0, 0)
    menuColorLabel.BackgroundTransparency = 1
    menuColorLabel.Font = Enum.Font.Gotham
    menuColorLabel.Text = TEXTS[SETTINGS.LANG].MENU_COLOR
    menuColorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    menuColorLabel.TextSize = 13
    menuColorLabel.TextXAlignment = Enum.TextXAlignment.Left
    menuColorLabel.ZIndex = 8
    menuColorLabel.Parent = settingsContent
    
    local menuColorBtn = Instance.new("TextButton")
    menuColorBtn.Size = UDim2.new(1, 0, 0, 40)
    menuColorBtn.Position = UDim2.new(0, 0, 0, 30)
    menuColorBtn.BackgroundColor3 = SETTINGS.MENU_COLOR
    menuColorBtn.Text = "Black"
    menuColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    menuColorBtn.Font = Enum.Font.GothamBold
    menuColorBtn.TextSize = 13
    menuColorBtn.ZIndex = 8
    menuColorBtn.Parent = settingsContent
    
    local menuColorCorner = Instance.new("UICorner")
    menuColorCorner.CornerRadius = UDim.new(0, 8)
    menuColorCorner.Parent = menuColorBtn
    
    local langLabel = Instance.new("TextLabel")
    langLabel.Size = UDim2.new(1, 0, 0, 25)
    langLabel.Position = UDim2.new(0, 0, 0, 80)
    langLabel.BackgroundTransparency = 1
    langLabel.Font = Enum.Font.Gotham
    langLabel.Text = TEXTS[SETTINGS.LANG].LANGUAGE
    langLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    langLabel.TextSize = 13
    langLabel.TextXAlignment = Enum.TextXAlignment.Left
    langLabel.ZIndex = 8
    langLabel.Parent = settingsContent
    
    local langBtn = Instance.new("TextButton")
    langBtn.Size = UDim2.new(1, 0, 0, 40)
    langBtn.Position = UDim2.new(0, 0, 0, 110)
    langBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    langBtn.Text = SETTINGS.LANG
    langBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    langBtn.Font = Enum.Font.GothamBold
    langBtn.TextSize = 14
    langBtn.ZIndex = 8
    langBtn.Parent = settingsContent
    
    local langCorner = Instance.new("UICorner")
    langCorner.CornerRadius = UDim.new(0, 8)
    langCorner.Parent = langBtn
    
    local menuColors = {
        {name_en = "Black", name_ru = "Чёрный", color = Color3.fromRGB(20, 20, 20)},
        {name_en = "Dark Blue", name_ru = "Тёмно-синий", color = Color3.fromRGB(15, 25, 45)},
        {name_en = "Dark Red", name_ru = "Тёмно-красный", color = Color3.fromRGB(45, 15, 15)},
        {name_en = "Dark Green", name_ru = "Тёмно-зелёный", color = Color3.fromRGB(15, 35, 20)},
        {name_en = "Dark Purple", name_ru = "Тёмно-фиолетовый", color = Color3.fromRGB(35, 15, 45)},
        {name_en = "Gray", name_ru = "Серый", color = Color3.fromRGB(40, 40, 40)},
    }
    local colorIndex = 1
    
    local function updateAllTexts()
        local T = TEXTS[SETTINGS.LANG]
        espTab.Text = T.ESP
        othersTab.Text = T.OTHERS
        settingsTab.Text = T.SETTINGS
        enemiesBtn.Text = T.ENEMIES_ESP .. ": " .. (SETTINGS.ENEMIES_ESP and T.ON or T.OFF)
        teamBtn.Text = T.TEAM_ESP .. ": " .. (SETTINGS.TEAM_ESP and T.ON or T.OFF)
        enemiesColorBtn.Text = T.ENEMIES_COLOR
        teamColorBtn.Text = T.TEAM_COLOR
        leavesBtn.Text = T.NO_LEAVES .. ": " .. (SETTINGS.NO_LEAVES and T.ON or T.OFF)
        fogBtn.Text = T.NO_FOG .. ": " .. (SETTINGS.NO_FOG and T.ON or T.OFF)
        menuColorLabel.Text = T.MENU_COLOR
        langLabel.Text = T.LANGUAGE
        langBtn.Text = SETTINGS.LANG
        menuColorBtn.Text = (SETTINGS.LANG == "RU") and menuColors[colorIndex].name_ru or menuColors[colorIndex].name_en
    end
    
    local function showTab(tab)
        espContent.Visible = (tab == "esp")
        othersContent.Visible = (tab == "others")
        settingsContent.Visible = (tab == "settings")
        espTab.BackgroundColor3 = (tab == "esp") and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(35, 35, 40)
        othersTab.BackgroundColor3 = (tab == "others") and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(35, 35, 40)
        settingsTab.BackgroundColor3 = (tab == "settings") and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(35, 35, 40)
    end
    
    espTab.MouseButton1Click:Connect(function() showTab("esp") end)
    othersTab.MouseButton1Click:Connect(function() showTab("others") end)
    settingsTab.MouseButton1Click:Connect(function() showTab("settings") end)
    
    circleBtn.MouseButton1Click:Connect(function()
        circleBtn.Visible = false
        menuFrame.Visible = true
    end)
    
    minimizeBtn.MouseButton1Click:Connect(function()
        menuFrame.Visible = false
        circleBtn.Visible = true
    end)
    
    enemiesBtn.MouseButton1Click:Connect(function()
        SETTINGS.ENEMIES_ESP = not SETTINGS.ENEMIES_ESP
        updateAllTexts()
        enemiesBtn.BackgroundColor3 = SETTINGS.ENEMIES_ESP and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(35, 35, 40)
    end)
    
    teamBtn.MouseButton1Click:Connect(function()
        SETTINGS.TEAM_ESP = not SETTINGS.TEAM_ESP
        updateAllTexts()
        teamBtn.BackgroundColor3 = SETTINGS.TEAM_ESP and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(35, 35, 40)
    end)
    
    enemiesColorBtn.MouseButton1Click:Connect(function()
        local colors = {
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(255, 100, 0),
            Color3.fromRGB(255, 0, 255),
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(255, 255, 255),
        }
        local idx = 1
        for i, c in ipairs(colors) do
            if c == SETTINGS.ENEMIES_COLOR then idx = i % #colors + 1 break end
        end
        SETTINGS.ENEMIES_COLOR = colors[idx]
        enemiesColorBtn.BackgroundColor3 = SETTINGS.ENEMIES_COLOR
        for _, obj in pairs(espObjects) do
            if obj:GetAttribute("Type") == "Enemy" then obj.FillColor = SETTINGS.ENEMIES_COLOR end
        end
    end)
    
    teamColorBtn.MouseButton1Click:Connect(function()
        local colors = {
            Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 255, 255),
            Color3.fromRGB(0, 100, 255),
            Color3.fromRGB(255, 255, 255),
            Color3.fromRGB(255, 255, 0),
        }
        local idx = 1
        for i, c in ipairs(colors) do
            if c == SETTINGS.TEAM_COLOR then idx = i % #colors + 1 break end
        end
        SETTINGS.TEAM_COLOR = colors[idx]
        teamColorBtn.BackgroundColor3 = SETTINGS.TEAM_COLOR
        for _, obj in pairs(espObjects) do
            if obj:GetAttribute("Type") == "Team" then obj.FillColor = SETTINGS.TEAM_COLOR end
        end
    end)
    
    menuColorBtn.MouseButton1Click:Connect(function()
        colorIndex = colorIndex % #menuColors + 1
        SETTINGS.MENU_COLOR = menuColors[colorIndex].color
        menuFrame.BackgroundColor3 = SETTINGS.MENU_COLOR
        menuColorBtn.BackgroundColor3 = SETTINGS.MENU_COLOR
        menuColorBtn.Text = (SETTINGS.LANG == "RU") and menuColors[colorIndex].name_ru or menuColors[colorIndex].name_en
    end)
    
    langBtn.MouseButton1Click:Connect(function()
        SETTINGS.LANG = (SETTINGS.LANG == "EN") and "RU" or "EN"
        updateAllTexts()
    end)
    
    leavesBtn.MouseButton1Click:Connect(function()
        SETTINGS.NO_LEAVES = not SETTINGS.NO_LEAVES
        updateAllTexts()
        leavesBtn.BackgroundColor3 = SETTINGS.NO_LEAVES and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(35, 35, 40)
        
        if SETTINGS.NO_LEAVES then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("leaf") or obj.Name:lower():find("leaves") or obj.Name:lower():find("tree")) then
                    if obj.Transparency < 1 then
                        hiddenLeaves[obj] = obj.Transparency
                        obj.Transparency = 1
                    end
                end
            end
        else
            for obj, transparency in pairs(hiddenLeaves) do
                if obj and obj.Parent then obj.Transparency = transparency end
            end
            hiddenLeaves = {}
        end
    end)
    
    fogBtn.MouseButton1Click:Connect(function()
        SETTINGS.NO_FOG = not SETTINGS.NO_FOG
        updateAllTexts()
        fogBtn.BackgroundColor3 = SETTINGS.NO_FOG and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(35, 35, 40)
        
        if SETTINGS.NO_FOG then
            originalFog.End = Lighting.FogEnd
            originalFog.Start = Lighting.FogStart
            originalFog.Color = Lighting.FogColor
            Lighting.FogEnd = 100000
            Lighting.FogStart = 100000
            Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        else
            Lighting.FogEnd = originalFog.End
            Lighting.FogStart = originalFog.Start
            Lighting.FogColor = originalFog.Color
        end
    end)
    
    local resizing = false
    local resizeStart = nil
    local startSize = nil
    
    local function startResize(input)
        resizing = true
        resizeStart = input.Position
        startSize = menuFrame.AbsoluteSize
    end
    
    local function updateResize(input)
        if not resizing then return end
        local delta = input.Position - resizeStart
        local newX = math.max(200, startSize.X + delta.X)
        local newY = math.max(150, startSize.Y + delta.Y)
        menuFrame.Size = UDim2.fromOffset(newX, newY)
    end
    
    local function stopResize()
        resizing = false
    end
    
    resizeBR.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            startResize(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            updateResize(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            stopResize()
        end
    end)
    
    local function getPlayerCharacter(p)
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            return p.Character
        end
        return nil
    end
    
    local function isEnemy(p)
        if p == player then return false end
        if p.Character and player.Character then
            if p.Character.Parent == player.Character.Parent then
                return false
            end
        end
        return true
    end
    
    local function createESP(character, enemyFlag)
        if not character then return end
        if espObjects[character] then espObjects[character]:Destroy() end
        
        local highlight = Instance.new("Highlight")
        highlight.Adornee = character
        highlight.FillColor = enemyFlag and SETTINGS.ENEMIES_COLOR or SETTINGS.TEAM_COLOR
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.OutlineTransparency = 0.3
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight:SetAttribute("Type", enemyFlag and "Enemy" or "Team")
        highlight.Parent = character
        
        espObjects[character] = highlight
    end
    
    local function updateESP()
        if SETTINGS.ENEMIES_ESP then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player then
                    local char = getPlayerCharacter(p)
                    if char and isEnemy(p) then
                        if not espObjects[char] or espObjects[char]:GetAttribute("Type") ~= "Enemy" then
                            createESP(char, true)
                        end
                    end
                end
            end
        else
            for char, obj in pairs(espObjects) do
                if obj:GetAttribute("Type") == "Enemy" then
                    obj:Destroy()
                    espObjects[char] = nil
                end
            end
        end
        
        if SETTINGS.TEAM_ESP then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player then
                    local char = getPlayerCharacter(p)
                    if char and not isEnemy(p) then
                        if not espObjects[char] or espObjects[char]:GetAttribute("Type") ~= "Team" then
                            createESP(char, false)
                        end
                    end
                end
            end
        else
            for char, obj in pairs(espObjects) do
                if obj:GetAttribute("Type") == "Team" then
                    obj:Destroy()
                    espObjects[char] = nil
                end
            end
        end
    end
    
    RunService.RenderStepped:Connect(function()
        updateESP()
    end)
end

loadCheat()