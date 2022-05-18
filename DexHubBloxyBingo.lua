-- themes Light, Dark, Mocha, Jester
-- twink marie is cute
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local DexHubLoader = Material.Load({
    Title = "DexHub ☕ - Bloxy Bingo",
    Style = 2,
    SizeX = 500,
    SizeY = 350,
    Theme = "Mocha",
    ColorOverrides = {
        MainFrame = Color3.fromRGB(235,235,235)
    }
})

-- loads
local Teleports = {
        'Spawn'; 'Arcade'; 'Outside'; 'Main Room'; 'Second Room';
    }

_G.infJump = false

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
Mouse.KeyDown:connect(function(k)
if _G.infJump then
if k:byte() == 32 then
Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
Humanoid:ChangeState("Jumping")
wait(0.1)
Humanoid:ChangeState("Seated")
end
end
end)

local SubContainer = game:GetService("Players").LocalPlayer.PlayerGui.Bingo.StaticDisplayArea.Cards.PlayerArea.Cards.Container.SubContainer

function firebutton(button)
    if button ~= nil then
       for i,signal in pairs(getconnections(button.MouseButton1Click)) do
           signal:Fire()
       end
       for i,signal in pairs(getconnections(button.MouseButton1Down)) do
           signal:Fire()
       end
       for i,signal in pairs(getconnections(button.Activated)) do
           signal:Fire()
       end
    end
end

-- section loads
local player = DexHubLoader.New({
    Title = "Player"
})

local main = DexHubLoader.New({
    Title = "Main"
})

local misc = DexHubLoader.New({
    Title = "Misc"
})

local credits = DexHubLoader.New({
    Title = "Credits"
})

-- ui
player.Label({
    Text = "LocalPlayer"
})

player.Slider({
    Text = "Walkspeed",
    Callback = function(ws)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = ws
    end,
    Min = 0,
    Max = 500,
    Def = 16
})

player.Slider({
    Text = "JumpPower",
    Callback = function(jp)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = jp
    end,
    Min = 0,
    Max = 500,
    Def = 16
})

player.Slider({
    Text = "FOV",
    Callback = function(fv)
        game:GetService("Workspace").Camera.FieldOfView = fv
    end,
    Min = 0,
    Max = 120,
    Def = 70
})

player.Label({
    Text = "Player Addons"
})

player.Toggle({
    Text = "Infinite Jump",
    Callback = function(state) 
        if state then
            _G.infJump = true
        else
            _G.infJump = false
        end
    end,
    Enabled = false
})

player.Button({
    Text = "Anti AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end,
})

player.Button({
    Text = "Fly (X)",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/P2hNGRZ8", true))()
    end,
})

player.Button({
    Text = "NoClip (N)",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/ccd4mZjT", true))()
    end,
})

main.Label({
    Text = "Automated Stuff"
})

main.Toggle({
    Text = "AutoMark",
    Callback = function(state) 
        _G.autoMark = state;
        while _G.autoMark == true do
           local Cards

           if SubContainer:FindFirstChild("Blocks") then
               Cards = SubContainer.Blocks.Block
           else
               Cards = SubContainer.VerticalScroll.Cards
           end

           local BingoButton = SubContainer.Buttons.ClaimButton

           if Cards ~= nil and BingoButton ~= nil then
               for _, card in pairs(Cards:GetChildren()) do
                   if card:IsA("Frame") then
                       if card ~= nil and card:FindFirstChild("Content") ~= nil and card:FindFirstChild("Content"):FindFirstChild("Numbers") ~= nil then
                           for _, button in pairs(card.Content.Numbers:GetChildren()) do
                               firebutton(button)
                               wait()
                           end

                           if card ~= nil and card:FindFirstChild("ToGo") ~= nil then
                               if card.ToGo.ToGoText.Text == "BINGO!" then
                                   firebutton(BingoButton)
                               end
                           end
                       end
                   end
               end
           end
        end
    end,
    Enabled = false
})

main.Label({
    Text = "Teleports"
})

main.Dropdown({
    Text = "Teleports",
    Callback = function(tele)
        if tele == "Spawn" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(101, 7, -134)
        end

        if tele == "Arcade" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(57, 7, -106)
        end

        if tele == "Outside" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-41, 7, -84)
        end

        if tele == "Main Room" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(246, 7, -121)
        end

        if tele == "Second Room" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(31, 7, -146)
        end
    end,
    Options = Teleports
})

misc.Label({
    Text = "Misc Addons"
})

misc.Button({
    Text = "Rejoin Server",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/6NeMHvVU", true))()
    end,
})

misc.Button({
    Text = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end,
})

credits.Label({
    Text = "Credits"
})

credits.Button({
    Text = "Made By Dex",
    Callback = function()
        local loaded = Notification.new("info", "DexHub ☕", "binarydex.net")
    end
})

credits.Button({
    Text = "DexHub Website",
    Callback = function()
        local loaded = Notification.new("info", "DexHub ☕", "dexhub.xyz")
    end
})

credits.Button({
    Text = "DexHub Discord",
    Callback = function()
        local loaded = Notification.new("info", "DexHub ☕", "discord.io/dexhub")
    end
})

-- notif loads
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()
local loaded = Notification.new("success", "DexHub ☕", "Loaded Bloxy Bingo!")
wait(2)
loaded:delete()