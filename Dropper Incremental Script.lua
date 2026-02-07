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
   Flag = "Flag1",
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
   Flag = "Flag2",
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
local Label = Tab:CreateLabel("                                       REBIRTH FEATURES         ", 11902680347, false) -- Title, Icon, Color, IgnoreTheme

local autoRebirthEnabled = false
local autoRebirth2Enabled = false

Tab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "Flag3",
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

local Label = Tab:CreateLabel("                                       TREE FEATURES         ", 11902680347, false) -- Title, Icon, Color, IgnoreTheme

local treeUpgradeEnabled = false

Tab:CreateToggle({
   Name = "Tree Unlocks",
   CurrentValue = false,
   Flag = "TreeUnlocks",  -- better flag name (Flag4 is too generic)
   Callback = function(Value)
      treeUpgradeEnabled = Value
      
      if Value then
         task.spawn(function()
            while treeUpgradeEnabled do
               pcall(function()
                  local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
                  local upgradeRemote = remotes:WaitForChild("Upgrade")
                  
                  local upgrades = {
                     "TreeMoreCash",
                        "TreeMoreWalkspeed",
                        "TreeMoreXP",
                        "TreeMoreCoins",
                        "TreeMoreCash2",
                        "TreeMoreCollectionRange",
                        "TreeMoreSpawnCap",
                        "TreeMoreSpawnBulk",
                        "TreeRebirthBoostsCash",
                        "TreeMoreCoins2",
                        "TreeUnlockReading",
                        "TreeMoreCoins3",
                        "TreeMoreReadingPoints",
                        "TreeMoreCash3",
                        "TreeCheaperBooks",
                        "TreeMoreXP2",
                        "TreeCoinsBoostXP",
                  }
                  
                  for _, upgradeName in ipairs(upgrades) do
                     -- Stop early if toggle was turned off during the loop
                     if not treeUpgradeEnabled then break end
                     
                     local args = {
                        "TreeUpgrade",     -- category
                        upgradeName,         -- upgrade name
                     }
                     
                     upgradeRemote:FireServer(unpack(args))
                     task.wait(0.8)          -- delay between each upgrade attempt
                  end
                  
                  task.wait(10)  -- cooldown after completing one full cycle
               end)
               
               -- Small safety wait in case pcall fails repeatedly
               task.wait(0.5)
            end
         end)
      end
      -- When Value = false → loop stops naturally via the while condition
   end,
})
































Rayfield:LoadConfiguration()
