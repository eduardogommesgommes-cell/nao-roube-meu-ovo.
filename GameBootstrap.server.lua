-- Não Roube Meu Ovo — Versão Memes BR
-- Protótipo inicial: mapa reto, zonas coloridas, pods de incubação e perseguição simples.
-- Coloque este Script em ServerScriptService como GameBootstrap.

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local old = Workspace:FindFirstChild("NRMO_World")
if old then old:Destroy() end

local world = Instance.new("Folder")
world.Name = "NRMO_World"
world.Parent = Workspace

local function part(name, size, cf, color, material, parent)
    local p = Instance.new("Part")
    p.Name = name
    p.Size = size
    p.CFrame = cf
    p.Anchored = true
    p.Color = color
    p.Material = material or Enum.Material.SmoothPlastic
    p.TopSurface = Enum.SurfaceType.Smooth
    p.BottomSurface = Enum.SurfaceType.Smooth
    p.Parent = parent or world
    return p
end

local function label(adornee, text, color)
    local gui = Instance.new("BillboardGui")
    gui.Name = "Label"
    gui.Size = UDim2.fromOffset(220, 60)
    gui.StudsOffset = Vector3.new(0, 4, 0)
    gui.AlwaysOnTop = true
    gui.Adornee = adornee
    gui.Parent = adornee
    local t = Instance.new("TextLabel")
    t.Size = UDim2.fromScale(1, 1)
    t.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    t.BackgroundTransparency = 0.15
    t.TextColor3 = color or Color3.new(1,1,1)
    t.TextStrokeTransparency = 0.3
    t.Font = Enum.Font.GothamBold
    t.TextScaled = true
    t.Text = text
    t.Parent = gui
end

local zones = {
    {name="FÁCIL", color=Color3.fromRGB(58, 200, 87), x=0, meme="Caramelo"},
    {name="NORMAL", color=Color3.fromRGB(48, 140, 245), x=180, meme="Capivara"},
    {name="DIFÍCIL", color=Color3.fromRGB(248, 202, 56), x=360, meme="Pombo do Caos"},
    {name="MUITO DIFÍCIL", color=Color3.fromRGB(244, 123, 45), x=540, meme="Crocodilo Bombado"},
    {name="INSANO", color=Color3.fromRGB(157, 73, 229), x=720, meme="Gato do Leite"},
}
local laneWidth, zoneLength = 56, 180
part("PistaPrincipal", Vector3.new(laneWidth, 2, 930), CFrame.new(360, -1, 0), Color3.fromRGB(120, 190, 95), Enum.Material.Grass)

-- Spawn e área inicial
local spawn = Instance.new("SpawnLocation")
spawn.Name = "InicioJogadores"
spawn.Size = Vector3.new(42, 1, 30)
spawn.CFrame = CFrame.new(-65, 0, 0)
spawn.Anchored = true
spawn.Neutral = true
spawn.Color = Color3.fromRGB(50, 210, 120)
spawn.Parent = world
label(spawn, "INÍCIO • PREPARE-SE", Color3.fromRGB(120,255,160))

-- Limites laterais da pista
part("MuroEsquerdo", Vector3.new(930, 18, 2), CFrame.new(360, 8, -laneWidth/2), Color3.fromRGB(100, 76, 55), Enum.Material.Brick)
part("MuroDireito", Vector3.new(930, 18, 2), CFrame.new(360, 8, laneWidth/2), Color3.fromRGB(100, 76, 55), Enum.Material.Brick)

