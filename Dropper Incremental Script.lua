local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "[Merchant] Dropper Incremental",
   Icon = 0,
   LoadingTitle = "Hollow Moon Scripts",
   LoadingSubtitle = "By The Hollows",
   ShowText = "HM HUB",
   Theme = "Default",

   ToggleUIKeybind = "K",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false,
      Invite = "qXMktjStS3",  -- corrected (without full url)
      RememberJoins = true
   },

   KeySystem = false,
})

local Tab = Window:CreateTab("Auto", 4483362458)

local autoClickEnabled = false
local autoUpgradeEnabled = false

Tab:CreateToggle({
   Name = "Auto Click",
   CurrentValue = false,
   Flag = "AutoClick",
   Callback = function(Value)
      autoClickEnabled = Value
      
      if Value then
         task.spawn(function()
            while autoClickEnabled do
               pcall(function()
                  game:GetService("ReplicatedStorage")
                     :WaitForChild("Remotes")
                     :WaitForChild("DropperClick")
                     :FireServer()
               end)
               task.wait()   -- very fast – use task.wait(0.05) if too aggressive
            end
         end)
      end
   end,
})

Tab:CreateToggle({
   Name = "CashUpgrades",
   CurrentValue = false,
   Flag = "CashUpgrades",
   Callback = function(Value)
      autoUpgradeEnabled = Value
      
      if Value then
         task.spawn(function()
            while autoUpgradeEnabled do
               pcall(function()
                  local remotes = game:GetService("ReplicatedStorage").Remotes
                  local upgradeRemote = remotes:WaitForChild("Upgrade")
                  
                  local upgrades = {
                     "CashMoreCash",
                     "CashMoreXP",
                     "CashFasterButton"
                  }
                  
                  for _, upgradeName in ipairs(upgrades) do
                     if not autoUpgradeEnabled then break end
                    
                     local args = {
                        "Cash",       -- category
                        upgradeName,  -- upgrade name
                        true          -- probably "purchase" flag
                     }
                     
                     upgradeRemote:FireServer(unpack(args))
                     task.wait(0.8)   -- delay between upgrades (adjust if needed)
                  end
               end)
               
               task.wait(6)  -- wait after finishing one full cycle of all upgrades
            end
         end)
      end
   end,
})
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Label = Tab:CreateLabel("                                       ↓↓REBIRTH FEATURES↓↓         ", 11902680347, false) -- Title, Icon, Color, IgnoreTheme

local autoRebirthEnabled = false
local autoRebirth2Enabled = false

Tab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
      autoRebirthEnabled = Value
      
      if Value then
         task.spawn(function()
            while autoRebirthEnabled do
               pcall(function()
                  game:GetService("ReplicatedStorage")
                     :WaitForChild("Remotes")
                     :WaitForChild("Rebirth")
                     :FireServer()
               end)
               task.wait(60)   -- very fast – use task.wait(0.05) if too aggressive
            end
         end)
      end
   end,
})

Tab:CreateToggle({
   Name = "Rebirth Upgrades",
   CurrentValue = false,
   Flag = "RebirthUpgrades",  -- better flag name (Flag4 is too generic)
   Callback = function(Value)
      autoRebirth2Enabled = Value
      
      if Value then
         task.spawn(function()
            while autoRebirth2Enabled do
               pcall(function()
                  local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
                  local upgradeRemote = remotes:WaitForChild("Upgrade")
                  
                  local upgrades = {
                     "RebirthMoreCash",
                     "RebirthMoreXP",
                     "RebirthMoreRebirthPoints",
                  }
                  
                  for _, upgradeName in ipairs(upgrades) do
                     -- Stop early if toggle was turned off during the loop
                     if not autoRebirth2Enabled then break end
                     
                     local args = {
                        "RebirthPoints",     -- category
                        upgradeName,         -- upgrade name
                        true                 -- purchase/activate flag
                     }
                     
                     upgradeRemote:FireServer(unpack(args))
                     task.wait(0.8)          -- delay between each upgrade attempt
                  end
                  
                  task.wait(6)  -- cooldown after completing one full cycle
               end)
               
               -- Small safety wait in case pcall fails repeatedly
               task.wait(0.5)
            end
         end)
      end
      -- When Value = false → loop stops naturally via the while condition
   end,
})
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Label = Tab:CreateLabel("                                       ↓↓TREE FEATURES↓↓         ", 11902680347, false) -- Title, Icon, Color, IgnoreTheme

