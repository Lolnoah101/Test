local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "[Merchant] Dropper Incremental", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local Tab = Window:MakeTab({
    Name = "Auto Features",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
------------------------------------------------------------------------------------------------------------------------------------------------
local autoClickEnabled = false

Tab:AddToggle({
    Name = "AutoClick",
    Default = false,
    Callback = function(Value)
        autoClickEnabled = Value -- Update based on toggle state

        if autoClickEnabled then
            task.spawn(function()
                while autoClickEnabled do
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DropperClick"):FireServer()
                    task.wait() -- Short delay to avoid overwhelming the server
                end
            end)
        end
    end
})
------------------------------------------------------------------------------------------------------------------------------------------------
local autoUpgradesEnabled = false

local Toggle = Tab:AddToggle({
    Name = "CashUpgrades",
    Default = false,
    Callback = function(Value)
        autoUpgradesEnabled = Value
        
        if autoUpgradesEnabled then
            task.spawn(function()
                while autoUpgradesEnabled do
                
                    -- Add all your cash upgrade names here
                    local upgrades = {
                        "CashMoreCash",
                        "CashMoreXP",
                        "CashFasterButton"
                    }
                    
                    local remotes = game:GetService("ReplicatedStorage").Remotes
                    local upgradeRemote = remotes:WaitForChild("Upgrade")
                    
                    for _, upgradeName in ipairs(upgrades) do
                        local args = {
                            "Cash",      -- category (same for all cash)
                            upgradeName, -- specific upgrade
                            true         -- the boolean flag
                        }
                        upgradeRemote:FireServer(unpack(args))
                        task.wait(1)  -- delay between each (0.4–1.2s if needed)
                    end
                    
                    task.wait(5)   -- big wait after full cycle
                end
            end)
        end
    end
})
------------------------------------------------------------------------------------------------------------------------------------------------
Tab:AddLabel("                                          REBIRTH FEATURES         ")

local autoRebirthEnabled = false
local autoRebirthUpgradesEnabled = false

Tab:AddToggle({
    Name = "Auto Rebirth",
    Default = false,
    Callback = function(Value)
        autoRebirthEnabled = Value -- Update based on toggle state

        if autoRebirthEnabled then
            task.spawn(function()
                while autoRebirthEnabled do
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Rebirth"):FireServer()
                    task.wait(60)
                end
            end)
        end
    end
})

local Toggle = Tab:AddToggle({
    Name = "Rebirth Upgrades",
    Default = false,
    Callback = function(Value)
        autoRebirthUpgradesEnabled = Value
        
        if autoRebirthUpgradesEnabled then
            task.spawn(function()
                while autoRebirthUpgradesEnabled do              
                    -- Add all your cash upgrade names here
                    local upgrades = {
                        "RebirthMoreCash",
                        "RebirthMoreXP",
                        "RebirthMoreRebirthPoints",
                    }
                    
                    local remotes = game:GetService("ReplicatedStorage").Remotes
                    local upgradeRemote = remotes:WaitForChild("Upgrade")
                    
                    for _, upgradeName in ipairs(upgrades) do
                        local args = {
                            "RebirthPoints",      -- category (same for all rebirth points)
                            upgradeName, -- specific upgrade
                            true         -- the boolean flag
                        }
                        upgradeRemote:FireServer(unpack(args))
                        task.wait(1)   -- delay between each (0.4–1.2s if needed)
                    end
                    
                    task.wait(10)   -- big wait after full cycle
                end
            end)
        end
    end
})
------------------------------------------------------------------------------------------------------------------------------------------------
Tab:AddLabel("                                          TREE FEATURES         ")

local treeUpgradeEnabled = false

Tab:CreateToggle({
   Name = "Tree Upgrades",
   CurrentValue = false,
   Flag = "TreeUnlocks",
   Callback = function(Value)
      treeUpgradeEnabled = Value
      
      if Value then
         task.spawn(function()
            while treeUpgradeEnabled do
               pcall(function()
                  local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
                  local treeUpgradeRemote = remotes:WaitForChild("TreeUpgrade")  -- ← FIXED: Use dedicated TreeUpgrade remote (like your working old GUI)
                  
                  local upgrades = {
                     "TreeMoreCash", "TreeMoreWalkspeed", "TreeMoreXP", "TreeMoreCoins",
                     "TreeMoreCash2", "TreeMoreCollectionRange", "TreeMoreSpawnCap",
                     "TreeMoreSpawnBulk", "TreeRebirthBoostsCash", "TreeMoreCoins2",
                     "TreeUnlockReading", "TreeMoreCoins3", "TreeMoreReadingPoints",
                     "TreeMoreCash3", "TreeCheaperBooks", "TreeMoreXP2", "TreeCoinsBoostXP"
                  }
                  
                  for _, upgradeName in ipairs(upgrades) do
                     if not treeUpgradeEnabled then break end
                     
                     print("Buying:", upgradeName)  -- DEBUG: see what it's attempting
                     
                     treeUpgradeRemote:FireServer(upgradeName)  -- ← FIXED: Single arg (upgrade name only) like your working old GUI
                     task.wait(0.6)  -- ← Back to 0.6s (matches your old working code)
                  end
                  
                  task.wait(10)  -- ← Back to 10s cooldown (matches your old working code)
               end)
               task.wait(0.5)
            end
         end)
      end
   end,
})------------------------------------------------------------------------------------------------------------------------------------------------
Tab:AddLabel("                                          COIN FEATURES         ")

local autoCollectEnabled = false

local Toggle = Tab:AddToggle({
    Name = "Collect Coins",
    Default = false,
    Callback = function(Value)
        autoCollectEnabled = Value
        
        if Value then
            task.spawn(function()
                while autoCollectEnabled do
                    
                    local spawnedFolder = workspace:FindFirstChild("MapEssentials") 
                        and workspace.MapEssentials:FindFirstChild("Spawned")
                    
                    if spawnedFolder then
                        for _, coin in ipairs(spawnedFolder:GetChildren()) do
                            local coinName = coin.Name
                            
                            -- Basic check: skip if name is empty or not a string/number-like
                            if coinName and #coinName > 0 then
                                local remotes = game:GetService("ReplicatedStorage").Remotes
                                local collectRemote = remotes:FindFirstChild("CollectPart")
                                
                                if collectRemote then
                                    collectRemote:FireServer(coinName)
                                    task.wait(0.1)  -- small delay between each collect to avoid rate-limits/kicks
                                end
                            end
                        end
                    end
                    
                    task.wait(0.1) -- loop delay — adjust if coins spawn very fast/slow
                end
            end)
        end
        -- When toggle turns off, the loop just stops naturally
    end
})

local coinUpgradesEnabled = false

local Toggle = Tab:AddToggle({
    Name = "Coin Upgrades",
    Default = false,
    Callback = function(Value)
        coinUpgradesEnabled = Value
        
        if coinUpgradesEnabled then
            task.spawn(function()
                while coinUpgradesEnabled do
                
                    -- Add all your coin upgrade names here (like TreeMoreCash → CoinsMoreCash)
                    local upgrades = {
                        "CoinsMoreCash",
                        "CoinsMoreXP",
                        "CoinsFasterSpawn",
                    }
                    
                    local remotes = game:GetService("ReplicatedStorage").Remotes
                    local upgradeRemote = remotes:WaitForChild("Upgrade")
                    
                    for _, upgradeName in ipairs(upgrades) do
                        local args = {
                            "Coins",     -- category (same for all coins)
                            upgradeName, -- specific upgrade
                            true         -- the boolean flag
                        }
                        upgradeRemote:FireServer(unpack(args))
                        task.wait(0.6)   -- delay between each upgrade (adjust 0.4–1.2s if needed)
                    end
                    
                    task.wait(10)   -- big wait after full cycle (your original)
                end
            end)
        end
    end
})
------------------------------------------------------------------------------------------------------------------------------------------------
Tab:AddLabel("                                          BOOK FEATURES         ")

local autoBuyBooksEnabled = false

Tab:AddToggle({
    Name = "Buy Books",
    Default = false,
    Callback = function(Value)
        autoBuyBooksEnabled = Value -- Update based on toggle state

        if autoBuyBooksEnabled then
            task.spawn(function()
                while autoBuyBooksEnabled do
                    local args = {
                        true
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("BuyBook"):FireServer(unpack(args))
                    task.wait(10)
                end
            end)
        end
    end
})

local autoReadingUpgradesEnabled = false

local Toggle = Tab:AddToggle({
    Name = "Reading Upgrades",
    Default = false,
    Callback = function(Value)
        autoReadingUpgradesEnabled = Value
        
        if autoReadingUpgradesEnabled then
            task.spawn(function()
                while autoReadingUpgradesEnabled do
                
                    local upgrades = {
                        "ReadingMoreCash",
                        "ReadingMoreXP",
                        "ReadingMoreReadingPoints",
                        -- add more if you find them
                    }
                    
                    local remotes = game:GetService("ReplicatedStorage").Remotes
                    local upgradeRemote = remotes:WaitForChild("DepositUpgrade")
                    
                    -- Fire all upgrades in quick succession
                    for _, upgradeName in ipairs(upgrades) do
                        local args = {
                            upgradeName,   -- only the upgrade name
                        }
                        upgradeRemote:FireServer(unpack(args))
                        task.wait(10) -- ← small delay between each upgrade (adjust if needed)
                    end
                    
                    task.wait(30)   -- ← wait here after the full cycle (this is your repeat timer)
                end
            end)
        end
    end
})
------------------------------------------------------------------------------------------------------------------------------------------------
Tab:AddLabel("                                          CRYSTALIZE FEATURE         ")

local CrystalizeEnabled = false

local Toggle = Tab:AddToggle({
    Name = "Auto Crystalize",
    Default = false,
    Callback = function(Value)
        CrystalizeEnabled = Value
        
        if CrystalizeEnabled then
            task.spawn(function()
                while CrystalizeEnabled do
                    local remotes = game:GetService("ReplicatedStorage").Remotes
                    local crystalizeRemote = remotes:WaitForChild("Crystalize")
                    crystalizeRemote:FireServer()
                    task.wait(60)
                end
            end)
        end
    end
})
-------------------------------------------------------------------------------------------------------------------------------------------------
Tab:AddLabel("                                          ↓↓TREEUPGRADES2↓↓         ")

local crystalUpgrades = false

local Toggle = Tab:AddToggle({
    Name = "TreeUpgrades",
    Default = false,
    Callback = function(Value)
        crystalUpgrades = Value
        
        if crystalUpgrades then
            task.spawn(function()
                while crystalUpgrades do
                
                    local tree = {
                       "TreeCollectionBoosts",
                       "TreeStatBoosts",
                       "TreeMoreCrystals",
                       "TreeKeepPrestige",
                       "TreeAutoUpgrades",
                       "TreeLibrarian",
                       "TreeUnlockEnergy",
                       "TreeSafePrestige",
                       "TreeMoreEnergy",
                       "TreeMoreEnergyEquips",
                       "TreeMoreCrystals2",
                       "TreeMoreEnergy2",
                       "TreeUnlockDiamonds",
                       "TreeKeepCrystalUpgrades",
                       "TreeMoreDiamonds",
                       "TreeSafeCrystalize",
                       "TreeUnlockAscension",

                    }
                    
                    local remotes = game:GetService("ReplicatedStorage").Remotes
                    local merchantRemote = remotes:WaitForChild("TreeUpgrade")
                    
                    for _, tree in ipairs(tree) do
                        local args = {
                            tree
                        }
                        merchantRemote:FireServer(unpack(args))
                        task.wait(1)
                    end
                    task.wait(30)
                end
            end)
        end
    end
})
------------------------------------------------------------------------------------------------------------------------------------------------
local Tab = Window:MakeTab({
    Name = "Auto2",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Create a state variable
local PowerEnabled = false 
local energyCashEnabled = false
local energyRebirthEnabled = false
local energyReadingPointsEnabled = false
local energyCoinsEnabled = false
local energyXPEnabled = false
local energyCrystalsEnabled = false
Tab:AddLabel("                                          POWER FEATURE         ")
Tab:AddButton({
    Name = "Power",
    Callback = function()
        -- Always fire the remote command
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Power"):FireServer()
        -- Toggle the state
        PowerEnabled = not PowerEnabled
        
        if PowerEnabled then
            -- First click (ON state)
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "Power On!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("Power On!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "Power Off!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("Power off!")
        end
    end    
})
--------------------------------------------------------------------------------------------------------------------------------------------------
Tab:AddLabel("                                          ENERGY FEATURES         ")
local Section = Tab:AddSection({
	Name = "toggle off before using another"
})
Tab:AddButton({
    Name = "Cash",
    Callback = function()
        -- Always fire the remote command
        local args = {
            "EnergyMoreCash"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Energy"):FireServer(unpack(args))
        -- Toggle the state
        energyCashEnabled = not energyCashEnabled
        
        if energyCashEnabled then
            -- First click (ON state)
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "Energy Cash Activated!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("Cash activated!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "Cash Off!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("Cash off!")
        end
    end    
})

Tab:AddButton({
    Name = "Rebirth Points",
    Callback = function()
        -- Always fire the remote command
        local args = {
	        "EnergyMoreRebirthPoints"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Energy"):FireServer(unpack(args))
        -- Toggle the state
        energyRebirthEnabled = not energyRebirthEnabled
        
        if energyRebirthEnabled then
            -- First click (ON state)
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "Rebirth Points On!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("Rebirth Points On!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "Rebirth Points Off!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("Rebirth Points off!")
        end
    end    
})

Tab:AddButton({
    Name = "MoreReadingPoints",
    Callback = function()
        -- Always fire the remote command
        local args = {
            "EnergyMoreReadingPoints"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Energy"):FireServer(unpack(args))
        -- Toggle the state
        energyReadingPointsEnabled = not energyReadingPointsEnabled
        
        if energyReadingPointsEnabled then
            -- First click (ON state)
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "More Reading Points On!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("More Reading Points On!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "More Reading Points Off!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("More Reading Points off!")
        end
    end    
})

Tab:AddButton({
    Name = "MoreCoins",
    Callback = function()
        -- Always fire the remote command
        local args = {
            "EnergyMoreCoins"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Energy"):FireServer(unpack(args))
        -- Toggle the state
        energyCoinsEnabled = not energyCoinsEnabled
        
        if energyCoinsEnabled then
            -- First click (ON state)
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "More Coins On!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("More Coins On!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "More Coins Off!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("More Coins off!")
        end
    end    
})

Tab:AddButton({
    Name = "MoreXP",
    Callback = function()
        -- Always fire the remote command
        local args = {
            "EnergyMoreXP"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Energy"):FireServer(unpack(args))
        -- Toggle the state
        energyXPEnabled = not energyXPEnabled
        
        if energyXPEnabled then
            -- First click (ON state)
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "More XP On!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("More XP On!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "More XP Off!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("More XP off!")
        end
    end    
})

Tab:AddButton({
    Name = "MoreCrystals",
    Callback = function()
        -- Always fire the remote command
        local args = {
            "EnergyMoreCrystals"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Energy"):FireServer(unpack(args))
        -- Toggle the state
        energyCrystalsEnabled = not energyCrystalsEnabled
        
        if energyCrystalsEnabled then
            -- First click (ON state)
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "More Crystals On!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("More Crystals On!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "More Crystals Off!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            print("More Crystals off!")
        end
    end    
})
-------------------------------------------------------------------------------------------------------------------------------------------------
Tab:AddLabel("                                          DIAMOND FEATURES         ")
local diamond = false

Tab:AddToggle({
    Name = "Diamond",
    Default = false,
    Callback = function(Value)
        diamond = Value -- Update based on toggle state

        if diamond then
            task.spawn(function()
                while diamond do
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Diamond"):FireServer()
                    task.wait(60) -- Short delay to avoid overwhelming the server
                end
            end)
        end
    end
})

local diamondUpgradesEnabled = false

local Toggle = Tab:AddToggle({
    Name = "Diamond Upgrades",
    Default = false,
    Callback = function(Value)
        diamondUpgradesEnabled = Value
        
        if diamondUpgradesEnabled then
            task.spawn(function()
                while diamondUpgradesEnabled do
                
                    -- CORRECTED upgrade names - note the "Diamonds" prefix
                    local upgrades = {
                        "DiamondsMoreEnergy",    -- Changed from "DiamondMoreEnergy"
                        "DiamondsMoreXP",        -- Changed from "DiamondMoreXP"
                        "DiamondsMoreCrystals"   -- Changed from "DiamondMoreCrystals"
                    }
                    
                    local remotes = game:GetService("ReplicatedStorage").Remotes
                    local upgradeRemote = remotes:WaitForChild("Upgrade")
                    
                    for _, upgradeName in ipairs(upgrades) do
                        local args = {
                            "Diamonds",      -- category
                            upgradeName,     -- specific upgrade
                            true             -- boolean flag
                        }
                        upgradeRemote:FireServer(unpack(args))
                        task.wait(1)  -- delay between each
                    end
                    
                    task.wait(30)   -- wait after full cycle
                end
            end)
        end
    end
})

local Tab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local autoPresteigeEnabled = false

Tab:AddToggle({
    Name = "Auto Prestige",
    Default = false,
    Callback = function(Value)
        autoPresteigeEnabled = Value -- Update based on toggle state

        if autoPresteigeEnabled then
            task.spawn(function()
                while autoPresteigeEnabled do
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Prestige"):FireServer()
                    task.wait(60)
                end
            end)
        end
    end
})

local autoMerchantEnabled = false

local Toggle = Tab:AddToggle({
    Name = "Auto Buy Merchant Slots",
    Default = false,
    Callback = function(Value)
        autoMerchantEnabled = Value
        
        if autoMerchantEnabled then
            task.spawn(function()
                while autoMerchantEnabled do
                
                    local slots = {
                        "Slot1",
                        "Slot2",
                        "Slot3",
                    }
                    
                    local remotes = game:GetService("ReplicatedStorage").Remotes
                    local merchantRemote = remotes:WaitForChild("Merchant")
                    
                    for _, slot in ipairs(slots) do
                        local args = {
                            "Buy",
                            slot
                        }
                        merchantRemote:FireServer(unpack(args))
                        task.wait(1)
                    end
                    
                    task.wait(15)
                end
            end)
        end
    end
})
-------------------------------------------------------------------------------------------------------------------------------------------------
Tab:AddLabel("                                          FIRE FEATURES         ")

local autoFireEnabled = false

Tab:AddToggle({
    Name = "Fire",
    Default = false,
    Callback = function(Value)
        autoFireEnabled = Value -- Update based on toggle state

        if autoFireEnabled then
            task.spawn(function()
                while autoFireEnabled do
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Fire"):FireServer()
                    task.wait(60) -- Short delay to avoid overwhelming the server
                end
            end)
        end
    end
})

OrionLib:Init()