-- Estações/zonas: pista reta, sem obstáculos de parkour
for i, zone in ipairs(zones) do
    local centerX = zone.x + zoneLength/2
    local strip = part("Zona_" .. zone.name, Vector3.new(zoneLength, 0.25, laneWidth-4),
        CFrame.new(centerX, 0.15, 0), zone.color, Enum.Material.SmoothPlastic)
    strip.Transparency = 0.28
    label(strip, zone.name .. " • " .. zone.meme, Color3.new(1,1,1))

    -- Cápsula de exposição/ incubadora, não um cercado
    local podX = zone.x + 48
    local base = part("PodBase_" .. i, Vector3.new(22, 2, 18), CFrame.new(podX, 1.4, -14),
        zone.color, Enum.Material.Metal)
    local back = part("PodBack_" .. i, Vector3.new(18, 12, 1), CFrame.new(podX, 7.5, -22),
        Color3.fromRGB(35, 40, 55), Enum.Material.Glass)
    back.Transparency = 0.35
    local side1 = part("PodSideA_" .. i, Vector3.new(1, 10, 16), CFrame.new(podX-9, 6.5, -14),
        zone.color, Enum.Material.Glass)
    side1.Transparency = 0.45
    local side2 = part("PodSideB_" .. i, Vector3.new(1, 10, 16), CFrame.new(podX+9, 6.5, -14),
        zone.color, Enum.Material.Glass)
    side2.Transparency = 0.45
    local egg = part("Ovo_" .. i, Vector3.new(5, 7, 5), CFrame.new(podX, 5.7, -13),
        Color3.fromRGB(255, 225, 100), Enum.Material.Neon)
    egg.Shape = Enum.PartType.Ball
    egg:SetAttribute("ZoneIndex", i)
    egg:SetAttribute("MemeName", zone.meme)
    label(egg, "OVO: " .. zone.meme, zone.color)

    -- Personagem provisório com corpo simples, para trocar por modelo próprio depois
    local dummy = Instance.new("Model")
    dummy.Name = "Guardiao_" .. zone.meme:gsub("%s+", "")
    dummy.Parent = world
    local torso = Instance.new("Part")
    torso.Name = "HumanoidRootPart"
    torso.Size = Vector3.new(5, 6, 4)
    torso.CFrame = CFrame.new(podX, 5, 3)
    torso.Anchored = true
    torso.Color = zone.color
    torso.Material = Enum.Material.SmoothPlastic
    torso.Parent = dummy
    dummy.PrimaryPart = torso
    local head = part("Cabeca", Vector3.new(4, 4, 4), CFrame.new(podX, 10, 3),
        Color3.fromRGB(220, 170, 120), Enum.Material.SmoothPlastic, dummy)
    head.Shape = Enum.PartType.Ball
    label(torso, zone.meme, zone.color)
end

-- 10 nomes iniciais para personagens planejados; os modelos começam como placeholders.
local characterNames = {
    "Caramelo", "Capivara Tranquila", "Pombo do Caos", "Crocodilo Bombado",
    "Gato do Leite", "Capivara de Óculos", "Pato Nervoso", "Sapo Julgador",
    "Quati Ladrão", "Vaca Maluca"
}
local roster = Instance.new("Folder")
roster.Name = "CatalogoMemesBR"
roster.Parent = world
for i, name in ipairs(characterNames) do
    local entry = Instance.new("StringValue")
    entry.Name = "Personagem" .. string.format("%02d", i)
    entry.Value = name
    entry.Parent = roster
end

-- Pontos de entrega e estado de cada jogador
local delivery = part("EntregaDoOvo", Vector3.new(22, 1, 22), CFrame.new(-30, 0.6, 0),
    Color3.fromRGB(255, 210, 45), Enum.Material.Neon)
label(delivery, "ENTREGUE O OVO AQUI", Color3.fromRGB(255,240,120))

local carrying = {}
local chaseParts = {}
for _, child in ipairs(world:GetChildren()) do
    if child:IsA("Model") and child.Name:match("^Guardiao_") and child.PrimaryPart then
        table.insert(chaseParts, child.PrimaryPart)
    end
end