local treeUpgradeEnabled = false

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
                     task.wait(1)  -- ← Back to 0.6s (matches your old working code)
                  end
                  
                  task.wait(30)  -- ← Back to 10s cooldown (matches your old working code)
               end)
               task.wait(30)
            end
         end)
      end
   end,
})
local Label = Tab:CreateLabel("                                       ↓↓COIN FEATURES↓↓         ", 11902680347, false) -- Title, Icon, Color, IgnoreTheme
local CollectCoinsEnabled = false

Tab:CreateToggle({
   Name = "Collect Coins",           -- or "Auto Collect Coins" or whatever fits better
   CurrentValue = false,
   Flag = "CollectCoins",
   Callback = function(Value)
      CollectCoinsEnabled = Value
      
      if Value then
         task.spawn(function()
            while CollectCoinsEnabled do
               pcall(function()
                  -- Try to get the folder safely
                  local mapEssentials = workspace:FindFirstChild("MapEssentials")
                  if not mapEssentials then return end
                  
                  local spawnedFolder = mapEssentials:FindFirstChild("Spawned")
                  if not spawnedFolder then return end
                  
                  local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
                  local collectRemote = remotes:FindFirstChild("CollectPart")
                  if not collectRemote then return end
                  
                  -- Collect all current coins
                  for _, coin in ipairs(spawnedFolder:GetChildren()) do
                     if not CollectCoinsEnabled then return end  -- early exit if toggled off
                     
                     local coinName = coin.Name
                     if coinName and #coinName > 0 then
                        collectRemote:FireServer(coinName)
                        task.wait()   -- small delay between fires (adjust if needed)
                     end
                  end
               end)
               
               -- Important: wait after processing all current coins
               -- This gives time for new coins/parts to spawn
               task.wait()   -- ← tune this value (1–3 seconds is common)
            end
         end)
      end
      -- when Value = false → the while loop stops naturally
   end,
})

local coinUpgradesEnabled = false

Tab:CreateToggle({
   Name = "Coin Upgrades",
   CurrentValue = false,
   Flag = "CoinUpgrades",
   Callback = function(Value)
      coinUpgradesEnabled = Value
      
      if Value then
         task.spawn(function()
            while coinUpgradesEnabled do
               pcall(function()
                  local remotes = game:GetService("ReplicatedStorage").Remotes
                  local upgradeRemote = remotes:WaitForChild("Upgrade")
                  
                  local upgrades = {
                     "CoinsMoreCash","CoinsMoreXP","CoinsFasterSpawn",
                  }
                  
                  for _, upgradeName in ipairs(upgrades) do
                     if not coinUpgradesEnabled then break end
                     
                     local args = {
                        "Coins",       -- category (matches your old working code)
                        upgradeName,   -- upgrade name
                        true           -- purchase/activate flag
                     }
                     
                     upgradeRemote:FireServer(unpack(args))
                     task.wait(1)  -- delay between upgrades (adjust if needed)
                  end
                  
                  task.wait(10)  -- cooldown after completing one full cycle
               end)
               
               task.wait(10)  -- safety wait in case of repeated pcall failures
            end
         end)
      end
      -- when Value = false → the while loop stops naturally
   end,
})
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Label = Tab:CreateLabel("                                       ↓↓BOOK FEATURES↓↓         ", 11902680347, false) -- Title, Icon, Color, IgnoreTheme

local autoBuyBooksEnabled = false

Tab:CreateToggle({
   Name = "Auto Buy Books",
   CurrentValue = false,
   Flag = "AutoBuyBooks",
   Callback = function(Value)
      autoBuyBooksEnabled = Value
      
      if Value then
         task.spawn(function()
            while autoBuyBooksEnabled do
               pcall(function()
                  local remote = game:GetService("ReplicatedStorage")
                      :WaitForChild("Remotes")
                      :WaitForChild("BuyBook")
                  
                  print("Buying book attempt...")
                  remote:FireServer()          -- ← most likely correct
               end)
               
               task.wait(0.8)   -- every ~0.8 seconds - feels fast but not spammy
            end
         end)
      end
   end,
})

local autoReadingUpgradesEnabled = false

