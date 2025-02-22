
--// Load Rayfield UI Library

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local playeruser = game.Players.LocalPlayer.Name
--// Create Main Window
local Window = Rayfield:CreateWindow({
    Name = "Version 1.0.0 " .. game.Players.LocalPlayer.Name,
    LoadingTitle = "Light Hub V1",
    LoadingSubTitle = playeruser,
    ConfigurationSaving = {
       Enabled = false
    },
    Theme = "Bloom"
    
})

--// Create Tabs
local AutoFarmTab = Window:CreateTab("Auto Farm", "dumbbell")
local AutoRebirthTab = Window:CreateTab("Auto Rebirth", "refresh-cw")
local CrystalTab = Window:CreateTab("Crystal", "gem")
local AutoKill = Window:CreateTab("Auto kill", "sword")
local Stats = Window:CreateTab("Stats", "badge")
local Credits = Window:CreateTab("Credits", "info")
local Misc = Window:CreateTab("Misc", 4483362458)

--Variables for special stuff
local DiscordInvite = "https://discord.gg/es55SJH2Db",



--// Global Toggles
_G.AutoWeightEnabled = false
_G.AutoPushupsEnabled = false
_G.AutoSitupsEnabled = false
_G.AutoHandstandsEnabled = false
_G.AutoRebirthEnabled = false
_G.BlueCrystalEnabled = false
_G.FrostCrystalEnabled = false
_G.MythicalCrystalEnabled = false
_G.InfernoCrystalEnabled = false
_G.LegendsCrystalEnabled = false
_G.MuscleEliteCrystalEnabled = false
_G.GalaxyOracleCrystalEnabled = false
_G.JungleCrystalEnabled = false
_G.FastLift = false
_G.AutoSetSize = false
_G.SizeValue = 1
_G.PunchDelay = game:GetService("Players").LocalPlayer.Backpack.Punch.attackTime



--// Function to Equip Tool and Fire Event
local function equipAndFireTool(toolName, toggleVar)
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    local tool = backpack:FindFirstChild(toolName)

    if tool then
        tool.Parent = player.Character -- Equip the tool
        print("Equipped " .. toolName .. " tool.")
    else
        print(toolName .. " tool not found in Backpack.")
    end

    -- Fire the muscleEvent every second if the toggle is enabled
    while _G[toggleVar] do
        local args = { [1] = "rep" }
        local success, errorMessage = pcall(function()
            player:WaitForChild("muscleEvent"):FireServer(unpack(args))
        end)

        if not success then
            print("Error sending event: " .. errorMessage)
        end

        task.wait(0.5)  
    end
end

--// Auto Farm Toggles
AutoFarmTab:CreateToggle({
   Name = "Auto Weight",
   CurrentValue = false,
   Flag = "AutoWeightToggle",
   Callback = function(Value)
       _G.AutoWeightEnabled = Value
       equipAndFireTool("Weight", "AutoWeightEnabled")
   end
})

AutoFarmTab:CreateToggle({
   Name = "Auto Pushups",
   CurrentValue = false,
   Flag = "AutoPushupsToggle",
   Callback = function(Value)
       _G.AutoPushupsEnabled = Value
       equipAndFireTool("Pushups", "AutoPushupsEnabled")
   end
})

AutoFarmTab:CreateToggle({
   Name = "Auto Situps",
   CurrentValue = false,
   Flag = "AutoSitupsToggle",
   Callback = function(Value)
       _G.AutoSitupsEnabled = Value
       equipAndFireTool("Situps", "AutoSitupsEnabled")
   end
})

AutoFarmTab:CreateToggle({
   Name = "Auto Handstands",
   CurrentValue = false,
   Flag = "AutoHandstandsToggle",
   Callback = function(Value)
       _G.AutoHandstandsEnabled = Value
       equipAndFireTool("Handstands", "AutoHandstandsEnabled")
   end
})

AutoFarmTab:CreateToggle({
   Name = "Fast lift",
   CurrentValue = false,
   Flag = "FastLiftToggle",
   Callback = function(Value)
      _G.FastLift = Value
      while _G.FastLift do
         local args = {
    [1] = "rep"
         }
         game:GetService("Players").LocalPlayer:WaitForChild("muscleEvent"):FireServer(unpack(args))

         wait(0)
      end
   end
})




