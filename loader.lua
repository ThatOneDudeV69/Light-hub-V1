local _0x1a2b = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local _0x3f4d = _0x1a2b:CreateWindow({
    Name = "Light Hub V1",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Made with love by borux12700",
    ConfigurationSaving = {
        Enabled = false
    }
})

local _0x5e6d = _0x3f4d:CreateTab("Auto Farm", 4483362458)
local _0x8c9f = _0x3f4d:CreateTab("Auto Rebirth", 4483362458)
local _0xa2f9 = _0x3f4d:CreateTab("Crystal", 4483362458)

_G._0xb9f1 = false
_G._0x9f10 = false
_G._0x7b92 = false
_G._0x4c35 = false
_G._0x6f4b = false
_G._0xd9a4 = false
_G._0x8d39 = false
_G._0x5f7a = false
_G._0xc2d4 = false
_G._0xe9f2 = false
_G._0xa1bc = false
_G._0xb8c3 = false

local function _0xd9a6(_0x6c42, _0x5b81)
    local _0x2a7c = game:GetService("Players").LocalPlayer
    local _0x7a9e = _0x2a7c:WaitForChild("Backpack")
    local _0x9f11 = _0x7a9e:FindFirstChild(_0x6c42)

    if _0x9f11 then
        _0x9f11.Parent = _0x2a7c.Character
        print("Equipped " .. _0x6c42 .. " tool.")
    else
        print(_0x6c42 .. " tool not found in Backpack.")
    end

    while _G[_0x5b81] do
        local _0x3a5d = { [1] = "rep" }
        local _0x6d2f, _0x4f9e = pcall(function()
            _0x2a7c:WaitForChild("muscleEvent"):FireServer(unpack(_0x3a5d))
        end)

        if not _0x6d2f then
            print("Error sending event: " .. _0x4f9e)
        end

        task.wait(1)
    end
end

_0x5e6d:CreateToggle({
    Name = "Auto Weight",
    CurrentValue = false,
    Flag = "AutoWeightToggle",
    Callback = function(_0x3b14)
        _G._0xb9f1 = _0x3b14
        if _0x3b14 then
            _0xd9a6("Weight", "_0xb9f1")
        end
    end
})

_0x5e6d:CreateToggle({
    Name = "Auto Pushups",
    CurrentValue = false,
    Flag = "AutoPushupsToggle",
    Callback = function(_0x5a1b)
        _G._0x9f10 = _0x5a1b
        if _0x5a1b then
            _0xd9a6("Pushups", "_0x9f10")
        end
    end
})

_0x5e6d:CreateToggle({
    Name = "Auto Situps",
    CurrentValue = false,
    Flag = "AutoSitupsToggle",
    Callback = function(_0x3d8b)
        _G._0x7b92 = _0x3d8b
        if _0x3d8b then
            _0xd9a6("Situps", "_0x7b92")
        end
    end
})

_0x5e6d:CreateToggle({
    Name = "Auto Handstands",
    CurrentValue = false,
    Flag = "AutoHandstandsToggle",
    Callback = function(_0x5e89)
        _G._0x4c35 = _0x5e89
        if _0x5e89 then
            _0xd9a6("Handstands", "_0x4c35")
        end
    end
})

local function _0xa8df()
    while _G._0x6f4b do
        local _0x9c1e = { [1] = "rebirthRequest" }

        local _0x3e7d, _0x6f3d = pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("rebirthRemote"):InvokeServer(unpack(_0x9c1e))
        end)

        if not _0x3e7d then
            print("Error sending rebirth request: " .. _0x6f3d)
        end

        task.wait(1)
    end
end

_0x8c9f:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "AutoRebirthToggle",
    Callback = function(_0x4f25)
        _G._0x6f4b = _0x4f25
        if _0x4f25 then
            _0xa8df()
        end
    end
})

local function _0x49e7(_0x52b9, _0x619f)
    while _G[_0x619f] do
        local _0x4a91 = {
            [1] = "openCrystal",
            [2] = _0x52b9
        }

        local _0x5b0c, _0x6a7f = pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openCrystalRemote"):InvokeServer(unpack(_0x4a91))
        end)

        if not _0x5b0c then
            print("Error opening " .. _0x52b9 .. ": " .. _0x6a7f)
        end

        task.wait(1)
    end
end

local _0xc4f7 = {
    { Name = "Blue Crystal", Flag = "_0xd9a4" },
    { Name = "Frost Crystal", Flag = "_0x8d39" },
    { Name = "Mythical Crystal", Flag = "_0x5f7a" },
    { Name = "Inferno Crystal", Flag = "_0xc2d4" },
    { Name = "Legends Crystal", Flag = "_0xe9f2" },
    { Name = "Muscle Elite Crystal", Flag = "_0xa1bc" },
    { Name = "Galaxy Oracle Crystal", Flag = "_0xb8c3" },
    { Name = "Jungle Crystal", Flag = "_0xb9f1" }
}

for _, _0x72b1 in pairs(_0xc4f7) do
    _0xa2f9:CreateToggle({
        Name = "Auto " .. _0x72b1.Name,
        CurrentValue = false,
        Flag = _0x72b1.Flag,
        Callback = function(_0x8f9e)
            _G[_0x72b1.Flag] = _0x8f9e
            if _0x8f9e then
                _0x49e7(_0x72b1.Name, _0x72b1.Flag)
            end
        end
    })
end

_0x1a2b:Notify({
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