Tab:CreateToggle({
   Name = "Reading Upgrades",
   CurrentValue = false,
   Flag = "ReadingUpgrades",
   Callback = function(Value)
      autoReadingUpgradesEnabled = Value
      
      if Value then
         task.spawn(function()
            while autoReadingUpgradesEnabled do
               pcall(function()
                  local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
                  local upgradeRemote = remotes:WaitForChild("DepositUpgrade")  -- confirm this is correct!
                  
                  local upgrades = {
                     "ReadingMoreCash",
                     "ReadingMoreXP",
                     "ReadingMoreReadingPoints",
                     -- "ReadingMoreSomething", -- add more when you discover them
                  }
                  
                  for _, upgradeName in ipairs(upgrades) do
                     if not autoReadingUpgradesEnabled then break end
                     
                     upgradeRemote:FireServer(upgradeName)    -- only name (like TreeUpgrade style)
                     task.wait(1)                           -- ← much faster, adjust 0.8–2.5
                  end
               end)
               
               task.wait(10)  -- ← shorter cycle cooldown (was 30s → too slow for testing)
            end
         end)
      end
   end,
})
------------------------------------------------------------------------------------------------------------------------------------------------
local Label = Tab:CreateLabel("                                       ↓↓CRYSTALIZE FEATURES↓↓         ", 11902680347, false) -- Title, Icon, Color, IgnoreTheme

local CrystalizeEnabled = false

Tab:CreateToggle({
   Name = "Auto Crystalize",
   CurrentValue = false,
   Flag = "AutoCrystalize",
   Callback = function(Value)
      CrystalizeEnabled = Value
      
      if Value then
         task.spawn(function()
            while CrystalizeEnabled do
               pcall(function()
                  game:GetService("ReplicatedStorage")
                     :WaitForChild("Remotes")
                     :WaitForChild("Crystalize")
                     :FireServer()
               end)
               task.wait(60)   -- very fast – use task.wait(0.05) if too aggressive
            end
         end)
      end
   end,
})
-------------------------------------------------------------------------------------------------------------------------------------------------
local Label = Tab:CreateLabel("                                       ↓↓TREEUPGRADES2↓↓         ", 11902680347, false) -- Title, Icon, Color, IgnoreTheme

local treeUpgradeEnabled = false

local treeUpgradeEnabled = false

Tab:CreateToggle({
   Name = "TreeUpgrades2",
   CurrentValue = false,
   Flag = "TreeUpgrades2",
   Callback = function(Value)
      treeUpgradeEnabled = Value
      
      if Value then
         task.spawn(function()
            while treeUpgradeEnabled do
               pcall(function()
                  local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
                  local treeUpgradeRemote = remotes:WaitForChild("TreeUpgrade")
                  
                  local upgrades = {   -- ← added the missing opening {
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
                  }  -- ← and the matching closing }
                  
                  for _, upgradeName in ipairs(upgrades) do
                     if not treeUpgradeEnabled then break end                     
                     treeUpgradeRemote:FireServer(upgradeName)
                     task.wait(1)
                  end
                  
                  task.wait(30)
               end)
               
               task.wait(0.5)  -- small safety wait between cycles
            end
         end)
      end
   end,
})
------------------------------------------------------------------------------------------------------------------------------------------------
local Tab = Window:CreateTab("Auto2", 4483362458)

local PowerEnabled = false 
local energyCashEnabled = false
local energyRebirthEnabled = false
local energyReadingPointsEnabled = false
local energyCoinsEnabled = false
local energyXPEnabled = false
local energyCrystalsEnabled = false

local Label = Tab:CreateLabel("                                       ↓↓POWER FEATURES↓↓         ", 11902680347, false) -- Title, Icon, Color, IgnoreTheme

local Button = Tab:CreateButton({
   Name = "Power",
   Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Power"):FireServer()
        -- Toggle the state
        PowerEnabled = not PowerEnabled
        
        if PowerEnabled then
            Rayfield:Notify({
             Title = "Energy Cash Activated!",
            Content = "Energy Cash is now enabled.",
            Duration = 3,
            Image = 4483362458,
            
            })
            print("Cash activated!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            Rayfield:Notify({
             Title = "Energy Cash Deactivated!",
            Content = "Energy Cash is now disabled.",
            Duration = 3,
            Image = 4483362458,
            })
            print("Cash off!")
        end
   end,
})
------------------------------------------------------------------------------------------------------------------------------------------------
local Label = Tab:CreateLabel("                                       ↓↓ENERGY FEATURES↓↓         ", 11902680347, false) -- Title, Icon, Color, IgnoreTheme