AutoRebirthTab:CreateInput({
   Name = "Rebirth goal",
   CurrentValue = "",
   PlaceholderText = "Enter rebirth to stop at ",
   RemoveTextAfterFocusLost = false,
   Flag = "RebirthGoal",
   Callback = function(Value)
      StopRebirth = tonumber(Value)
      local RebirthFolder = Player:FindFirstChild("leaderstats")
      local CurrentRebirths = RebirthFolder and RebirthFolder:FindFirstChild("Rebirths")
      if CurrentRebirth  < StopRebirth then
         _G.CanRebirth = true
      else
         _G.CanRebirth = false
      end
   end
})
         
         
--// Function to Auto Rebirth
local function autoRebirth()
    while _G.AutoRebirthEnabled and _G.CanRebirth do
        local args = { [1] = "rebirthRequest" }

        local success, errorMessage = pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("rebirthRemote"):InvokeServer(unpack(args))
        end)

        if not success then
            print("Error sending rebirth request: " .. errorMessage)
        end

        task.wait(1) -- 1-second delay
    end
end


         
         
         
--// Auto Rebirth Toggle
AutoRebirthTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirthToggle",
   Callback = function(Value)
       _G.AutoRebirthEnabled = Value
       autoRebirth()
   end
})


         
         
      
   
   

--// Function to Auto Open Crystals
local function autoOpenCrystal(crystalName, toggleVar)
    while _G[toggleVar] do
        local args = {
            [1] = "openCrystal",
            [2] = crystalName
        }

        local success, errorMessage = pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openCrystalRemote"):InvokeServer(unpack(args))
        end)

        if not success then
            print("Error opening " .. crystalName .. ": " .. errorMessage)
        end

        task.wait(1) -- 1-second delay
    end
end

--// Create Crystal Toggles
local crystalList = {
    { Name = "Blue Crystal", Flag = "BlueCrystalEnabled" },
    { Name = "Frost Crystal", Flag = "FrostCrystalEnabled" },
    { Name = "Mythical Crystal", Flag = "MythicalCrystalEnabled" },
    { Name = "Inferno Crystal", Flag = "InfernoCrystalEnabled" },
    { Name = "Legends Crystal", Flag = "LegendsCrystalEnabled" },
    { Name = "Muscle Elite Crystal", Flag = "MuscleEliteCrystalEnabled" },
    { Name = "Galaxy Oracle Crystal", Flag = "GalaxyOracleCrystalEnabled" },
    { Name = "Jungle Crystal", Flag = "JungleCrystalEnabled" }
}

for _, crystal in pairs(crystalList) do
    CrystalTab:CreateToggle({
       Name = "Auto " .. crystal.Name,
       CurrentValue = false,
       Flag = crystal.Flag,
       Callback = function(Value)
           _G[crystal.Flag] = Value
           autoOpenCrystal(crystal.Name, crystal.Flag)
       end
    })
end




local exit = Misc:CreateButton({
   Name = "Exit",
   Callback = function()
      Rayfield:Destroy()
   end
})



local Player = game:GetService("Players").LocalPlayer
local Leaderstats = Player:FindFirstChild("leaderstats")

-- Get the player stats
local PlayerStrength = Leaderstats and Leaderstats:FindFirstChild("Strength")
local PlayerDurability = Player:FindFirstChild("Durability")
local PlayerAgility = Player:FindFirstChild("Agility")
local PlayerRebirths = Leaderstats and Leaderstats:FindFirstChild("Rebirths")
local PlayerKills = Leaderstats and Leaderstats:FindFirstChild("Kills")
local PlayerBrawls = Leaderstats and Leaderstats:FindFirstChild("Brawls")

-- Create labels for each stat in the Stats tab
local StrengthLabel = Stats:CreateLabel("Strength: Loading...")
local DurabilityLabel = Stats:CreateLabel("Durability: Loading...")
local AgilityLabel = Stats:CreateLabel("Agility: Loading...")
local RebirthsLabel = Stats:CreateLabel("Rebirths: Loading...")
local KillsLabel = Stats:CreateLabel("Kills: Loading...")
local BrawlsLabel = Stats:CreateLabel("Brawls: Loading...")

-- Function to update all labels
local function UpdateStats()
    StrengthLabel:Set("Strength: " .. (PlayerStrength and PlayerStrength.Value or "N/A"))
    DurabilityLabel:Set("Durability: " .. (PlayerDurability and PlayerDurability.Value or "N/A"))
    AgilityLabel:Set("Agility: " .. (PlayerAgility and PlayerAgility.Value or "N/A"))
    RebirthsLabel:Set("Rebirths: " .. (PlayerRebirths and PlayerRebirths.Value or "N/A"))
    KillsLabel:Set("Kills: " .. (PlayerKills and PlayerKills.Value or "N/A"))
    BrawlsLabel:Set("Brawls: " .. (PlayerBrawls and PlayerBrawls.Value or "N/A"))
end

-- Initial update of the labels
UpdateStats()

