--// Local Script

-- Get the player's character and HumanoidRootPart
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Function to teleport other players to the local player's character
local function teleportAllPlayersToMe()
    -- Loop through all players in the game
    for _, otherPlayer in pairs(game:GetService("Players"):GetPlayers()) do
        if otherPlayer ~= player then
            local otherCharacter = otherPlayer.Character
            if otherCharacter then
                local otherHRP = otherCharacter:FindFirstChild("HumanoidRootPart")
                if otherHRP then
                    -- Teleport the other player's HumanoidRootPart to the LocalPlayer's HumanoidRootPart
                    otherHRP.CFrame = humanoidRootPart.CFrame
                end
            end
        end
    end
end

-- Call the function to teleport everyone (except yourself)
teleportAllPlayersToMe()