local Button = Tab:CreateButton({
   Name = "Cash",
   Callback = function()
   local args = {
            "EnergyMoreCash"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Energy"):FireServer(unpack(args))
        -- Toggle the state
        energyCashEnabled = not energyCashEnabled
        
        if energyCashEnabled then
            Rayfield:Notify({
             Title = "Energy Cash Activated!",
            Content = "Energy Cash is now enabled.",
            Duration = 3,
            Image = 4483362458,
            
            })
            print("Cash activated!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            Rayfield:Notify({
             Title = "Energy Cash Deactivated!",
            Content = "Energy Cash is now disabled.",
            Duration = 3,
            Image = 4483362458,
            })
            print("Cash off!")
        end
   end,
})

local Button = Tab:CreateButton({
   Name = "RebirthPoints",
   Callback = function()
   local args = {
            "EnergyMoreRebirthPoints"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Energy"):FireServer(unpack(args))
        -- Toggle the state
        energyRebirthEnabled = not energyRebirthEnabled
        
        if energyRebirthEnabled then
            Rayfield:Notify({
             Title = "Energy Rebirth Activated!",
            Content = "Energy Rebirth is now enabled.",
            Duration = 3,
            Image = 4483362458,
            
            })
            print("Rebirth activated!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            Rayfield:Notify({
             Title = "Energy Rebirth Deactivated!",
            Content = "Energy Rebirth is now disabled.",
            Duration = 3,
            Image = 4483362458,
            })
            print("Rebirth off!")
        end
   end,
})

local Button = Tab:CreateButton({
   Name = "ReadingPoints",
   Callback = function()
   local args = {
            "EnergyMoreReadingPoints"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Energy"):FireServer(unpack(args))
        -- Toggle the state
        energyReadingPointsEnabled = not energyReadingPointsEnabled
        
        if energyReadingPointsEnabled then
            Rayfield:Notify({
             Title = "Energy Reading Points Activated!",
            Content = "Energy Reading Points is now enabled.",
            Duration = 3,
            Image = 4483362458,
            
            })
            print("Reading Points activated!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            Rayfield:Notify({
             Title = "Energy Reading Points Deactivated!",
            Content = "Energy Reading Points is now disabled.",
            Duration = 3,
            Image = 4483362458,
            })
            print("Reading Points off!")
        end
   end,
})

local Button = Tab:CreateButton({
   Name = "EnergyMoreCoins",
   Callback = function()
   local args = {
            "EnergyMoreCash"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Energy"):FireServer(unpack(args))
        -- Toggle the state
        energyCoinsEnabled = not energyCoinsEnabled
        
        if energyCoinsEnabled then
            Rayfield:Notify({
             Title = "Energy Coins Activated!",
            Content = "Energy Coins is now enabled.",
            Duration = 3,
            Image = 4483362458,
            
            })
            print("Coins activated!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            Rayfield:Notify({
             Title = "Energy Coins Deactivated!",
            Content = "Energy Coins is now disabled.",
            Duration = 3,
            Image = 4483362458,
            })
            print("Coins off!")
        end
   end,
})

local Button = Tab:CreateButton({
   Name = "MoreXP",
   Callback = function()
   local args = {
            "EnergyMoreXP"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Energy"):FireServer(unpack(args))
        -- Toggle the state
        energyXPEnabled = not energyXPEnabled
        
        if energyXPEnabled then
            Rayfield:Notify({
             Title = "Energy XP Activated!",
            Content = "Energy XP is now enabled.",
            Duration = 3,
            Image = 4483362458,
            
            })
            print("XP activated!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            Rayfield:Notify({
             Title = "Energy XP Deactivated!",
            Content = "Energy XP is now disabled.",
            Duration = 3,
            Image = 4483362458,
            })
            print("XP off!")
        end
   end,
})

