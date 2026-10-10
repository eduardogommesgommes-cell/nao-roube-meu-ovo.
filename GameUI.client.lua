-- Interface inicial: escolha Solo/Multiplayer (seleção visual do modo).
-- Coloque como LocalScript em StarterPlayer > StarterPlayerScripts > GameUI.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "NRMO_Menu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Name = "Menu"
panel.Size = UDim2.fromOffset(340, 210)
panel.Position = UDim2.new(0.5, -170, 0.78, -105)
panel.BackgroundColor3 = Color3.fromRGB(24, 28, 42)
panel.BackgroundTransparency = 0.08
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 18)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 58)
title.Position = UDim2.fromOffset(10, 6)
title.BackgroundTransparency = 1
title.Text = "NÃO ROUBE MEU OVO\nVERSÃO MEMES BR"
title.TextColor3 = Color3.fromRGB(255, 226, 80)
title.TextStrokeTransparency = 0.5
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.Parent = panel

local function makeButton(text, color, pos, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(145, 66)
    b.Position = pos
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.TextScaled = true
    b.Font = Enum.Font.GothamBold
    b.Parent = panel
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 12)
    b.Activated:Connect(callback)
    return b
end

local function chooseMode(mode)
    player:SetAttribute("ModoEscolhido", mode)
    title.Text = "MODO " .. string.upper(mode) .. "\nBoa sorte com o ovo!"
    task.delay(2.5, function()
        if gui.Parent then gui:Destroy() end
    end)
end

makeButton("👤 SOLO", Color3.fromRGB(30, 145, 255), UDim2.fromOffset(16, 125), function()
    chooseMode("Solo")
end)
makeButton("👥 MULTIPLAYER", Color3.fromRGB(155, 70, 235), UDim2.fromOffset(179, 125), function()
    chooseMode("Multiplayer")
end)
