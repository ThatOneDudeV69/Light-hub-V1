-- Get the local player
local player = game:GetService("Players").LocalPlayer


player.rebirthMultiplier = 60555555


if player:FindFirstChild("leaderstats") then
    local leaderstats = player.leaderstats
    if leaderstats:FindFirstChild("Rebirths") then
        leaderstats.Rebirths.Value = 1211111
    else
        warn("Rebirths not found in leaderstats.")
    end
else
    warn("leaderstats not found for the player.")
end