local Button = Tab:CreateButton({
   Name = "MoreCrystals",
   Callback = function()
   local args = {
            "EnergyMoreCrystals"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Energy"):FireServer(unpack(args))
        -- Toggle the state
        energyCrystalsEnabled = not energyCrystalsEnabled
        
        if energyCrystalsEnabled then
            Rayfield:Notify({
             Title = "Energy Crystals Activated!",
            Content = "Energy Crystals is now enabled.",
            Duration = 3,
            Image = 4483362458,
            
            })
            print("Crystals activated!")
        else
            -- Second click (OFF state) - Still fires the command, just different message
            Rayfield:Notify({
             Title = "Energy Crystals Deactivated!",
            Content = "Energy Crystals is now disabled.",
            Duration = 3,
            Image = 4483362458,
            })
            print("Crystals off!")
        end
   end,
})
------------------------------------------------------------------------------------------------------------------------------------------------
local Label = Tab:CreateLabel("                                       ↓↓DIAMOND FEATURES↓↓         ", 11902680347, false) -- Title, Icon, Color, IgnoreTheme

Tab:CreateToggle({
   Name = "Diamond",
   CurrentValue = false,
   Flag = "Diamond",
   Callback = function(Value)
      autoClickEnabled = Value
      
      if Value then
         task.spawn(function()
            while autoClickEnabled do
               pcall(function()
                  game:GetService("ReplicatedStorage")
                     :WaitForChild("Remotes")
                     :WaitForChild("Diamond")
                     :FireServer()
               end)
               task.wait(60)   -- very fast – use task.wait(0.05) if too aggressive
            end
         end)
      end
   end,
})

local diamondUpgradesEnabled = false

Tab:CreateToggle({
   Name = "Diamond Upgrades",
   CurrentValue = false,
   Flag = "DiamondUpgrades",  -- better flag name (Flag4 is too generic)
   Callback = function(Value)
      diamondUpgradesEnabled = Value
      
      if Value then
         task.spawn(function()
            while diamondUpgradesEnabled do
               pcall(function()
                  local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
                  local upgradeRemote = remotes:WaitForChild("Upgrade")
                  
                  local upgrades = {
                     "DiamondsMoreEnergy", "DiamondsMoreXP", "DiamondsMoreCrystals"
                  }
                  
                  for _, upgradeName in ipairs(upgrades) do
                     -- Stop early if toggle was turned off during the loop
                     if not diamondUpgradesEnabled then break end
                     
                     local args = {
                        "Diamonds",     -- category
                        upgradeName,         -- upgrade name
                        true                 -- purchase/activate flag
                     }
                     
                     upgradeRemote:FireServer(unpack(args))
                     task.wait(1)          -- delay between each upgrade attempt
                  end
                  
                  task.wait(10)  -- cooldown after completing one full cycle
               end)
               
               -- Small safety wait in case pcall fails repeatedly
               task.wait(10)
            end
         end)
      end
      -- When Value = false → loop stops naturally via the while condition
   end,
})
------------------------------------------------------------------------------------------------------------------------------------------------
local Tab = Window:CreateTab("Misc", 4483362458)

local autoPresteigeEnabled = false

Tab:CreateToggle({
   Name = "Auto Prestige",
   CurrentValue = false,
   Flag = "Prestige",
   Callback = function(Value)
      autoPresteigeEnabled = Value
      
      if Value then
         task.spawn(function()
            while autoPresteigeEnabled do
               pcall(function()
                  game:GetService("ReplicatedStorage")
                     :WaitForChild("Remotes")
                     :WaitForChild("Prestige")
                     :FireServer()
               end)
               task.wait(60)   -- very fast – use task.wait(0.05) if too aggressive
            end
         end)
      end
   end,
})
------------------------------------------------------------------------------------------------------------------------------------------------
local autoMerchantEnabled = false

Tab:CreateToggle({
   Name = "Buy Merchant Slots",
   CurrentValue = false,
   Flag = "AutoBuyMerchantSlots",
   Callback = function(Value)
      autoMerchantEnabled = Value
      
      if Value then
         task.spawn(function()
            while autoMerchantEnabled do
               pcall(function()
                  local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
                  local merchantRemote = remotes:WaitForChild("Merchant")
                  
                  local slots = {"Slot1", "Slot2", "Slot3"}
                  
                  for _, slot in ipairs(slots) do
                     merchantRemote:FireServer("Buy", slot)
                     task.wait(1)
                  end
                  
                  task.wait(10)
               end)
            end
         end)
      end
   end,
})

Rayfield:LoadConfiguration()