local function makePrompt(egg)
    local prompt = Instance.new("ProximityPrompt")
    prompt.ActionText = "Roubar ovo"
    prompt.ObjectText = egg:GetAttribute("MemeName") or "Ovo"
    prompt.KeyboardKeyCode = Enum.KeyCode.E
    prompt.HoldDuration = 0.5
    prompt.MaxActivationDistance = 12
    prompt.RequiresLineOfSight = false
    prompt.Parent = egg
    prompt.Triggered:Connect(function(player)
        if carrying[player] then return end
        carrying[player] = true
        player:SetAttribute("CarregandoOvo", true)
        player:SetAttribute("OvoNome", egg:GetAttribute("MemeName"))
        egg.Transparency = 0.85
        prompt.Enabled = false
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local carried = Instance.new("Part")
            carried.Name = "OvoCarregado"
            carried.Shape = Enum.PartType.Ball
            carried.Size = Vector3.new(2.5, 3, 2.5)
            carried.Color = Color3.fromRGB(255, 225, 100)
            carried.Material = Enum.Material.Neon
            carried.CanCollide = false
            carried.Massless = true
            carried.CFrame = root.CFrame * CFrame.new(0, 2.5, -1.5)
            carried.Parent = char
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = root
            weld.Part1 = carried
            weld.Parent = carried
        end
    end)
end

for _, item in ipairs(world:GetChildren()) do
    if item:IsA("Part") and item.Name:match("^Ovo_") then
        makePrompt(item)
    end
end

local lastChase = 0
RunService.Heartbeat:Connect(function(dt)
    lastChase += dt
    if lastChase < 0.12 then return end
    lastChase = 0
    for player, isCarrying in pairs(carrying) do
        if isCarrying and player.Parent == Players then
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                -- O guardião da zona fácil persegue o jogador com ovo.
                local guard = world:FindFirstChild("Guardiao_Caramelo")
                if guard and guard.PrimaryPart then
                    local target = root.Position
                    local current = guard.PrimaryPart.Position
                    local flatTarget = Vector3.new(target.X, current.Y, target.Z)
                    local direction = flatTarget - current
                    if direction.Magnitude > 3 then
                        guard:PivotTo(CFrame.new(current + direction.Unit * math.min(34 * dt, direction.Magnitude), flatTarget))
                    end
                    if (root.Position - guard.PrimaryPart.Position).Magnitude < 6 then
                        carrying[player] = false
                        player:SetAttribute("CarregandoOvo", false)
                        local carried = char:FindFirstChild("OvoCarregado")
                        if carried then carried:Destroy() end
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum then hum.Health = math.max(1, hum.Health - 25) end
                        local egg = world:FindFirstChild("Ovo_1")
                        if egg then
                            egg.Transparency = 0
                            local prompt = egg:FindFirstChildOfClass("ProximityPrompt")
                            if prompt then prompt.Enabled = true end
                        end
                    end
                end
                if (root.Position - delivery.Position).Magnitude < 12 then
                    carrying[player] = false
                    player:SetAttribute("CarregandoOvo", false)
                    local carried = char:FindFirstChild("OvoCarregado")
                    if carried then carried:Destroy() end
                    local stats = player:FindFirstChild("leaderstats")
                    if stats and stats:FindFirstChild("Dinheiro") then
                        stats.Dinheiro.Value += 25
                    end
                    local egg = world:FindFirstChild("Ovo_1")
                    if egg then
                        egg.Transparency = 0
                        local prompt = egg:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then prompt.Enabled = true end
                    end
                end
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(player)
    local stats = Instance.new("Folder")
    stats.Name = "leaderstats"
    stats.Parent = player
    local money = Instance.new("IntValue")
    money.Name = "Dinheiro"
    money.Value = 0
    money.Parent = stats
    player:SetAttribute("CarregandoOvo", false)
end)

Players.PlayerRemoving:Connect(function(player)
    carrying[player] = nil
end)

print("Não Roube Meu Ovo — mapa protótipo carregado.")