-- Listen for stat changes
if PlayerStrength then PlayerStrength:GetPropertyChangedSignal("Value"):Connect(UpdateStats) end
if PlayerDurability then PlayerDurability:GetPropertyChangedSignal("Value"):Connect(UpdateStats) end
if PlayerAgility then PlayerAgility:GetPropertyChangedSignal("Value"):Connect(UpdateStats) end
if PlayerRebirths then PlayerRebirths:GetPropertyChangedSignal("Value"):Connect(UpdateStats) end
if PlayerKills then PlayerKills:GetPropertyChangedSignal("Value"):Connect(UpdateStats) end
if PlayerBrawls then PlayerBrawls:GetPropertyChangedSignal("Value"):Connect(UpdateStats) end

local Credit = Credits:CreateLabel("Made by #yourlocalljakehere")


local DiscordLink = Credits:CreateButton({
   Name = "Copy discord link to clipboard",
   Callback = function()
      setclipboard(DiscordInvite)
   end
})

function autosetsize(Size)
   while _G.AutoSetSize do
      local args = {
    [1] = "changeSize",
    [2] = _G.SizeValue
      }
      game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("changeSpeedSizeRemote"):InvokeServer(unpack(args))
   end
end


local SizeInput = Misc:CreateInput({
   Name = "Set size",
   CurrentValue = "",
   PlaceholderText = "Enter size here ",
   RemoveTextAfterFocusLost = false,
   Flag = "SizeInputPlayer",
   Callback = function(Text)
      _G.SizeValue = tonumber(Text)
   end
   
})

local AutoSizeSetToggle = Misc:CreateToggle({
   Name = "Auto set size",
   CurrentValue = false,
   Flag = "AutoSetSizeToggle",
   Callback = function(Value)
      _G.AutoSetSize = Value
      if Value then
         autosetsize(_G.AutoSetSize)
      end
   end
   
})

local SizeSlider = Misc:CreateSlider({
    Name = "Set size Slider",
    Range = {1, 100},
    Increment = 1,
    Suffix = "Size",
    CurrentValue = 1,
    Flag = "SizeSliderFlag",
    Callback = function(Value)
        local args = {
            [1] = "changeSize",
            [2] = Value
        }
        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("changeSpeedSizeRemote"):InvokeServer(unpack(args))
    end
})


local FPSOptimizer = Misc:CreateButton({
    Name = "Reduce Lag",
    Callback = function()
        local count = 0
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Texture") or obj:IsA("Decal") or obj:IsA("SurfaceAppearance") then
                obj:Destroy()
                count += 1
            end
        end

        print("Destroyed", count, "textures/decals/surface appearances for FPS boost.")
    end
})

    
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local WhitelistedPlayers = {}

-- Function to get all player usernames except LocalPlayer
local function GetPlayerUsernames()
    local usernames = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(usernames, player.Name)
        end
    end
    return usernames
end

-- Function to update WhitelistedPlayers
local function UpdateWhitelistedPlayers()
    WhitelistedPlayers = {} -- Reset table
end

-- Function to get whitelisted player names for dropdown
local function GetWhitelistedList()
    local usernames = {}
    for _, name in ipairs(WhitelistedPlayers) do
        table.insert(usernames, name)
    end
    return usernames
end

-- Create Add Whitelist Dropdown
local WhiteList = AutoKill:CreateDropdown({
    Name = "Whitelist Player",
    Options = GetPlayerUsernames(),
    CurrentOption = nil,
    MultipleOptions = true,
    Flag = "AddWhitelist",
    Callback = function(Options)
        for _, player in ipairs(Options) do
            if not table.find(WhitelistedPlayers, player) then
                table.insert(WhitelistedPlayers, player) -- Add only if not already whitelisted
            end
        end
        -- Refresh remove dropdown
        RemoveWhitelist:Refresh(GetWhitelistedList(), true)
    end
})

-- Create Remove Whitelist Dropdown
local RemoveWhitelist = AutoKill:CreateDropdown({
    Name = "Remove from Whitelist",
    Options = GetWhitelistedList(),
    CurrentOption = nil,
    MultipleOptions = true,
    Flag = "RemoveWhitelist",
    Callback = function(Options)
        for _, player in ipairs(Options) do
            for i, name in ipairs(WhitelistedPlayers) do
                if name == player then
                    table.remove(WhitelistedPlayers, i)
                    break
                end
            end
        end
        -- Refresh both dropdowns
        WhiteList:Refresh(GetPlayerUsernames(), true)
        RemoveWhitelist:Refresh(GetWhitelistedList(), true)
    end
})

-- Auto-update player lists when players join/leave
Players.PlayerAdded:Connect(function()
    WhiteList:Refresh(GetPlayerUsernames(), true)
end)

Players.PlayerRemoving:Connect(function()
    WhiteList:Refresh(GetPlayerUsernames(), true)
    RemoveWhitelist:Refresh(GetWhitelistedList(), true)
end)



--// Notify User That Script Loaded
Rayfield:Notify({
   Title = "Welcome back!",
   Content = "Reday to dominate?",
   Duration = 5,
   Image = "bot"
})

