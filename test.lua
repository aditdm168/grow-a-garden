--[[ AUTO FARM & AUTO SELL | GROW A GARDEN ]]--

-- Konfigurasi:
local JEDA_PANEN = 1       -- jeda detik antar panen
local JEDA_JUAL = 2        -- jeda detik saat jual jika tas penuh

-- Fungsi Cek Inventory
function isBackpackFull()
    local player = game.Players.LocalPlayer
    local stats = player:FindFirstChild("Backpack")
    if stats and stats:FindFirstChild("Value") and stats:FindFirstChild("MaxValue") then
        return stats.Value.Value >= stats.MaxValue.Value
    end
    return false
end

-- Fungsi Auto Panen
function autoHarvest()
    while wait(JEDA_PANEN) do
        for _, plant in pairs(workspace:GetDescendants()) do
            if plant:IsA("ProximityPrompt") and plant.Name == "HarvestPrompt" then
                fireproximityprompt(plant)
            end
        end
    end
end

-- Fungsi Auto Jual Hasil Panen
function autoSell()
    while wait(JEDA_JUAL) do
        if isBackpackFull() then
            local sellPart = workspace:FindFirstChild("SellArea") or workspace:FindFirstChild("Sell")
            if sellPart then
                game.Players.LocalPlayer.Character:PivotTo(sellPart.CFrame + Vector3.new(0, 2, 0))
                wait(1)
            end
        end
    end
end

-- Jalankan dua fungsi secara bersamaan
spawn(autoHarvest)
spawn(autoSell)
