-- Auto Harvest, Auto Sell, Inventory Tracker

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Ganti path sesuai game-mu:
local harvestEvent = replicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("HarvestCrop")
local sellEvent = replicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SellAllCrops")
local inventory = player:WaitForChild("Inventory")

-- AUTO HARVEST
spawn(function()
    while true do
        for _, crop in pairs(workspace.Crops:GetChildren()) do
            if crop:FindFirstChild("Ready") and crop.Ready.Value == true then
                harvestEvent:FireServer(crop)
                wait(0.1)
            end
        end
        wait(1)
    end
end)

-- AUTO SELL jika inventory penuh
local function isInventoryFull()
    local current, maxStorage = 0, inventory.MaxStorage and inventory.MaxStorage.Value or 100
    for _, item in pairs(inventory:GetChildren()) do
        if item:IsA("IntValue") then
            current = current + item.Value
        end
    end
    return current >= maxStorage
end

spawn(function()
    while true do
        if isInventoryFull() then
            sellEvent:FireServer()
            wait(1)
        end
        wait(2)
    end
end)

-- INVENTORY TRACKER (print tiap 5 detik)
spawn(function()
    while true do
        print("== INVENTORY ==")
        for _, item in pairs(inventory:GetChildren()) do
            if item:IsA("IntValue") then
                print(item.Name .. ": " .. item.Value)
            end
        end
        wait(5)
    end
end)
