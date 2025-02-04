--// Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// Set Your Key
local CorrectKey = "LightxNew"
local IsUnlocked = false


--// Create Main Window
local Window = Rayfield:CreateWindow({
    Name = "Light Hub V1",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Made with love by borux12700",
    ConfigurationSaving = {
       Enabled = false
    }
})

--// Key System UI
local KeyTab = Window:CreateTab("Key System", 4483362458)
KeyTab:CreateInput({
    Name = "Enter Key",
    PlaceholderText = "Type your key here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Input)
        if Input == CorrectKey then
            IsUnlocked = true
            Rayfield:Notify({
                Title = "Access Granted",
                Content = "Key is correct. You can now use the script!",
                Duration = 5,
                Image = 4483362458
            })
        else
            Rayfield:Notify({
                Title = "Access Denied",
                Content = "Incorrect key. Get the key from our Discord!",
                Duration = 5,
                Image = 4483362458
            })
        end
    end
})

KeyTab:CreateButton({
    Name = "Get Key",
    Callback = function()
        setclipboard("https://discord.gg/2hpzr38T7g") -- Copies Discord link to clipboard
        Rayfield:Notify({
            Title = "Key Copied!",
            Content = "Join our Discord to get the key.",
            Duration = 5,
            Image = 4483362458
        })
    end
})

--// Prevent Access if Key is Not Entered
local function CheckAccess()
    if not IsUnlocked then
        Rayfield:Notify({
            Title = "Access Required",
            Content = "Please enter the key to use this feature!",
            Duration = 5,
            Image = 4483362458
        })
        return false
    end
    return true
end

--// Create Tabs (Only Work if Key is Correct)
local AutoFarmTab = Window:CreateTab("Auto Farm", 4483362458)
local AutoRebirthTab = Window:CreateTab("Auto Rebirth", 4483362458)
local CrystalTab = Window:CreateTab("Crystal", 4483362458)

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

--// Function to Equip Tool and Fire Event
local function equipAndFireTool(toolName, toggleVar)
    if not CheckAccess() then return end
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

        task.wait()  
    end
end

--// Auto Farm Toggles
AutoFarmTab:CreateToggle({
   Name = "Auto Weight",
   CurrentValue = false,
   Flag = "AutoWeightToggle",
   Callback = function(Value)
       if CheckAccess() then
           _G.AutoWeightEnabled = Value
           equipAndFireTool("Weight", "AutoWeightEnabled")
       end
   end
})

AutoFarmTab:CreateToggle({
   Name = "Auto Pushups",
   CurrentValue = false,
   Flag = "AutoPushupsToggle",
   Callback = function(Value)
       if CheckAccess() then
           _G.AutoPushupsEnabled = Value
           equipAndFireTool("Pushups", "AutoPushupsEnabled")
       end
   end
})

AutoFarmTab:CreateToggle({
   Name = "Auto Situps",
   CurrentValue = false,
   Flag = "AutoSitupsToggle",
   Callback = function(Value)
       if CheckAccess() then
           _G.AutoSitupsEnabled = Value
           equipAndFireTool("Situps", "AutoSitupsEnabled")
       end
   end
})

AutoFarmTab:CreateToggle({
   Name = "Auto Handstands",
   CurrentValue = false,
   Flag = "AutoHandstandsToggle",
   Callback = function(Value)
       if CheckAccess() then
           _G.AutoHandstandsEnabled = Value
           equipAndFireTool("Handstands", "AutoHandstandsEnabled")
       end
   end
})

--// Function to Auto Rebirth
local function autoRebirth()
    while _G.AutoRebirthEnabled do
        if not CheckAccess() then return end
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
       if CheckAccess() then
           _G.AutoRebirthEnabled = Value
           autoRebirth()
       end
   end
})

--// Function to Auto Open Crystals
local function autoOpenCrystal(crystalName, toggleVar)
    while _G[toggleVar] do
        if not CheckAccess() then return end
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
           if CheckAccess() then
               _G[crystal.Flag] = Value
               autoOpenCrystal(crystal.Name, crystal.Flag)
           end
       end
    })
end

--// Notify User That Script Loaded
Rayfield:Notify({
   Title = "Script Loaded",
   Content = "Enter a key to unlock features!",
   Duration = 5,
   Image = 4483362458
})
