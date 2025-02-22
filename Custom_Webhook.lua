-- ADD THIS TO TOP OF LIGHT HUB IF YOU WANT TO SEE WHEN YOU EXECUTE



--Discord
--// Webhook URL
local webhookUrl = ""




--// Get Player Info
local player = game:GetService("Players").LocalPlayer
local leaderstats = player:FindFirstChild("leaderstats")

--// Get Stats
local username = player.Name
local strength = leaderstats and leaderstats:FindFirstChild("Strength") and leaderstats.Strength.Value or "N/A"
local durability = player:FindFirstChild("Durability") and player.Durability.Value or "N/A"
local agility = player:FindFirstChild("Agility") and player.Agility.Value or "N/A"
local rebirths = leaderstats and leaderstats:FindFirstChild("Rebirths") and leaderstats.Rebirths.Value or "N/A"
local gems = player:FindFirstChild("Gems") and player.Gems.Value or "N/A"

--// Create Embed Data
local data = {
    ["embeds"] = {{
        ["title"] = "Player Stats",
        ["color"] = tonumber(0x00ff00), -- Green color
        ["fields"] = {
            {["name"] = "Username", ["value"] = username, ["inline"] = true},
            {["name"] = "Strength", ["value"] = tostring(strength), ["inline"] = true},
            {["name"] = "Durability", ["value"] = tostring(durability), ["inline"] = true},
            {["name"] = "Agility", ["value"] = tostring(agility), ["inline"] = true},
            {["name"] = "Rebirths", ["value"] = tostring(rebirths), ["inline"] = true},
            {["name"] = "Gems", ["value"] = tostring(gems), ["inline"] = true}
        }
    }}
}

--// Convert to JSON
local body = game:GetService("HttpService"):JSONEncode(data)
local headers = {["Content-Type"] = "application/json"}

--// Send Request (Supports Different Exploits)
if request then
    request({Url = webhookUrl, Method = "POST", Headers = headers, Body = body})
elseif http_request then
    http_request({Url = webhookUrl, Method = "POST", Headers = headers, Body = body})
elseif syn and syn.request then
    syn.request({Url = webhookUrl, Method = "POST", Headers = headers, Body = body})
end
