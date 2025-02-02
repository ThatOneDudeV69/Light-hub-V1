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

--// Create Auto Farm Tab
local AutoFarmTab = Window:CreateTab("Auto Farm", 4483362458) -- Auto Farm Tab

--// Global Variables
_G.AutoFarmEnabled = false

--// Auto Farm Function
local function autoFarm()
    while _G.AutoFarmEnabled do
        -- Fire the ToolCollect event
        local success, errorMessage = pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ToolCollect"):FireServer()
        end)

        if not success then
            print("Error sending event: " .. errorMessage)
        end

        task.wait(0.10)  -- Wait for 0.10 seconds
    end
end

--// Create Auto Farm Toggle
AutoFarmTab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarmToggle",
   Callback = function(Value)
       _G.AutoFarmEnabled = Value
       if Value then
           autoFarm()  -- Start the Auto Farm process
       end
   end
})

--// Notify User That Script Loaded
Rayfield:Notify({
   Title = "Script Loaded",
   Content = "Auto Farm ready to use!",
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
