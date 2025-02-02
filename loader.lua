--// Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// Create Main Window
local Window = Rayfield:CreateWindow({
    Name = "Light Hub V1",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Made with love by borux12700",
    ConfigurationSaving = {
       Enabled = false
    }
})

--// Create Tabs
local AutoFarmTab = Window:CreateTab("Auto Farm", 4483362458) -- Auto Farm Tab
local AutoRebirthTab = Window:CreateTab("Auto Rebirth", 4483362458) -- Auto Rebirth Tab
local CrystalTab = Window:CreateTab("Crystal", 4483362458) -- Crystal Tab

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

        task.wait(0.05)  -- 1-second delay
    end
end

--// Auto Farm Toggles
AutoFarmTab:CreateToggle({
   Name = "Auto Weight",
   CurrentValue = false,
   Flag = "AutoWeightToggle",
   Callback = function(Value)
       _G.AutoWeightEnabled = Value
       if Value then
           equipAndFireTool("Weight", "AutoWeightEnabled")
       end
   end
})

AutoFarmTab:CreateToggle({
   Name = "Auto Pushups",
   CurrentValue = false,
   Flag = "AutoPushupsToggle",
   Callback = function(Value)
       _G.AutoPushupsEnabled = Value
       if Value then
           equipAndFireTool("Pushups", "AutoPushupsEnabled")
       end
   end
})

AutoFarmTab:CreateToggle({
   Name = "Auto Situps",
   CurrentValue = false,
   Flag = "AutoSitupsToggle",
   Callback = function(Value)
       _G.AutoSitupsEnabled = Value
       if Value then
           equipAndFireTool("Situps", "AutoSitupsEnabled")
       end
   end
})

AutoFarmTab:CreateToggle({
   Name = "Auto Handstands",
   CurrentValue = false,
   Flag = "AutoHandstandsToggle",
   Callback = function(Value)
       _G.AutoHandstandsEnabled = Value
       if Value then
           equipAndFireTool("Handstands", "AutoHandstandsEnabled")
       end
   end
})

--// Function to Auto Rebirth
local function autoRebirth()
    while _G.AutoRebirthEnabled do
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
       if Value then
           autoRebirth()
       end
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
           if Value then
               autoOpenCrystal(crystal.Name, crystal.Flag)
           end
       end
    })
end

--// Notify User That Script Loaded
Rayfield:Notify({
   Title = "Script Loaded",
   Content = "All Features Ready!",
   Duration = 5,
   Image = 4483362458,
   Actions = {
       Ignore = {
           Name = "OK",
           Callback = function()
               print("User clicked OK.")
           end
       }
   }
})
