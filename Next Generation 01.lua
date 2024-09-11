if not game:IsLoaded() then repeat game.Loaded:Wait() until game:IsLoaded() end
pcall(function()
    if game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") then
        repeat task.wait()
            if game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main").ChooseTeam.Visible == true then
                if _G.Team == "Pirate" then
                for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.Activated)) do
                    v.Function()
                end
                elseif _G.Team == "Marine" then
                    for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.TextButton.Activated)) do
                        v.Function()
                    end
                else
                    for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.Activated)) do
                        v.Function()
                    end
                end
            end
        until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded()
    end
end)
if game.PlaceId == 2753915549 then
    FirstSea = true
elseif game.PlaceId == 4442272183 then
    SecondSea = true
elseif game.PlaceId == 7449423635 then
    ThirdSea = true
end

wait(.1)

------------------------------- [ Button ] -------------------------------

local DisplayButton = game:GetService("Players").LocalPlayer.PlayerGui.Main.Settings.DisplayButton
local SettingsButton = game:GetService("Players").LocalPlayer.PlayerGui.Main.Settings
DisplayButton.TextLabel.Text = "Luciano Hub"
DisplayButton.Notify.Text = "Enableds Luciano Hub (The Best Script)"
DisplayButton.Visible = false
Toggle = true
SettingsButton.MouseButton1Click:Connect(function()
    if Toggle then
        Toggle = false        
        DisplayButton.Visible = true
    else
        Toggle = true
        DisplayButton.Visible = false
    end
end)
DisplayButton.MouseButton1Click:Connect(function()
game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Home, false, game)
end)

------------------------------- [ Ui ] -------------------------------

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2Sunz/Luciano-Trash/main/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Luciano Hub",
    SubTitle = "SCRIPT | BLOXFRUIT",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 400),
    Acrylic = false,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.Home
})

General = Window:AddTab({ Title = "General", Icon = "rbxassetid://10723407389" })
if FirstSea then
    FirstSea = Window:AddTab({ Title = "• First Sea", Icon = "tally-1" })
elseif SecondSea then
    SecondSea = Window:AddTab({ Title = "• Second Sea", Icon = "tally-1" })
elseif ThirdSea then
    ThirdSea = Window:AddTab({ Title = "• Third Sea", Icon = "tally-1" })
end
Stats = Window:AddTab({ Title = "Stats", Icon = "rbxassetid://10709770560" })
Combat = Window:AddTab({ Title = "Combat", Icon = "rbxassetid://10734975486" })
Player = Window:AddTab({ Title = "Player", Icon = "rbxassetid://10747373176" })
Visual = Window:AddTab({ Title = "• Visual", Icon = "tally-1" })
if SecondSea or ThirdSea then
    Dungeon = Window:AddTab({ Title = "Dungeon", Icon = "rbxassetid://7733798747" })
end
Teleport = Window:AddTab({ Title = "Teleport", Icon = "rbxassetid://10734886004" })
Shop = Window:AddTab({ Title = "Shop", Icon = "rbxassetid://7734068321" })
Materials = Window:AddTab({ Title = "Materials", Icon = "rbxassetid://10709810948" })
Configurations = Window:AddTab({ Title = "Configurations", Icon = "settings" })

local Options = Fluent.Options

------------------------------- [ General ] -------------------------------

local Section = General:AddSection("Faming")
local SelectWeapons = General:AddDropdown("Dropdown", { Title = "Select Weapons", Values = {"Melee", "Sword", "Blox Fruit"}, Multi = false, Default = 1, })
SelectWeapons:SetValue("Melee")
SelectWeapons:OnChanged(function(Value)
    _G.SelectWeapons = Value
end)

local Toggle = General:AddToggle("MyToggle", {Title = "Auto Farm Level", Default = false })
Toggle:OnChanged(function(Value)
    _G.AutoFarmLevel = Value
    spawn(function()
        while task.wait() do
            pcall(function()
                if _G.AutoFarmLevel then
                    CheckQuest()
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                        BypassTP(CheckQuest()[4])
                        TP(CheckQuest()[4])
                        if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,CheckQuest()[1]) then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == CheckQuest()[1] and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        BringMob = true
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        PosMon = v.HumanoidRootPart.CFrame
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoFarmLevel or v.Humanoid.Health <= 0 or not v.Parent or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                                    BringMob = false
                                    FastAttack = false
                                end
                            end
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                        end
                    else
                        if (CheckQuest()[5].Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",CheckQuest()[2],CheckQuest()[3])
                        else
                            BypassTP(CheckQuest()[5])
                            TP(CheckQuest()[5])
                        end
                    end
                end
            end)
        end
    end)
end)

local Toggle = General:AddToggle("MyToggle", {Title = "Auto Farm Nearest", Default = false })
Toggle:OnChanged(function(Value)
    _G.AutoFarmNearest = Value
    spawn(function()
        while task.wait() do
            pcall(function()
                if _G.AutoFarmNearest then
                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                            repeat task.wait()
                                EquipWeapon()
                                BringMobNearest = true
                                FastAttack = true
                                v.Humanoid.WalkSpeed = 0
                                v.Humanoid.JumpPower = 0
                                PosMon = v.HumanoidRootPart.CFrame
                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                            until not _G.AutoFarmNearest or v.Humanoid.Health <= 0 or not v.Parent
                            BringMobNearest = false
                            FastAttack = false
                        end
                    end
                end
            end)
        end
    end)
end)

local Toggle = General:AddToggle("MyToggle", {Title = "• Black Screen", Default = false })
Toggle:OnChanged(function(Value)
    _G.BlackScreen = Value
    spawn(function()
        while task.wait() do
            if _G.BlackScreen then
                game:GetService("Players").LocalPlayer.PlayerGui.Main.Blackscreen.Size = UDim2.new(500, 0, 500, 500)
            else
                game:GetService("Players").LocalPlayer.PlayerGui.Main.Blackscreen.Size = UDim2.new(1, 0, 500, 500)
            end
        end
    end)
end)

local Section = General:AddSection("Miscellaneous")

local Toggle = General:AddToggle("MyToggle", {Title = "Auto Farm Chest", Default = false })
Toggle:OnChanged(function(Value)
    _G.AutoFarmChest = Value
    spawn(function()
        while task.wait() do
            pcall(function()
                if _G.AutoFarmChest then
                    local Zero = 0
                    local nearestChest = nil
                    local minDistance = math.huge
                    for _, chest in pairs(game.Workspace:GetChildren()) do 
                        if chest.Name:find("Chest") then
                            local distance = (chest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if distance <= 5000 + Zero and distance < minDistance then
                                nearestChest = chest
                                minDistance = distance
                            end
                        end
                    end
                    if nearestChest then
                        repeat task.wait()
                            if nearestChest.Parent then
                                TP(nearestChest.CFrame)
                                if (nearestChest.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                                    game:service('VirtualInputManager'):SendKeyEvent(true, "Q", false, game)
                                    game:service('VirtualInputManager'):SendKeyEvent(false, "Q", false, game)
                                end
                                if game.Players.LocalPlayer.Character.HumanoidRoot.Sit then
                                    game:service('VirtualInputManager'):SendKeyEvent(true, "Space", false, game)
                                    game:service('VirtualInputManager'):SendKeyEvent(false, "Space", false, game)
                                end
                            end
                        until not _G.AutoFarmChest or not x.Parent
                    end
                    Zero = Zero + 1500
                end
            end)
        end
    end)
end)

------------------------------- [ First Sea ] -------------------------------

if FirstSea then
    local Section = FirstSea:AddSection("First Sea")

    local Toggle = FirstSea:AddToggle("MyToggle", {Title = "• Auto Saber", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoSaber = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoSaber then
                        if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Saber") and not game.Players.LocalPlayer.Character:FindFirstChild("Saber") then
                            if game:GetService("Workspace").Map.Jungle.Final.Part.Transparency == 0 then
                                if game:GetService("Workspace").Map.Desert.Burn.Part.Transparency == 0 then
                                    if game:GetService("Workspace").Map.Jungle.QuestPlates.Door.Transparency == 0 then
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate1.Button.Transparency = 1
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate1.Button.CanCollide = false
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate1.Button.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate2.Button.Transparency = 1
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate2.Button.CanCollide = false
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate2.Button.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate3.Button.Transparency = 1
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate3.Button.CanCollide = false
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate3.Button.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate4.Button.Transparency = 1
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate4.Button.CanCollide = false
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate4.Button.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate5.Button.Transparency = 1
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate5.Button.CanCollide = false
                                        game:GetService("Workspace").Map.Jungle.QuestPlates.Plate5.Button.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                    else
                                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress","GetTorch")
                                    end
                                    Equip("Torch")
                                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress","DestroyTorch")
                                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress")
                                    game:GetService("Workspace").Map.Desert.Burn.Part.Transparency = 1
                                    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").localPlayer)
                                else
                                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
                                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress","GetCup")
                                        Equip("Cup")
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","FillCup",game:GetService("Players").LocalPlayer.Character.Cup)
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan")
                                    end
                                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == nil then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
                                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress")
                                        if game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader") then
                                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                                if v.Name == "Mob Leader" then
                                                    repeat task.wait()
                                                        EquipWeapon()
                                                        FastAttack = true
                                                        v.Humanoid.WalkSpeed = 0
                                                        v.Humanoid.JumpPower = 0
                                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                    until not _G.AutoSaber or v.Humanoid.Health <= 0 or not v.Parent
                                                    FastAttack = false
                                                end
                                            end
                                        else
                                            BypassTP(CFrame.new(-1052, 44, 4090))
                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2880, 6, 5430)
                                        end
                                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
                                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress","RichSon")
                                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress")
                                        Equip("Relic")
                                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress","PlaceRelic")
                                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress")
                                        game:GetService("Workspace").Map.Jungle.Final.Part.Transparency = 1
                                        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").localPlayer)
                                    end
                                end
                            end
                            if game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == "Saber Expert" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            EquipWeapon()
                                            FastAttack = true
                                            v.Humanoid.WalkSpeed = 0
                                            v.Humanoid.JumpPower = 0
                                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                        until not _G.AutoSaber or v.Humanoid.Health <= 0 or not v.Parent
                                        FastAttack = false
                                    end
                                end
                            else
                                BypassTP(game:GetService("ReplicatedStorage")["Saber Expert"].HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                            end
                        end
                    end
                end)
            end
        end)
    end)

    local Toggle = FirstSea:AddToggle("MyToggle", {Title = "• Auto Pole", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoPole = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoPole then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Thunder God") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Thunder God" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoPole or v.Humanoid.Health <= 0 or not v.Parent
                                    FastAttack = false
                                end
                            end
                        else
                            if game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God") then
                                if (game:GetService("ReplicatedStorage")["Thunder God"].HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7910, 5575, -380))
                                else
                                    TP(CFrame.new(-7797, 5637, -2463))
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end)

    local Toggle = FirstSea:AddToggle("MyToggle", {Title = "• Player Hunter Quest", Default = false })
    Toggle:OnChanged(function(Value)
        _G.PlayerHunterQuest = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.PlayerHunterQuest then
                        CheckQuest()
                        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                            if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,CheckQuest()[1]) then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest") end
                            local HunterPlayer = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text:split(" ")[2]
                            for i,v in pairs(game:GetService("Workspace").Characters:GetChildren()) do
                                if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,HunterPlayer) then
                                    if v.Name == HunterPlayer and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        BypassTP(v.HumanoidRootPart.CFrame * CFrame.new(0,50,0))
                                        repeat task.wait()
                                            EquipWeapon()
                                            FastAttack = true
                                            v.Humanoid.WalkSpeed = 0
                                            v.Humanoid.JumpPower = 0
                                            PosMon = v.HumanoidRootPart.CFrame
                                            game:GetService'VirtualUser':CaptureController()
                                            game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                            if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,10,0))
                                                task.wait()
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(10,0,0))
                                                task.wait()
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,0,-10))
                                                task.wait()
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(-10,0,0))
                                                task.wait()
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,0,10))
                                                task.wait()
                                            else
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,10,0))
                                            end
                                            if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                                                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Z, false, game)
                                                task.wait(.1)
                                                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Z, false, game)
                                                task.wait(.1)
                                                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.X, false, game)
                                                task.wait(.1)
                                                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.X, false, game)
                                                task.wait(.1)
                                            end
                                        until not _G.PlayerHunterQuest or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible or game:GetService("Players").LocalPlayer.PlayerGui.Main.PvpDisabled.Visible
                                        FastAttack = false
                                        if game:GetService("Players").LocalPlayer.PlayerGui.Main.PvpDisabled.Visible then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
                                        end
                                    end
                                end
                            end
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
                            
                        end
                    end
                end)
            end
        end)
    end)

    local Toggle = FirstSea:AddToggle("MyToggle", {Title = "• Auto Second Sea", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoSecondSea = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoSecondSea then
                        if GetData()[1] >= 700 and game.Workspace.Map.Ice.Door.Transparency == 0 then
                            _G.AutoFarmLevel = false
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress","Detective")
                            Equip("Key")
                            TP(CFrame.new(1348, 37, -1326))
                        elseif game.Workspace.Map.Ice.Door.Transparency == 1 then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == "Ice Admiral" and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            EquipWeapon()
                                            FastAttack = true
                                            v.Humanoid.WalkSpeed = 0
                                            v.Humanoid.JumpPower = 0
                                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                        until not _G.AutoSecondSea or v.Humanoid.Health <= 0 or not v.Parent
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                                        FastAttack = false
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end)
end

------------------------------- [ Second Sea ] -------------------------------

if SecondSea then
    local Section = SecondSea:AddSection("Second Sea")

    local Toggle = SecondSea:AddToggle("MyToggle", {Title = "• Auto Library Key (Death Step)", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoDeathStep = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoDeathStep then
                        if game:GetService("Workspace").Map.IceCastle.Hall.LibraryDoor.PhoeyuDoor.Transparency == 0 then
                            if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Library Key") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Library Key") then
                                TP(CFrame.new(6377, 297, -6845, -1, 1.1853718e-09, -0.5, 6.989051e-10, 1, 1.15121634e-09, 0.5, 6.39265973e-10, -1))
                                if (CFrame.new(6377, 297, -6845, -1, 1.1853718e-09, -0.5, 6.989051e-10, 1, 1.15121634e-09, 0.5, 6.39265973e-10, -1).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                                    Equip("Library Key")
                                end
                            end
                            if game:GetService("Workspace").Enemies:FindFirstChild("Awakened Ice Admiral") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == "Awakened Ice Admiral" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            EquipWeapon()
                                            FastAttack = true
                                            v.Humanoid.WalkSpeed = 0
                                            v.Humanoid.JumpPower = 0
                                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                        until not _G.AutoDeathStep or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Library Key") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Library Key")
                                        FastAttack = false
                                    end
                                end
                            else
                                BypassTP(game:GetService("ReplicatedStorage")["Awakened Ice Admiral"].HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("ReplicatedStorage")["Awakened Ice Admiral"].HumanoidRootPart.CFrame * CFrame.new(0,30,0)
                            end
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
                        end
                    end
                end)
            end
        end)
    end)
    
    local Toggle = SecondSea:AddToggle("MyToggle", {Title = "• Auto Water Key (Sharkman Karate)", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoSharkmanKarate = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoSharkmanKarate then
                        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Water Key") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Water Key") then
                            TP(CFrame.new(-2604, 239, -10315))
                            if (CFrame.new(-2604, 239, -10315).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                            end
                        end
                        if game:GetService("Workspace").Enemies:FindFirstChild("Tide Keeper") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Tide Keeper" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoSharkmanKarate or v.Humanoid.Health <= 0 or not v.Parent
                                    FastAttack = false
                                end
                            end
                        else
                            BypassTP(game:GetService("ReplicatedStorage")["Tide Keeper"].HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("ReplicatedStorage")["Tide Keeper"].HumanoidRootPart.CFrame * CFrame.new(0,30,0)
                        end
                    end
                end)
            end
        end)
    end)

    local Toggle = SecondSea:AddToggle("MyToggle", {Title = "• Auto Factory", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoFactory = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoFactory and workspace.Map.Dressrosa.SmileFactory.Door.Transparency == 1 then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Core") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Core" and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoFactory or v.Humanoid.Health <= 0 or not v.Parent
                                    FastAttack = false
                                end
                            end
                        else
                            BypassTP(CFrame.new(428, 199, -429))
                            TP(CFrame.new(428, 199, -429))
                        end
                    end
                end)
            end
        end)
    end)

    local Toggle = SecondSea:AddToggle("MyToggle", {Title = "• Auto Flower Quest", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoFlowerQuest = Value
        -- game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("Alchemist","1")
    end)

    local Toggle = SecondSea:AddToggle("MyToggle", {Title = "• Auto Race V3 Quest", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoRaceV3Quest = Value
    end)
    
    local Toggle = SecondSea:AddToggle("MyToggle", {Title = "• Auto Bartilo Quest", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoBartiloQuest = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoBartiloQuest then
                        if GetData()[1] >= 850 then
                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
                                if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
                                    if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate") then
                                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                            if v.Name == "Swan Pirate" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                repeat task.wait()
                                                    EquipWeapon()
                                                    BringMobNearest = true
                                                    FastAttack = true
                                                    v.Humanoid.WalkSpeed = 0
                                                    v.Humanoid.JumpPower = 0 
                                                    PosMon = v.HumanoidRootPart.CFrame
                                                    TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                until not _G.AutoBartiloQuest or v.Humanoid.Health <= 0 or not v.Parent
                                                BringMobNearest = false
                                                FastAttack = false
                                            end
                                        end
                                    else
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(975, 121, 1290)
                                    end
                                else
                                    if (CFrame.new(-462, 72, 300).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 170 then
                                        BypassTP(CFrame.new(-462, 72, 300))
                                    else
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-462, 72, 300)
                                        if (CFrame.new(-462, 72, 300).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5 then
                                            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("StartQuest","BartiloQuest",1)
                                        end
                                    end
                                end
                            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
                                if game:GetService("Workspace").Enemies:FindFirstChild("Jeremy") then
                                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                        if v.Name == "Jeremy" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                            repeat task.wait()
                                                EquipWeapon()
                                                FastAttack = true
                                                v.Humanoid.WalkSpeed = 0
                                                v.Humanoid.JumpPower = 0
                                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                            until not _G.AutoBartiloQuest or v.Humanoid.Health <= 0 or not v.Parent
                                            FastAttack = false
                                        end
                                    end
                                else
                                    TP(game:GetService("ReplicatedStorage")["Jeremy"].HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                end
                            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate1.Decal:Destroy()
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate1.Transparency = 1
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate1.CanCollide = false
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate1.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                task.wait(.1)
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate2.Decal:Destroy()
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate2.Transparency = 1
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate2.CanCollide = false
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate2.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                task.wait(.1)
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate3.Decal:Destroy()
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate3.Transparency = 1
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate3.CanCollide = false
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate3.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                task.wait(.1)
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate4.Decal:Destroy()
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate4.Transparency = 1
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate4.CanCollide = false
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate4.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                task.wait(.1)
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate5.Decal:Destroy()
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate5.Transparency = 1
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate5.CanCollide = false
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate5.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                task.wait(.1)
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate6.Decal:Destroy()
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate6.Transparency = 1
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate6.CanCollide = false
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate6.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                task.wait(.1)
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate7.Decal:Destroy()
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate7.Transparency = 1
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate7.CanCollide = false
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate7.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                task.wait(.1)
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate8.Decal:Destroy()
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate8.Transparency = 1
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate8.CanCollide = false
                                game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate8.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                task.wait(.1)
                            end
                        end game:GetService("Workspace").Chest3.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end)
            end
        end)
    end)
    
    local Toggle = SecondSea:AddToggle("MyToggle", {Title = "• Auto Third Sea", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoThirdSea = Value
    end)
end

------------------------------- [ Third Sea ] -------------------------------

if ThirdSea then
    local Section = ThirdSea:AddSection("Third Sea")

    local Toggle = ThirdSea:AddToggle("MyToggle", {Title = "• Auto Pirate Raid", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoPirateRaid = Value
    end)

    local Toggle = ThirdSea:AddToggle("MyToggle", {Title = "• Auto Rainbow Haki", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoRainbowHaki = Value
    end)

    local Toggle = ThirdSea:AddToggle("MyToggle", {Title = "• Auto Canvander", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoCanvander = Value
    end)

    local Toggle = ThirdSea:AddToggle("MyToggle", {Title = "• Auto Buddy Sword", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoBuddySword = Value
    end)

    local Toggle = ThirdSea:AddToggle("MyToggle", {Title = "• Auto Dark Dagger", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoDarkDagger = Value
    end)

    local Toggle = ThirdSea:AddToggle("MyToggle", {Title = "• Auto Hallow Scythe", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoHallowScythe = Value
    end)

    local Toggle = ThirdSea:AddToggle("MyToggle", {Title = "• Auto Yama", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoYama = Value
    end)
    
    local Toggle = ThirdSea:AddToggle("MyToggle", {Title = "• Auto Tushita", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoTushita = Value
    end)

    local Toggle = ThirdSea:AddToggle("MyToggle", {Title = "• Auto Cursed Dual Katana", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoCursedDualKatana = Value
    end)

    local Toggle = ThirdSea:AddToggle("MyToggle", {Title = "• Auto Serpent Bow", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoSerpentBow = Value
    end)

    local Toggle = ThirdSea:AddToggle("MyToggle", {Title = "• Auto Soul Guitar", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoSoulGuitar = Value
    end)
end

------------------------------- [ Stats ] -------------------------------

local Section = Stats:AddSection("Stats")

local Toggle = Stats:AddToggle("MyToggle", {Title = "Auto Stats", Default = false })
Toggle:OnChanged(function(Value)
    _G.AutoStats = Value
    spawn(function()
        while task.wait(.1) do
            pcall(function()
                if _G.AutoStats then
                    if game:GetService("Players").LocalPlayer.Data.Stats.Melee.Level.Value ~= _G.MeleeValue then    
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
                elseif game:GetService("Players").LocalPlayer.Data.Stats.Defense.Level ~= _G.DefenseValue or game:GetService("Players").LocalPlayer.Data.Stats.Melee.Level.Value == _G.MeleeValue then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
                elseif game:GetService("Players").LocalPlayer.Data.Stats.Sword.Level ~= _G.SwordValue or game:GetService("Players").LocalPlayer.Data.Stats.Defense.Level == _G.DefenseValue then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1)
                elseif game:GetService("Players").LocalPlayer.Data.Stats["Demon Fruit"].Level ~= _G.BloxFruitValue or game:GetService("Players").LocalPlayer.Data.Stats["Demon Fruit"].Level == _G.BloxFruitValue then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1)
                    end
                end
            end)
        end
    end)
end)

local Section = Stats:AddSection("Stats Value")

local Input = Stats:AddInput("Input", { Title = "Melee", Default = 2550, Placeholder = "Placeholder", Numeric = false, Finished = false})
Input:OnChanged(function(Value)
    _G.MeleeValue = Value
end)
local Input = Stats:AddInput("Input", { Title = "Defense", Default = 2550, Placeholder = "Placeholder", Numeric = false, Finished = false})
Input:OnChanged(function(Value)
    _G.DefenseValue = Value
end)
local Input = Stats:AddInput("Input", { Title = "Sword", Default = 1275, Placeholder = "Placeholder", Numeric = false, Finished = false})
Input:OnChanged(function(Value)
    _G.SwordValue = Value
end)
local Input = Stats:AddInput("Input", { Title = "Blox Fruit", Default = 1275, Placeholder = "Placeholder", Numeric = false, Finished = false})
Input:OnChanged(function(Value)
    _G.BloxFruitValue = Value
end)

local Section = Stats:AddSection("Fast Attack Speed")

local Input = Stats:AddInput("Input", { Title = "Fast Attack", Default = 0.17, Placeholder = "Placeholder", Numeric = false, Finished = false})
Input:OnChanged(function(Value)
    _G.FastAttackSpeed = Value
end)

------------------------------- [ Combat ] -------------------------------

local Section = Combat:AddSection("Audio")

local Input = Combat:AddInput("Input", {Title = "Input Audio", Default = "rbxassetid://1841647093", Placeholder = "rbxassetid://ID", Numeric = false, Finished = false})
Input:OnChanged(function(Value)
    _G.AudioID = Value
end)

local Toggle = Combat:AddToggle("MyToggle", {Title = "Loop Audio", Default = false })
Toggle:OnChanged(function(Value)
    _G.AudioLooped = Value
end)

local Slider = Combat:AddSlider("Slider", {Title = "Volume Audio", Description = "", Default = 10, Min = 0, Max = 20, Rounding = 1})
Slider:OnChanged(function(Value)
    _G.AudioVolume = Value
end)

Combat:AddButton({ Title = "Play Audio", Description = "", Callback = function()
    local Sound = Instance.new('Sound',workspace)
    Sound.Volume = _G.AudioVolume
    Sound.Looped = _G.AudioLooped
    Sound.SoundId = _G.AudioID
    if not Sound:Play() then
        Sound:Play()
    end
end})

Combat:AddButton({ Title = "Stop Audio", Description = "", Callback = function()
    if game:GetService("Workspace"):FindFirstChild("Sound") then
        game:GetService("Workspace").Sound:Destroy()
    end
end})


local Section = Combat:AddSection("Teams")

Combat:AddButton({ Title = "Join Pirates Team", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
end})

Combat:AddButton({ Title = "Join Marines Team", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
end})

------------------------------- [ Player ] -------------------------------

local Section = Player:AddSection("Abilities")

local Toggle = Player:AddToggle("MyToggle", {Title = "Auto Active Race", Default = false })
Toggle:OnChanged(function(Value)
    _G.AutoActiveRace = Value
    spawn(function()
        while task.wait() do
            pcall(function()
                if _G.AutoActiveRace then
                    game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
                end
            end)
        end
    end)
end)

local Toggle = Player:AddToggle("MyToggle", {Title = "Auto Active Race V4", Default = false })
Toggle:OnChanged(function(Value)
    _G.AutoActiveRaceV4 = Value
end)

local Toggle = Player:AddToggle("MyToggle", {Title = "Semi Mink Race", Default = false })
Toggle:OnChanged(function(Value)
    _G.SemiMinkRace = Value
    if _G.SemiMinkRace then
        if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
            local inf = Instance.new("ParticleEmitter")
            inf.Acceleration = Vector3.new(0,0,0)
            inf.Archivable = true
            inf.Drag = 20
            inf.EmissionDirection = Enum.NormalId.Top
            inf.Enabled = true
            inf.Lifetime = NumberRange.new(0,0)
            inf.LightInfluence = 0
            inf.LockedToPart = true
            inf.Name = "Agility"
            inf.Rate = 500
            local numberKeypoints2 = {
                NumberSequenceKeypoint.new(0, 0);
                NumberSequenceKeypoint.new(1, 4); 
            }
            inf.Size = NumberSequence.new(numberKeypoints2)
            inf.RotSpeed = NumberRange.new(9999, 99999)
            inf.Rotation = NumberRange.new(0, 0)
            inf.Speed = NumberRange.new(30, 30)
            inf.SpreadAngle = Vector2.new(0,0,0,0)
            inf.Texture = ""
            inf.VelocityInheritance = 0
            inf.ZOffset = 2
            inf.Transparency = NumberSequence.new(0)
            inf.Color = ColorSequence.new(Color3.fromRGB(0,0,0),Color3.fromRGB(0,0,0))
            inf.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        end
    else
        if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
        end
    end
end)

local Toggle = Player:AddToggle("MyToggle", {Title = "Soru No Cooldown", Default = false })
Toggle:OnChanged(function(Value)
    _G.SoruNoCooldown = Value
    spawn(function()
        while task.wait() do
            pcall(function()
                if _G.SoruNoCooldown and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") ~= nil  then
                    for i,v in next, getgc() do
                        if game:GetService("Players").LocalPlayer.Character.Soru then
                            if typeof(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.Character.Soru then
                                for i2,v2 in next, getupvalues(v) do
                                    if typeof(v2) == "table" then
                                        repeat wait(.1)
                                            v2.LastUse = 0
                                        until not _G.SoruNoCooldown or game:GetService("Players").LocalPlayer.Character.Humanoid.Health <= 0
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end)

local Toggle = Player:AddToggle("MyToggle", {Title = "Walk On Water", Default = false })
Toggle:OnChanged(function(Value)
    _G.WalkOnWater = Value
    spawn(function()
        while wait() do
            pcall(function()
                if _G.WalkOnWater then
                    game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000,112,1000)
                else
                    game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000,80,1000)
                end
            end)
        end
    end)
end)

------------------------------- [ Visual ] -------------------------------

local Section = Visual:AddSection("ESP")

local Toggle = Visual:AddToggle("MyToggle", {Title = "Players ESP", Default = false })
Toggle:OnChanged(function(Value)
    _G.PlayersESP = Value
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        pcall(function()
            if v.Character then
                if _G.PlayersESP then
                    if v.Character.HumanoidRootPart and not v.Character.HumanoidRootPart:FindFirstChild("PlayerESP") then
                        local Bb = Instance.new("BillboardGui", v.Character.HumanoidRootPart)
                        Bb.Name = "PlayerESP"
                        Bb.ExtentsOffset = Vector3.new(0, 1, 0)
                        Bb.Size = UDim2.new(1, 200, 1, 30)
                        Bb.Adornee = v.Character.HumanoidRootPart
                        Bb.AlwaysOnTop = true
                        local Textlb = Instance.new("TextLabel", Bb)
                        Textlb.Font = "GothamBold"
                        Textlb.FontSize = "Size14"
                        Textlb.Text = v.Name.."\n"..math.round((v.Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                        Textlb.Size = UDim2.new(1,0,1,0)
                        Textlb.BackgroundTransparency = 1
                        Textlb.TextStrokeTransparency = 0.5
                        if v.Team == game:GetService("Players").LocalPlayer.Team then
                            Textlb.TextColor3 = Color3.new(255, 0, 0)
                        else
                            Textlb.TextColor3 = Color3.new(0, 0, 255)
                        end
                    else
                        v.Character.HumanoidRootPart["PlayerESP"].TextLabel.Text = v.Name.."\n"..math.round((v.Character.HumanoidRootPart.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                    end
                else
                    if v.Character.HumanoidRootPart:FindFirstChild("PlayerESP") then
                        v.Character.HumanoidRootPart:FindFirstChild("PlayerESP"):Destroy()
                    end
                end
            end
        end)
    end
end)

local Toggle = Visual:AddToggle("MyToggle", {Title = "Chests ESP", Default = false })
Toggle:OnChanged(function(Value)
    _G.ChestsESP = Value
    for i,v in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if v.Name == "Chest1" or v.Name == "Chest2" or v.Name == "Chest3" then
                if _G.ChestsESP then
                    if (v.Name == "Chest1" or v.Name == "Chest2" or v.Name == "Chest3") and (v.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 60000 then
                        if not v:FindFirstChild("ChestESP") then
                            local Bb = Instance.new("BillboardGui", v)
                            Bb.Name = "ChestESP"
                            Bb.ExtentsOffset = Vector3.new(0, 1, 0)
                            Bb.Size = UDim2.new(1, 200, 1, 30)
                            Bb.Adornee = v
                            Bb.AlwaysOnTop = true
                            local Textlb = Instance.new("TextLabel", Bb)
                            Textlb.Font = "GothamBold"
                            Textlb.FontSize = "Size14"
                            Textlb.Size = UDim2.new(1,0,1,0)
                            Textlb.BackgroundTransparency = 1
                            Textlb.TextStrokeTransparency = 0.5
                            if v.Name == "Chest1" then
                                Textlb.TextColor3 = Color3.fromRGB(100, 100, 100)
                                Textlb.Text = "Bronze Chest".."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                            end
                            if v.Name == "Chest2" then
                                Textlb.TextColor3 = Color3.fromRGB(255, 255, 0)
                                Textlb.Text = "Gold Chest".."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                            end
                            if v.Name == "Chest3" then
                                Textlb.Text = "Diamond Chest".."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                                Textlb.TextColor3 = Color3.fromRGB(0, 255, 255)
                            end
                        else
                            v["ChestESP"].TextLabel.Text = v.Name.."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                        end
                    end
                else
                    if v:FindFirstChild("ChestESP") then
                        v:FindFirstChild("ChestESP"):Destroy()
                    end
                end
            end
        end)
    end
end)

local Toggle = Visual:AddToggle("MyToggle", {Title = "Devil Fruits ESP", Default = false })
Toggle:OnChanged(function(Value)
    _G.DevilFruitsESP = Value
    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
        pcall(function()
            if string.find(v.Name, "Fruit") then
                if _G.DevilFruitsESP then
                    if string.find(v.Name, "Fruit") then
                        if not v.Handle:FindFirstChild("DevilESP") then
                            local Bb = Instance.new("BillboardGui", v.Handle)
                            Bb.Name = "DevilESP"
                            Bb.ExtentsOffset = Vector3.new(0, 1, 0)
                            Bb.Size = UDim2.new(1, 200, 1, 30)
                            Bb.Adornee = v.Handle
                            Bb.AlwaysOnTop = true
                            local Textlb = Instance.new("TextLabel", Bb)
                            Textlb.Font = "GothamBold"
                            Textlb.FontSize = "Size14"
                            Textlb.Size = UDim2.new(1,0,1,0)
                            Textlb.BackgroundTransparency = 1
                            Textlb.TextStrokeTransparency = 0.5
                            Textlb.Text = v.Name.."\n"..math.round((v.Handle.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                            Textlb.TextColor3 = Color3.new(155, 0, 255)
                        else
                            v.Handle["DevilESP"].TextLabel.Text = v.Name.."\n"..math.round((v.Handle.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                        end
                    end
                else
                    if v.Handle:FindFirstChild("DevilESP") then
                        v.Handle:FindFirstChild("DevilESP"):Destroy()
                    end
                end
            end
        end)
    end
end)

if SecondSea then
    local Toggle = Visual:AddToggle("MyToggle", {Title = "Flowers ESP", Default = false })
    Toggle:OnChanged(function(Value)
        _G.FlowersESP = Value
        for i,v in pairs(game.Workspace:GetChildren()) do
            pcall(function()
                if v.Name == "Flower2" or v.Name == "Flower1" then
                    if _G.FlowersESP then
                        if not v:FindFirstChild("FindFlower") then
                            local bill = Instance.new("BillboardGui",v)
                            bill.Name = "FindFlower"
                            bill.ExtentsOffset = Vector3.new(0, 1, 0)
                            bill.Size = UDim2.new(1,200,1,30)
                            bill.Adornee = v
                            bill.AlwaysOnTop = true
                            local name = Instance.new("TextLabel",bill)
                            name.Font = "GothamBold"
                            name.FontSize = "Size14"
                            name.TextWrapped = true
                            name.Size = UDim2.new(1,0,1,0)
                            name.TextYAlignment = "Top"
                            name.BackgroundTransparency = 1
                            name.TextStrokeTransparency = 0.5
                            name.TextColor3 = Color3.fromRGB(248, 41, 41)
                            if v.Name == "Flower1" then
                                name.Text = ("Blue Flower".."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                                name.TextColor3 = Color3.fromRGB(28, 126, 255)
                            end
                            if v.Name == "Flower2" then
                                name.Text = ("Red Flower".."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                                name.TextColor3 = Color3.fromRGB(248, 41, 41)
                            end
                        else
                            v["FindFlower"].TextLabel.Text = (v.Name.."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                        end
                    else
                        if v:FindFirstChild("FindFlower") then
                            v:FindFirstChild("FindFlower"):Destroy()
                        end
                    end
                end
            end)
        end
    end)
    
elseif ThirdSea then
    local Toggle = Visual:AddToggle("MyToggle", {Title = "Fruits ESP", Default = false })
    Toggle:OnChanged(function(Value)
        _G.FruitsESP = Value
        for i,v in pairs(game.Workspace:GetChildren()) do
            pcall(function()
                if v.Name == "Banana" or v.Name == "Apple" or v.Name == "Pineapple" then
                    if _G.FruitsESP then
                        if not v:FindFirstChild("FindFruit") then
                            local bill = Instance.new("BillboardGui",v)
                            bill.Name = "FindFruit"
                            bill.ExtentsOffset = Vector3.new(0, 1, 0)
                            bill.Size = UDim2.new(1,200,1,30)
                            bill.Adornee = v
                            bill.AlwaysOnTop = true
                            local name = Instance.new("TextLabel",bill)
                            name.Font = "GothamBold"
                            name.FontSize = "Size14"
                            name.TextWrapped = true
                            name.Size = UDim2.new(1,0,1,0)
                            name.TextYAlignment = "Top"
                            name.BackgroundTransparency = 1
                            name.TextStrokeTransparency = 0.5
                            if v.Name == "Banana" then
                                name.Text = ("Banana".."\n"..math.round((v.Handle.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                                name.TextColor3 = Color3.fromRGB(255, 255, 0)
                            end
                            if v.Name == "Apple" then
                                name.Text = ("Apple".."\n"..math.round((v.Handle.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                                name.TextColor3 = Color3.fromRGB(208, 0, 0)
                            end
                            if v.Name == "PineApple" then
                                name.Text = ("PineApple".."\n"..math.round((v.Handle.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                                name.TextColor3 = Color3.fromRGB(255, 128, 0)
                            end
                        else
                            v["FindFruit"].TextLabel.Text = (v.Name.."\n"..math.round((v.Handel.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                        end
                    else
                        if v:FindFirstChild("FindFruit") then
                            v:FindFirstChild("FindFruit"):Destroy()
                        end
                    end
                end
            end)
        end
    end)
end

local Section = Visual:AddSection("Devil Fruit")

DevilFruitTable = {"Rocket-Rocket", "Spin-Spin", "Chop-Chop", "Spring-Spring", "Bomb-Bomb", "Smoke-Smoke", "Spike-Spike", "Flame-Flame", "Falcon-Falcon", "Ice-Ice", "Sand-Sand", "Dark-Dark", "Diamond-Diamond", "Light-Light", "Rubber-Rubber", "Barrier-Barrier", "Ghost-Ghost", "Magma-Magma", "Quake-Quake", "Buddha-Buddha", "Love-Love", "Spider-Spider", "Sound-Sound", "Phoenix-Phoenix", "Portal-Portal", "Rumble-Rumble", "Paw-Paw", "Blizzard-Blizzard", "Gravity-Gravity", "Mammoth-Mammoth", "T-Rex-T-Rex", "Dough-Dough", "Shadow-Shadow", "Venom-Venom", "Control-Control", "Spirit-Spirit", "Dragon-Dragon", "Leopard-Leopard", "Kitsune-Kitsune" }
local SelectDevilFruit = Visual:AddDropdown("Dropdown", { Title = "Select Devil Fruits", Values = DevilFruitTable, Multi = false, Default = 1, })
SelectDevilFruit:SetValue(nil)
SelectDevilFruit:OnChanged(function(Value)
    _G.SelectDevilFruit = Value
end)

local Toggle = Visual:AddToggle("MyToggle", {Title = "Auto Buy Devil Fruits", Default = false })
Toggle:OnChanged(function(Value)
    _G.AutoBuyDevilFruit = Value
    spawn(function()
        while task.wait() do 
            if _G.AutoBuyDevilFruit then 
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", false) 
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", _G.SelectDevilFruit, false) 
            end 
        end 
    end)
end)

local Toggle = Visual:AddToggle("MyToggle", {Title = "Teleport To Devil Fruits", Default = false })
Toggle:OnChanged(function(Value)
    _G.TeleportToDevilFruits = Value
    spawn(function() 
        while task.wait() do 
            pcall(function()
                if _G.TeleportToDevilFruits then 
                    for i,v in pairs(game.Workspace:GetChildren()) do 
                        if string.find(v.Name, "Fruit") then 
                            TP(v.Handle.CFrame) 
                        end 
                    end 
                end
            end)
        end 
    end)
end)

local Toggle = Visual:AddToggle("MyToggle", {Title = "Auto Random Devil Fruits", Default = false })
Toggle:OnChanged(function(Value)
    _G.AutoRandomFruits = Value
    spawn(function()
        while task.wait() do 
            pcall(function() 
                if _G.AutoRandomFruits then 
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy") 
                end 
            end) 
        end 
    end)
end)

Visual:AddButton({ Title = "Devil Fruit Shop", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits") game.Players.localPlayer.PlayerGui.Main.FruitShop.Visible = true
end})

Visual:AddButton({ Title = "Random Devil Fruit", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
end})

Visual:AddButton({ Title = "Remove Devil Fruit", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RemoveFruit", "Beil")
end})

------------------------------- [ Teleport ] -------------------------------

local Section = Teleport:AddSection("Teleport Sea")

Teleport:AddButton({Title = "First Sea", Description = "Teleport To First Sea", Callback = function()
    Window:Dialog({Title = "First Sea", Content = "Do you want to go to the First Sea?", Buttons = {{Title = "Confirm", Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    end},
    {Title = "Cancel", Callback = function()
    end}}})
end})

Teleport:AddButton({Title = "Second Sea", Description = "Teleport To Second Sea", Callback = function()
    Window:Dialog({Title = "Second Sea", Content = "Do you want to go to the Second Sea?", Buttons = {{Title = "Confirm", Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end},
    {Title = "Cancel", Callback = function()
    end}}})
end})

Teleport:AddButton({Title = "Third Sea", Description = "Teleport To Third Sea", Callback = function()
    Window:Dialog({Title = "Third Sea", Content = "Do you want to go to the Third Sea?", Buttons = {{Title = "Confirm", Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end},
    {Title = "Cancel", Callback = function()
    end}}})
end})

local Section = Teleport:AddSection("Teleport Server")

Teleport:AddButton({Title = "Rejoin", Description = "Rejoin Server", Callback = function()
    Window:Dialog({Title = "Rejoin Server", Content = "Do you want to Rejoin Server?", Buttons = {{Title = "Confirm", Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").localPlayer)
    end},
    {Title = "Cancel", Callback = function()
    end}}})
end})

Teleport:AddButton({Title = "Hop", Description = "Hop Server", Callback = function()
    Window:Dialog({Title = "Hop Server", Content = "Do you want to go to Hop Server?", Buttons = {{Title = "Confirm", Callback = function()
        Hop()
    end},
    {Title = "Cancel", Callback = function()
    end}}})
end})
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            -- delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                task.wait()
                pcall(function()
                    task.wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                task.wait(4)
            end
        end
    end
end
function Hop()
    while task.wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

local Section = Teleport:AddSection("Teleport Island")

if FirstSea then
    IslandTable = {
        "Pirate Starter",
        "Middle Town",
        "Jungle",
        "Pirate Village",
        "Desert",
        "Frozen Village",
        "Marine Fortless",
        "Skylands 1",
        "Skylands 2",
        "Skylands 3",
        "Prison",
        "Colosseum",
        "Magma Village",
        "Whirlpoll",
        "Fountain City"
    }
    local SelectIsland = Teleport:AddDropdown("Dropdown", { Title = "Select Island", Values = IslandTable, Multi = false, Default = 1, })
    SelectIsland:SetValue(nil)
    SelectIsland:OnChanged(function(Value)
        SelectIsland = Value
    end)
    local Toggle = Teleport:AddToggle("MyToggle", {Title = "Teleport", Default = false })
    Toggle:OnChanged(function(Value)
        _G.TeleportIsland = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.TeleportIsland then
                        if SelectIsland == "Pirate Starter" then
                            TP(CFrame.new(1028, 19, 1367))
                        elseif SelectIsland == "Middle Town" then
                            TP(CFrame.new(-583, 6, 1714))
                        elseif SelectIsland == "Jungle" then
                            TP(CFrame.new(-1255.14795, 11.7000084, 350))
                        elseif SelectIsland == "Pirate Village" then
                            TP(CFrame.new(-1120, 5, 3855))
                        elseif SelectIsland == "Desert" then
                            TP(CFrame.new(1094, 5, 4193))
                        elseif SelectIsland == "Frozen Village" then
                            TP(CFrame.new(1186, 7, -1143))
                        elseif SelectIsland == "Marine Fortless" then
                            TP(CFrame.new(-4697, 20, 3975))
                        elseif SelectIsland == "Skylands 1" then
                            if (Vector3.new(-4968, 719, -2624) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4608, 873, -1668)) end 
                            TP(CFrame.new(-4968, 719, -2624))
                        elseif SelectIsland == "Skylands 2" then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4608, 873, -1668))
                        elseif SelectIsland == "Skylands 3" then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7947, 5547, -319))
                        elseif SelectIsland == "Prison" then
                            TP(CFrame.new(5033, 2, 767))
                        elseif SelectIsland == "Colosseum" then
                            TP(CFrame.new(-1333, 6, -2896))
                        elseif SelectIsland == "Magma Village" then
                            TP(CFrame.new(-5193, 5, 8570))
                        elseif SelectIsland == "Whirlpoll" then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(3905, 14, -1941))
                        elseif SelectIsland == "Fountain City" then
                            TP(CFrame.new(5091, 1, 4034))
                        end
                    end
                end)
            end
        end)
    end)
elseif SecondSea then
    IslandTable = {
        "Kingdom of Rose",
        "Café",
        "Green Zone",
        "Graveyard Island",
        "Snow Mountain",
        "Hot and Cold",
        "Cursed Ship",
        "Ice Castle",
        "Forgotten Island"
    }
    local SelectIsland = Teleport:AddDropdown("Dropdown", { Title = "Select Island", Values = IslandTable, Multi = false, Default = 1, })
    SelectIsland:SetValue(nil)
    SelectIsland:OnChanged(function(Value)
        SelectIsland = Value
    end)
    local Toggle = Teleport:AddToggle("MyToggle", {Title = "Teleport", Default = false })
    Toggle:OnChanged(function(Value)
        _G.TeleportIsland = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.TeleportIsland then
                        if SelectIsland == "Kingdom of Rose" then
                            TP(CFrame.new(83, 20, 2835))
                        elseif SelectIsland == "Café" then
                            TP(CFrame.new(-385, 74, 297))
                        elseif SelectIsland == "Green Zone" then
                            TP(CFrame.new(-2136, 72, -2759))
                        elseif SelectIsland == "Graveyard Island" then
                            if (Vector3.new(-5492, 49, -684) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1500 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-6508, 85, -133)) end 
                            TP(CFrame.new(-5492, 49, -684))
                        elseif SelectIsland == "Snow Mountain" then
                            TP(CFrame.new(296, 400, -5417))
                        elseif SelectIsland == "Hot and Cold" then
                            TP(CFrame.new(-5886, 16, -4968))
                        elseif SelectIsland == "Cursed Ship" then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(1003, 124, 32855))
                        elseif SelectIsland == "Ice Castle" then
                            TP(CFrame.new(5441, 33, -6417))
                        elseif SelectIsland == "Forgotten Island" then
                            TP(CFrame.new(-3077, 239, -10199))
                        end
                    end
                end)
            end
        end)
    end)
elseif ThirdSea then
    IslandTable = {
        "Port Town",
        "Hydra Island",
        "Great Tree",
        "Castle on the Sea",
        "Mansion",
        "Haunted Castle",
        "Peanut",
        "Icecream Island",
        "Loaf",
        "Chocolate",
        "CandyCane",
        "Tiki Outpost"
    }
    local SelectIsland = Teleport:AddDropdown("Dropdown", { Title = "Select Island", Values = IslandTable, Multi = false, Default = 1, })
    SelectIsland:SetValue(nil)
    SelectIsland:OnChanged(function(Value)
        SelectIsland = Value
    end)
    local Toggle = Teleport:AddToggle("MyToggle", {Title = "Teleport", Default = false })
    Toggle:OnChanged(function(Value)
        _G.TeleportIsland = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.TeleportIsland then
                        if SelectIsland == "Port Town" then
                            TP(CFrame.new(-288, 4, 5370))
                        elseif SelectIsland == "Hydra Island" then
                            if (Vector3.new(5017, 606, 346) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5729, 670, -272)) end
                            TP(CFrame.new(5017, 606, 346))
                        elseif SelectIsland == "Great Tree" then
                            TP(CFrame.new(2268, 28, -6600))
                        elseif SelectIsland == "Castle on the Sea" then
                            if (Vector3.new(-4999, 318, -3011) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5047, 315, -3135)) end 
                            TP(CFrame.new(-4999, 318, -3011))
                        elseif SelectIsland == "Mansion" then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12550, 342, -7470))
                        elseif SelectIsland == "Haunted Castle" then
                            TP(CFrame.new(-9506, 141, 5526))
                        elseif SelectIsland == "Peanut" then
                            TP(CFrame.new(-2026, 37, -10401))
                        elseif SelectIsland == "Icecream Island" then
                            TP(CFrame.new(-778, 65, -10923))
                        elseif SelectIsland == "Loaf" then
                            TP(CFrame.new(-1795, 37, -11938))
                        elseif SelectIsland == "Chocolate" then
                            TP(CFrame.new(78, 23, -12118))
                        elseif SelectIsland == "CandyCane" then
                            TP(CFrame.new(-980, 16, -14149))
                        elseif SelectIsland == "Tiki Outpost" then
                            TP(CFrame.new(-16218, 9, 446))
                        end
                    end
                end)
            end
        end)
    end)
end

------------------------------- [ Shop ] -------------------------------

local Section = Shop:AddSection("Fighting Styles")

Shop:AddButton({ Title = "Black Leg", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
end})

Shop:AddButton({ Title = "Electro", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
end})

Shop:AddButton({ Title = "Fishman Karate", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
end})

Shop:AddButton({ Title = "Dragon Claw", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
end})

Shop:AddButton({ Title = "Superhuman", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
end})

Shop:AddButton({ Title = "Death Step", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
end})

Shop:AddButton({ Title = "Sharkman Karate", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
end})

Shop:AddButton({ Title = "Electric Claw", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw",true)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
end})

Shop:AddButton({ Title = "Dragon Talon", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon",true)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
end})

Shop:AddButton({ Title = "Godhuman", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman",true)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
end})

Shop:AddButton({ Title = "Sanguine Art", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt",true)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt")
end})

local Section = Shop:AddSection("Abilities")

Shop:AddButton({ Title = "Buy Geppo", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
end})

Shop:AddButton({ Title = "Buy Buso Haki", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Buso")
end})

Shop:AddButton({ Title = "Buy Soru", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Soru")
end})

Shop:AddButton({ Title = "Buy Observation Haki", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Buy")
end})

local Section = Shop:AddSection("Fragment")

Shop:AddButton({ Title = "Stats Refund", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2")
end})

Shop:AddButton({ Title = "Rances Reroll", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2")
end})

local Section = Shop:AddSection("Ui Interface")

Shop:AddButton({ Title = "Open Title Inventory", Description = "", Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getTitles") game.Players.localPlayer.PlayerGui.Main.Titles.Visible = true
end})

Shop:AddButton({ Title = "Open Haki Color", Description = "", Callback = function()
    game.Players.localPlayer.PlayerGui.Main.Colors.Visible = true
end})

------------------------------- [ Materials ] -------------------------------

local Section = Materials:AddSection("Materials")
if FirstSea then
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Leather & Scrap Metal", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoLeatherAndScrapMetal = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoLeatherAndScrapMetal then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Pirate") or game:GetService("Workspace").Enemies:FindFirstChild("Brute") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Pirate" or v.Name == "Brute" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        BringMobNearest = true
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        PosMon = v.HumanoidRootPart.CFrame
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoLeatherAndScrapMetal or v.Humanoid.Health <= 0 or not v.Parent
                                    BringMobNearest = false
                                    FastAttack = false
                                end
                            end
                        else
                            BypassTP(CFrame.new(-1052, 44, 4090))
                            TP(CFrame.new(-1052, 44, 4090))
                        end
                    end
                end)
            end
        end)
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Magma Ore", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoMagmaOre = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoMagmaOre then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Military Soldier") or game:GetService("Workspace").Enemies:FindFirstChild("Military Spy") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Military Soldier" or v.Name == "Military Spy" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        BringMobNearest = true
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        PosMon = v.HumanoidRootPart.CFrame
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoMagmaOre or v.Humanoid.Health <= 0 or not v.Parent
                                    BringMobNearest = false
                                    FastAttack = false
                                end
                            end
                        else
                            BypassTP(CFrame.new(-5465, 111, 8675))
                            TP(CFrame.new(-5465, 111, 8675))
                        end
                    end
                end)
            end
        end)
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Fish Tail", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoFishTail = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoFishTail then
                        if (Vector3.new(61121, 18, 1565) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61165, 10, 1820)) end
                        if game:GetService("Workspace").Enemies:FindFirstChild("Fishman Warrior") or game:GetService("Workspace").Enemies:FindFirstChild("Fishman Commando") then
                            if (Vector3.new(61121, 18, 1565) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61165, 10, 1820)) end
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Fishman Warrior" or v.Name == "Fishman Commando" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        BringMobNearest = true
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        PosMon = v.HumanoidRootPart.CFrame
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                        if (Vector3.new(61121, 18, 1565) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61165, 10, 1820)) end
                                    until not _G.AutoFishTail or v.Humanoid.Health <= 0 or not v.Parent
                                    BringMobNearest = false
                                    FastAttack = false
                                end
                            end
                        else
                            TP(CFrame.new(math.random(61110,61710), 47, 1650))
                        end
                    end
                end)
            end
        end)
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Angel Wings", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoAngelWings = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoAngelWings then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Royal Squad") or game:GetService("Workspace").Enemies:FindFirstChild("Royal Soldier") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Royal Squad" or v.Name == "Royal Soldier" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        BringMobNearest = true
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        PosMon = v.HumanoidRootPart.CFrame
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoAngelWings or v.Humanoid.Health <= 0 or not v.Parent
                                    BringMobNearest = false
                                    FastAttack = false
                                end
                            end
                        else
                            if (Vector3.new(-7774, 5636, -1548) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1200 then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7910, 5575, -380))
                            end
                            TP(CFrame.new(-7774, 5636, -1548))
                        end
                    end
                end)
            end
        end)
    end)
end
if SecondSea then
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Scrap Metal", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoLeatherAndScrapMetal = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoLeatherAndScrapMetal then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Swan Pirate" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        BringMobNearest = true
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        PosMon = v.HumanoidRootPart.CFrame
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoLeatherAndScrapMetal or v.Humanoid.Health <= 0 or not v.Parent
                                    BringMobNearest = false
                                    FastAttack = false
                                end
                            end
                        else
                            BypassTP(CFrame.new(975, 121, 1290))
                            TP(CFrame.new(975, 121, 1290))
                        end
                    end
                end)
            end
        end)
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Radioactive Material", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoRadioactiveMaterial = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoRadioactiveMaterial then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Factory Staff") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Factory Staff" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        BringMobNearest = true
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        PosMon = v.HumanoidRootPart.CFrame
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoRadioactiveMaterial or v.Humanoid.Health <= 0 or not v.Parent
                                    BringMobNearest = false
                                    FastAttack = false
                                end
                            end
                        else
                            BypassTP(CFrame.new(295, 103, -56))
                            TP(CFrame.new(295, 103, -56))
                        end
                    end
                end)
            end
        end)
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Vampire Fang", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoVampireFang = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoVampireFang then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Vampire") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Vampire" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        BringMobNearest = true
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        PosMon = v.HumanoidRootPart.CFrame
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoVampireFang or v.Humanoid.Health <= 0 or not v.Parent
                                    BringMobNearest = false
                                    FastAttack = false
                                end
                            end
                        else
                            BypassTP(CFrame.new(-6059, 222, -1269))
                            TP(CFrame.new(-6059, 222, -1269))
                        end
                    end
                end)
            end
        end)
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Magma Ore", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoMagmaOre = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoMagmaOre then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Magma Ninja") or game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Magma Ninja" or v.Name == "Lava Pirate" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        BringMobNearest = true
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        PosMon = v.HumanoidRootPart.CFrame
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoMagmaOre or v.Humanoid.Health <= 0 or not v.Parent
                                    BringMobNearest = false
                                    FastAttack = false
                                end
                            end
                        else
                            BypassTP(CFrame.new(-5447, 46, -5258))
                            TP(CFrame.new(-5447, 46, -5258))
                        end
                    end
                end)
            end
        end)
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Ectoplasm", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoEctoplasm = Value
        task.spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoEctoplasm then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Ship Deckhand" or v.Name == "Ship Engineer" or v.Name == "Ship Officer" or v.Name == "Ship Steward" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        BringMobNearest = true
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        PosMon = v.HumanoidRootPart.CFrame
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoEctoplasm or v.Humanoid.Health <= 0 or not v.Parent
                                    UnEquip()
                                    BringMobNearest = false
                                    FastAttack = false
                                end
                            end
                        else 
                            if (Vector3.new(923, 127, 32853) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5000 then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923, 127, 32853))
                            end
                        end
                    end
                end)
            end
        end)
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Mystic Droplet", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoMysticDroplet = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoMysticDroplet then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Sea Soldier") or game:GetService("Workspace").Enemies:FindFirstChild("Water Fighter") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Sea Soldier" or v.Name == "Water Fighter" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        BringMobNearest = true
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        PosMon = v.HumanoidRootPart.CFrame
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoMysticDroplet or v.Humanoid.Health <= 0 or not v.Parent
                                    BringMobNearest = false
                                    FastAttack = false
                                end
                            end
                        else
                            BypassTP(CFrame.new(-3028, 100, -9798))
                            TP(CFrame.new(-3028, 100, -9798))
                        end
                    end
                end)
            end
        end)
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Dark Fragment", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoDarkFragment = Value
        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoDarkFragment then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Darkbeard") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Darkbeard" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon()
                                        FastAttack = true
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    until not _G.AutoDarkFragment or v.Humanoid.Health <= 0 or not v.Parent
                                    FastAttack = false
                                end
                            end
                        else
                            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then 
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) 
                            end
                            TP(game:GetService("ReplicatedStorage")["Darkbeard"].HumanoidRootPart.CFrame * CFrame.new(0,30,0)) 
                        end
                    end
                end)
            end
        end)
    end)
end
if ThirdSea then
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Mini Tusk", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoMiniTusk = Value
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Fish Tail", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoFishTail = Value
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Scrap Metal", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoLeatherAndScrapMetal = Value
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Dragon Scale", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoDragonScale = Value
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Conjured Cocoa", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoConjuredCocoa = Value
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Demonic Wisp", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoDemonicWisp = Value
    end)
    local Toggle = Materials:AddToggle("MyToggle", {Title = "Auto Gunpowder", Default = false })
    Toggle:OnChanged(function(Value)
        _G.AutoGunpowder = Value
    end)
end

------------------------------- [ Configurations ] -------------------------------

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("Luciano Hub")
SaveManager:SetFolder("Luciano Hub/specific-game")
InterfaceManager:BuildInterfaceSection(Configurations)
Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()
Configurations:AddButton({ Title = "Redeem All Code [⭐]", Description = "", Callback = function()
    function UseCode(Text)
        game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(Text)
    end
    UseCode("UPD16")
    UseCode("2BILLION")
    UseCode("UPD15")
    UseCode("FUDD10")
    UseCode("BIGNEWS")
    UseCode("THEGREATACE")
    UseCode("SUB2GAMERROBOT_EXP1")
    UseCode("StrawHatMaine")
    UseCode("Sub2OfficialNoobie")
    UseCode("SUB2NOOBMASTER123")
    UseCode("Sub2Daigrock")
    UseCode("Axiore")
    UseCode("TantaiGaming")
    UseCode("STRAWHATMAINE") 
    UseCode("3BVisits")
end})
Configurations:AddButton({ Title = "FPS Booster [🚀]", Description = "", Callback = function()
    game.Workspace.Terrain.WaterWaveSize = 0
    game.Workspace.Terrain.WaterWaveSpeed = 0
    game.Workspace.Terrain.WaterReflectance = 0
    game.Workspace.Terrain.WaterTransparency = 0
    game.Lighting.GlobalShadows = false
    game.Lighting.FogEnd = 9e9
    game.Lighting.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        end
    end
    for i, e in pairs(game.Lighting:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
end})

------------------------------- [ Function Use ] -------------------------------

game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
function GetData()
    return {game:GetService("Players").LocalPlayer.Data.Level.Value}
end
function CheckQuest()
    if FirstSea then
        if GetData()[1] <= 10 then
            if (Vector3.new(61121, 18, 1565) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3865, 6, -1926)) end
            return {"Bandit", "BanditQuest1", 1, CFrame.new(1059, 45, 1550), CFrame.new(1059, 15, 1550)}
        elseif GetData()[1] == 11 or GetData()[1] <= 119 then
            pcall(function()
                if _G.AutoFarmLevel then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Shanda") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Shanda" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat task.wait()
                                    EquipWeapon()
                                    BringMobBypass = true
                                    FastAttack = true
                                    v.Humanoid.WalkSpeed = 0
                                    v.Humanoid.JumpPower = 0
                                    PosMonBypass = v.HumanoidRootPart.CFrame
                                    TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                until not _G.AutoFarmLevel or v.Humanoid.Health <= 0
                                BringMobBypass = false
                                FastAttack = false
                            end
                        end
                    else 
                        if (Vector3.new(-7688, 5601, -441) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1600 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7910, 5575, -380))
                        else
                            TP(CFrame.new(-7688, 5601, -441))
                        end
                    end
                end
            end)
        elseif  GetData()[1] == 120 or GetData()[1] <= 149 then
            if (Vector3.new(61121, 18, 1565) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3865, 6, -1926)) end
            return {"Chief Petty Officer", "MarineQuest2", 1, CFrame.new(-4769, 5, 4296), CFrame.new(-5040, 27, 4325)}
        elseif  GetData()[1] == 150 or GetData()[1] <= 174 then
            if (Vector3.new(-4841, 718, -2620) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4608, 875, -1668)) end
            return {"Sky Bandit", "SkyQuest", 1, CFrame.new(-4945, 307, -2785), CFrame.new(-4840, 716, -2619)}  
        elseif  GetData()[1] == 175 or GetData()[1] <= 189 then
            if (Vector3.new(-4841, 718, -2620) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4608, 875, -1668)) end
            return {"Dark Master", "SkyQuest", 2, CFrame.new(-5225, 417, -2280), CFrame.new(-4840, 716, -2619)}
        elseif  GetData()[1] == 190 or GetData()[1] <= 209 then
            if (Vector3.new(5311, 0, 475) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2810 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3865, 6, -1926)) end
            return {"Prisoner", "PrisonerQuest", 1, CFrame.new(5090, 30, 424), CFrame.new(5311, 0, 475)}
        elseif  GetData()[1] == 210 or GetData()[1] <= 249 then
            if (Vector3.new(5311, 0, 475) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2810 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3865, 6, -1926)) end
            return {"Dangerous Prisoner", "PrisonerQuest", 2, CFrame.new(5646, 30, 765), CFrame.new(5311, 0, 475)}
        elseif  GetData()[1] == 250 or GetData()[1] <= 299 then
            if (Vector3.new(-1577, 7.5, -2987) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3420 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4608, 875, -1668)) end
            return {"Toga Warrior", "ColosseumQuest", 1, CFrame.new(-1800, 37, -2852), CFrame.new(-1577, 7, -2987)}
        elseif  GetData()[1] == 300 or GetData()[1] <= 324 then
            if (Vector3.new(61121, 18, 1565) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3865, 6, -1926)) end
            return {"Military Soldier", "MagmaQuest", 1, CFrame.new(-5465, 111, 8675), CFrame.new(-5313, 11, 8515)}
        elseif  GetData()[1] == 325 or GetData()[1] <= 374 then
            if (Vector3.new(61121, 18, 1565) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3865, 6, -1926)) end
            return {"Military Spy", "MagmaQuest", 2, CFrame.new(-5756, 172, 8771), CFrame.new(-5313, 11, 8515)}
        elseif  GetData()[1] == 375 or GetData()[1] <= 399 then
            if (Vector3.new(61121, 18, 1565) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61165, 10, 1820)) end
            return {"Fishman Warrior", "FishmanQuest", 1, CFrame.new(60891, 96, 1545), CFrame.new(61121, 18, 1565)}
        elseif  GetData()[1] == 400 or GetData()[1] <= 449 then
            if (Vector3.new(61121, 18, 1565) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61165, 10, 1820)) end
            return {"Fishman Commando", "FishmanQuest", 2, CFrame.new(61955, 76, 1584), CFrame.new(61121, 18, 1565)}
        elseif  GetData()[1] == 450 or GetData()[1] <= 474 then
            if (Vector3.new(-4722, 844, -1950) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1600 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4625, 850, -1705)) end
            return {"God's Guard", "SkyExp1Quest", 1, CFrame.new(-4722, 874, -1950), CFrame.new(-4722, 844, -1950)}
        elseif  GetData()[1] == 475 or GetData()[1] <= 524 then
            if (Vector3.new(-7859, 5544, -381) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1600 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7910, 5575, -380)) end
            return {"Shanda", "SkyExp1Quest", 2, CFrame.new(-7688, 5601, -441), CFrame.new(-7859, 5544, -381)}
        elseif  GetData()[1] == 525 or GetData()[1] <= 549 then
            if (Vector3.new(-7905, 5635, -1410) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1600 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7910, 5575, -380)) end
            return {"Royal Squad", "SkyExp2Quest", 1, CFrame.new(-7633, 5637, -1428), CFrame.new(-7905, 5635, -1410)}
        elseif  GetData()[1] == 550 or GetData()[1] <= 624 then
            if (Vector3.new(-7905, 5635, -1410) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1600 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7910, 5575, -380)) end
            return {"Royal Soldier", "SkyExp2Quest", 2, CFrame.new(-7760, 5680, -1887), CFrame.new(-7905, 5635, -1410)}
        elseif  GetData()[1] == 625 or GetData()[1] <= 649 then
            if (Vector3.new(5260, 37, 4050) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 6150 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3865, 6, -1926)) end
            return {"Galley Pirate", "FountainQuest", 1, CFrame.new(5559, 152, 4000), CFrame.new(5260, 37, 4050)}
        elseif  GetData()[1] >= 650 then
            if (Vector3.new(5260, 37, 4050) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 6150 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3865, 6, -1926)) end
            return {"Galley Captain", "FountainQuest", 2, CFrame.new(5678, 93, 4968), CFrame.new(5260, 37, 4050)}
        end
    end
    if SecondSea then
        if GetData()[1] <= 724 then
            return {"Raider", "Area1Quest", 1, CFrame.new(-666, 73, 2386), CFrame.new(-429, 72, 1836)}
        elseif  GetData()[1] == 725 or GetData()[1] <= 774 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Mercenary", "Area1Quest", 2, CFrame.new(-1095, 102, 1359), CFrame.new(-429, 72, 1836)}
        elseif  GetData()[1] == 775 or GetData()[1] <= 874 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Swan Pirate", "Area2Quest", 1, CFrame.new(975, 121, 1290), CFrame.new(638, 72, 918)}
        elseif  GetData()[1] == 875 or GetData()[1] <= 899 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Marine Lieutenant", "MarineQuest3", 1, CFrame.new(-2939, 152, -3063), CFrame.new(-2441, 72, -3216)}
        elseif  GetData()[1] == 900 or GetData()[1] <= 949 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Marine Captain", "MarineQuest3", 2, CFrame.new(-1838, 92, -3194), CFrame.new(-2441, 72, -3216)}
        elseif  GetData()[1] == 950 or GetData()[1] <= 974 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Zombie", "ZombieQuest", 1, CFrame.new(-5588, 187, -846), CFrame.new(-5497, 48, -795)}
        elseif  GetData()[1] == 975 or GetData()[1] <= 999 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Vampire", "ZombieQuest", 2, CFrame.new(-6059, 222, -1269), CFrame.new(-5497, 48, -795)}
        elseif  GetData()[1] == 1000 or GetData()[1] <= 1049 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Snow Trooper", "SnowMountainQuest", 1, CFrame.new(529, 430, -5543), CFrame.new(610, 400, -5372)}
        elseif  GetData()[1] == 1050 or GetData()[1] <= 1099 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Winter Warrior", "SnowMountainQuest", 2, CFrame.new(1264, 458, -5194), CFrame.new(610, 400, -5372)}
        elseif  GetData()[1] == 1100 or GetData()[1] <= 1124 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Lab Subordinate", "IceSideQuest", 1, CFrame.new(-5886, 53, -4968), CFrame.new(-6064, 15, -4903)}
        elseif  GetData()[1] == 1125 or GetData()[1] <= 1174 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Horned Warrior", "IceSideQuest", 2, CFrame.new(-6389, 28, -5870), CFrame.new(-6064, 15, -4903)}
        elseif  GetData()[1] == 1175 or GetData()[1] <= 1199 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Magma Ninja", "FireSideQuest", 1, CFrame.new(-5429, 83, -6072), CFrame.new(-5428, 15, -5299)}
        elseif  GetData()[1] == 1200 or GetData()[1] <= 1249 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Lava Pirate", "FireSideQuest", 2, CFrame.new(-5284, 35, -4705), CFrame.new(-5428, 15, -5299)}
        elseif  GetData()[1] == 1250 or GetData()[1] <= 1274 then
            if (Vector3.new(1041, 124, 32909) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 30000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923, 127, 32853)) end
            return {"Ship Deckhand", "ShipQuest1", 1, CFrame.new(918, 125, 32946), CFrame.new(1041, 124, 32909)}
        elseif  GetData()[1] == 1275 or GetData()[1] <= 1299 then
            if (Vector3.new(1041, 124, 32909) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 30000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923, 127, 32853)) end
            return {"Ship Engineer", "ShipQuest1", 2, CFrame.new(918, 125, 32946), CFrame.new(1041, 124, 32909)}
        elseif  GetData()[1] == 1300 or GetData()[1] <= 1324 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 30000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923, 127, 32853)) end
            return {"Ship Steward", "ShipQuest2", 1, CFrame.new(915, 130, 33439), CFrame.new(971, 124, 33249)}
        elseif  GetData()[1] == 1325 or GetData()[1] <= 1349 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 30000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923, 127, 32853)) end
            return {"Ship Officer", "ShipQuest2", 2, CFrame.new(911, 181, 33365), CFrame.new(971, 124, 33249)}
        elseif  GetData()[1] == 1350 or GetData()[1] <= 1374 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Arctic Warrior", "FrostQuest", 1, CFrame.new(5992, 58, -6180), CFrame.new(5668, 27, -6486)}
        elseif  GetData()[1] == 1375 or GetData()[1] <= 1424 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Snow Lurker", "FrostQuest", 2, CFrame.new(5518, 61, -6830), CFrame.new(5668, 27, -6486)}
        elseif  GetData()[1] == 1425 or GetData()[1] <= 1449 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Sea Soldier", "ForgottenQuest", 1, CFrame.new(-3028, 100, -9798), CFrame.new(-3054, 238, -10143)}
        elseif  GetData()[1] >= 1450 then
            if (Vector3.new(971, 125, 33245) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6509, 85, -133)) end
            return {"Water Fighter", "ForgottenQuest", 2, CFrame.new(-3229, 299, -10562), CFrame.new(-3054, 238, -10143)}
        end
    end
    if ThirdSea then
        if  GetData()[1] <= 1524 then
            return {"Pirate Millionaire", "PiratePortQuest", 1, CFrame.new(-294, 48, 5604), CFrame.new(-288, 44, 5579)}
        elseif  GetData()[1] == 1525 or GetData()[1] <= 1574 then
            return {"Pistol Billionaire", "PiratePortQuest", 2, CFrame.new(-387, 128, 5974), CFrame.new(-288, 44, 5579)}
        elseif  GetData()[1] == 1575 or GetData()[1] <= 1599 then
            return {"Dragon Crew Warrior", "AmazonQuest", 1, CFrame.new(6212, 52, -1283), CFrame.new(5834, 51, -1104)}
        elseif  GetData()[1] == 1600 or GetData()[1] <= 1624 then
            return {"Dragon Crew Archer", "AmazonQuest", 2, CFrame.new(6617, 383, 160), CFrame.new(5834, 51, -1104)}
        elseif  GetData()[1] == 1625 or GetData()[1] <= 1649 then
            return {"Female Islander", "AmazonQuest2", 1, CFrame.new(5704, 825, 1016), CFrame.new(5447, 602, 750)}
        elseif  GetData()[1] == 1650 or GetData()[1] <= 1699 then
            return {"Giant Islanders", "AmazonQuest2", 2, CFrame.new(4944, 670, -22), CFrame.new(5447, 602, 750)}
        elseif  GetData()[1] == 1700 or GetData()[1] <= 1724 then
            return {"Marine Commodore", "MarineTreeIsland", 1, CFrame.new(2622, 134, -7563), CFrame.new(2183, 29, -6739)}
        elseif  GetData()[1] == 1725 or GetData()[1] <= 1774 then
            return {"Marine Rear Admiral", "MarineTreeIsland", 2, CFrame.new(3598, 161, -6984), CFrame.new(2183, 29, -6739)}
        elseif  GetData()[1] == 1775 or GetData()[1] <= 1799 then
            return {"Fishman Raider", "DeepForestIsland3", 1, CFrame.new(-10440, 332, -8377), CFrame.new(-10582, 332, -8759)}
        elseif  GetData()[1] == 1800 or GetData()[1] <= 1824 then
            return {"Fishman Captain", "DeepForestIsland3", 2, CFrame.new(-11035, 332, -9087), CFrame.new(-10582, 332, -8759)}
        elseif  GetData()[1] == 1825 or GetData()[1] <= 1849 then
            return {"Forest Pirate", "DeepForestIsland", 1, CFrame.new(-13469, 412, -7816), CFrame.new(-13233, 332, -7627)}
        elseif  GetData()[1] == 1850 or GetData()[1] <= 1899 then
            return {"Mythological Pirate", "DeepForestIsland", 2, CFrame.new(-13502, 578, -6983), CFrame.new(-13233, 332, -7627)}
        elseif  GetData()[1] == 1900 or GetData()[1] <= 1924 then
            return {"Jungle Pirate", "DeepForestIsland2", 1, CFrame.new(-11838, 411, -10487), CFrame.new(-12684, 391, -9902)}
        elseif  GetData()[1] == 1925 or GetData()[1] <= 1974 then
            return {"Musketeer Pirate", "DeepForestIsland2", 2, CFrame.new(-13452, 556, -10049), CFrame.new(-12684, 391, -9902)}
        elseif  GetData()[1] == 1975 or GetData()[1] <= 1999 then
            return {"Reborn Skeleton", "HauntedQuest1", 1, CFrame.new(-8764, 180, 6167), CFrame.new(-9480, 142, 5562)}
        elseif  GetData()[1] == 2000 or GetData()[1] <= 2024 then
            return {"Living Zombie", "HauntedQuest1", 2, CFrame.new(-10040, 224, 5912), CFrame.new(-9480, 142, 5562)}
        elseif  GetData()[1] == 2025 or GetData()[1] <= 2049 then
            return {"Demonic Soul", "HauntedQuest2", 1, CFrame.new(-9499, 272, 6250), CFrame.new(-9515, 172, 6078)}
        elseif  GetData()[1] == 2050 or GetData()[1] <= 2074 then
            return {"Posessed Mummy", "HauntedQuest2", 2, CFrame.new(-9651, 6, 6121), CFrame.new(-9515, 172, 6078)}
        elseif  GetData()[1] == 2075 or GetData()[1] <= 2099 then
            return {"Peanut Scout", "NutsIslandQuest", 1, CFrame.new(-2095, 190, -10269), CFrame.new(-2106, 38, -10193)}
        elseif  GetData()[1] == 2100 or GetData()[1] <= 2124 then
            return {"Peanut President", "NutsIslandQuest", 2, CFrame.new(-2095, 190, -10269), CFrame.new(-2106, 38, -10193)}
        elseif  GetData()[1] == 2125 or GetData()[1] <= 2149 then
            return {"Ice Cream Chef", "IceCreamIslandQuest", 1, CFrame.new(-737, 212, -10976), CFrame.new(-823, 66, -10970)}
        elseif  GetData()[1] == 2150 or GetData()[1] <= 2199 then
            return {"Ice Cream Commander", "IceCreamIslandQuest", 2, CFrame.new(-534, 174, -11225), CFrame.new(-823, 66, -10970)}
        elseif  GetData()[1] == 2200 or GetData()[1] <= 2224 then
            return {"Cookie Crafter", "CakeQuest1", 1, CFrame.new(-2416, 80, -12050), CFrame.new(-2024, 38, -12026)}
        elseif  GetData()[1] == 2225 or GetData()[1] <= 2249 then
            return {"Cake Guard", "CakeQuest1", 2, CFrame.new(-2024, 38, -12026), CFrame.new(-2024, 38, -12026)}
        elseif  GetData()[1] == 2250 or GetData()[1] <= 2274 then
            return {"Baking Staff", "CakeQuest2", 1, CFrame.new(-1681, 144, -12578), CFrame.new(-1926, 40, -12841)}
        elseif  GetData()[1] == 2275 or GetData()[1] <= 2299 then	
            return {"Head Baker", "CakeQuest2", 2, CFrame.new(-2308, 106, -12926), CFrame.new(-1926, 40, -12841)}
        elseif  GetData()[1] == 2300 or GetData()[1] <= 2324 then
            return {"Cocoa Warrior", "ChocQuest1", 1, CFrame.new(82, 73, -12318), CFrame.new(233, 29, -12200)}
        elseif  GetData()[1] == 2325 or GetData()[1] <= 2349 then
            return {"Chocolate Bar Battler", "ChocQuest1", 2, CFrame.new(618, 79, -12571), CFrame.new(233, 29, -12200)}
        elseif  GetData()[1] == 2350 or GetData()[1] <= 2374 then
            return {"Sweet Thief", "ChocQuest2", 1, CFrame.new(-18, 66, -12690), CFrame.new(149, 25, -12775)}
        elseif  GetData()[1] == 2375 or GetData()[1] <= 2399 then
            return {"Candy Rebel", "ChocQuest2", 2, CFrame.new(133, 77, -12876), CFrame.new(149, 25, -12775)}
        elseif  GetData()[1] == 2400 or GetData()[1] <= 2424 then
            return {"Candy Pirate", "CandyQuest1", 1, CFrame.new(-909, 192, -14472), CFrame.new(-1151, 14, -14443)}
        elseif  GetData()[1] == 2425 or GetData()[1] <= 2449 then
            return {"Snow Demon", "CandyQuest1", 2, CFrame.new(-909, 192, -14472), CFrame.new(-1151, 14, -14443)}
        elseif  GetData()[1] == 2450 or GetData()[1] <= 2474 then
            return {"Isle Outlaw", "TikiQuest1", 1, CFrame.new(-16304, 94, -174), CFrame.new(-16549, 56, -176)}
        elseif  GetData()[1] == 2475 or GetData()[1] <= 2499 then
            return {"Island Boy", "TikiQuest1", 2, CFrame.new(-16765, 83, -251), CFrame.new(-16765, 83, -251)}
        elseif  GetData()[1] == 2500 or GetData()[1] <= 2524 then
            return {"Sun-kissed Warrior", "TikiQuest2", 1, CFrame.new(-16215, 138, 1028), CFrame.new(-16537, 56, 1051)}
        elseif  GetData()[1] >= 2525 then
            return {"Isle Champion", "TikiQuest2", 2, CFrame.new(-16788, 138, 1150), CFrame.new(-16537, 56, 1051)}
        end
    end
end
function TP(P)  
    spawn(function()
        pcall(function()
            if game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 then
                if game.Players.LocalPlayer.Character:FindFirstChild("Root") then
                    game:service("TweenService"):Create(
                        game.Players.LocalPlayer.Character.Root,
                        TweenInfo.new((game.Players.LocalPlayer.Character.Root.Position - P.Position).Magnitude/300, Enum.EasingStyle.Linear),
                        {CFrame = P}
                    ):Play()
                    if (game.Players.LocalPlayer.Character.Root.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 150 then
                        game.Players.LocalPlayer.Character.Root:Destroy()
                    else
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.Root.CFrame
                    end
                else
                    local R = Instance.new("Part",game.Players.LocalPlayer.Character)
                    R.Size = Vector3.new(1,0.5,1)
                    R.Name = "Root"
                    R.Anchored = true
                    R.Transparency = 1
                    R.CanCollide = false
                    R.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,30,0)
                end
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - P.Position).Magnitude <= 100 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
                end
            end
        end)
    end)
end
spawn(function()
    while task.wait() do
        local success, err = pcall(function()
            if 
            ---------------------------------- [ Gennaral ]
            _G.AutoFarmLevel or _G.AutoFarmNearest or _G.AutoFarmChest or
            ---------------------------------- [ First Sea ]
            _G.AutoSaber or  _G.PlayerHunterQuest or _G.AutoPole or _G.AutoSecondSea or
            ---------------------------------- [ Second Sea ]
            _G.AutoDeathStep or _G.AutoSharkmanKarate or _G.AutoFactory or _G.AutoFlowerQuest or _G.AutoRaceV3Quest or _G.AutoBartiloQuest or _G.AutoThirdSea or
            ---------------------------------- [ Thrid Sea ]
            _G.AutoPirateRaid or _G.AutoRainbowHaki or _G.AutoCanvander or _G.AutoBuddySword or _G.AutoDarkDagger or _G.AutoHallowScythe or _G.AutoYama or _G.AutoTushita or _G.AutoCursedDualKatana or _G.AutoSerpentBow or _G.AutoSoulGuitar or
            ---------------------------------- [ Devil Fruit & Teleport ]
            _G.TeleportToDevilFruits or _G.TeleportIsland or
            ---------------------------------- [ Materials ]
            _G.AutoLeatherAndScrapMetal or _G.AutoMagmaOre or _G.AutoFishTail or _G.AutoAngelWings or _G.AutoRadioactiveMaterial or _G.AutoVampireFang or _G.AutoEctoplasm or _G.AutoMysticDroplet or _G.AutoDarkFragment or _G.AutoMiniTusk or _G.AutoDragonScal or _G.AutoConjuredCocoa or _G.AutoDemonicWisp or _G.AutoGunpowder
            then
                for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Part") or v:IsA("MeshPart") then
                        v.CanCollide = false
                    end
                    if v:IsA("Humanoid") then
                        v.AutoRotate = false
                        v.PlatformStand = true
                    end
                end
                if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("BV") then
                    local BodyVelocity = Instance.new("BodyVelocity")
                    BodyVelocity.Parent = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    BodyVelocity.Name = "BV"
                    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
                    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                elseif not game.Players.LocalPlayer.Character:FindFirstChild("Highlight") then
                    local Highlight = Instance.new("Highlight")
                    Highlight.FillTransparency = 0.5
                    Highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    Highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
                    Highlight.FillTransparency = 0.5
                    Highlight.Parent = game.Players.LocalPlayer.Character
                end
                if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                end
            else
                game:GetService("Players").LocalPlayer.Character.Humanoid.AutoRotate = true
                game:GetService("Players").LocalPlayer.Character.Humanoid.PlatformStand = false
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.BV:Destroy()
                game.Players.LocalPlayer.Character.Highlight:Destroy()
            end
            task.wait(.15)
            TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
        end)
        if err and Debug then
            warn("[Caught Error] [No Clip]", err)
        end
    end
end)
spawn(function()
    while task.wait() do
        pcall(function()
            if BringMob then
                CheckQuest()
                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v.Name == CheckQuest()[1] and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 250 then
                        v.Humanoid.JumpPower = 0
                        v.Humanoid.WalkSpeed = 0
                        v.HumanoidRootPart.CFrame = PosMon
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while task.wait() do
        pcall(function()
            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if BringMobBypass then
                    if v.Name == "Shanda" and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 250 then
                        v.Humanoid.JumpPower = 0
                        v.Humanoid.WalkSpeed = 0
                        v.HumanoidRootPart.CFrame = PosMonBypass
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
                    end
                end
            end
        end)
    end	
end)
spawn(function()
    while task.wait() do
        pcall(function()
            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if BringMobNearest then
                    if (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 250 then
                        v.Humanoid.JumpPower = 0
                        v.Humanoid.WalkSpeed = 0
                        v.HumanoidRootPart.CFrame = PosMon
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
                    end
                end
            end
        end)
    end	
end)
function Click()
	local Module = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework)
	local CombatFramework = debug.getupvalues(Module)[2]
	local CamShake = require(game.ReplicatedStorage.Util.CameraShaker)
	CamShake:Stop()
	CombatFramework.activeController.attacking = false
	CombatFramework.activeController.timeToNextAttack = 0
	CombatFramework.activeController.hitboxMagnitude = 1000
	game:GetService'VirtualUser':CaptureController()
	game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
end
function GetItem(vu)
	for i,v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventoryWeapons")) do
		if v["Name"] == vu then
			return true
		end
	end
	return false
end

local Camera = require(game.ReplicatedStorage.Util.CameraShaker)
Camera:Stop()
local plr = game.Players.LocalPlayer
local CbFw = debug.getupvalues(require(plr.PlayerScripts.CombatFramework))
local CbFw2 = CbFw[2]

function GetCurrentBlade() 
local p13 = CbFw2.activeController
local ret = p13.blades[1]
if not ret then return end
while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
return ret
end
local time_all_x = 0
local time_all_p = 0
local time_x = 0
function getAllBladeHits(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Enemies = game:GetService("Workspace").Enemies:GetChildren()
	for i=1,#Enemies do local v = Enemies[i]
		local Human = v:FindFirstChildOfClass("Humanoid")
		if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
			table.insert(Hits,Human.RootPart)
		end
	end
	return Hits
end
time_xeg = 0
function AttackNoCD()
	pcall(function()
		if FarmPlayer and Farm_P_ATTK then
			if AttackPlayers == nil then
				AttackPlayers = 'None'
			end
			local AC = CbFw2.activeController
			for i = 1, 1 do 
				--[[ 
				local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
					plr.Character,
					{plr.Character.HumanoidRootPart},
					60
				)
				]]
				local cac = {}
				for k,v in pairs(game.Workspace.Characters:GetChildren()) do
					if v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 and tostring(v.Name) == AttackPlayers then
						table.insert(cac, v.HumanoidRootPart)
					end
				end
				--[[
				for k, v in pairs(bladehit) do
					if v.Parent:FindFirstChild("HumanoidRootPart") and (v.Parent:FindFirstChild("HumanoidRootPart").Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 and v.Parent:FindFirstChild("Humanoid").Health > 0 and string.find(tostring(v.Parent),'Lv') and not hash[v.Parent] then
						table.insert(cac, v.Parent.HumanoidRootPart)
						hash[v.Parent] = true
					end
				end
				]]
				bladehit = cac
				if #bladehit > 0 then
					local u8 = debug.getupvalue(AC.attack, 5)
					local u9 = debug.getupvalue(AC.attack, 6)
					local u7 = debug.getupvalue(AC.attack, 4)
					local u10 = debug.getupvalue(AC.attack, 7)
					local u12 = (u8 * 798405 + u7 * 727595) % u9
					local u13 = u7 * 798405
					(function()
						u12 = (u12 * u9 + u13) % 1099511627776
						u8 = math.floor(u12 / u9)
						u7 = u12 - u8 * u9
					end)()
					u10 = u10 + 1
					debug.setupvalue(AC.attack, 5, u8)
					debug.setupvalue(AC.attack, 6, u9)
					debug.setupvalue(AC.attack, 4, u7)
					debug.setupvalue(AC.attack, 7, u10)
					if time_all_p == 0 then
						wait(2)
					end
					time_x = time_x+1
					time_all_p = time_all_p+1
					if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then
						AC.animator.anims.basic[1]:Play(0.01,0.01,0.01)
						if time_x >= 2 and time_all_p >= 150 or game:GetService("Players").LocalPlayer.PlayerGui.Main.SafeZone.Visible == true then
							game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
							time_x = 0
						end
						game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
						game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 3, "")
					end
				end
			end
		else
			local AC = CbFw2.activeController
			for i = 1, 1 do
				--[[
				local cac = {}
				for k,v in pairs(game.Workspace.Enemies:GetChildren()) do
					if Select_List_Boss == 'Core' and Start_Kill_Boss and v:FindFirstChild("HumanoidRootPart") then
						table.insert(cac, v.HumanoidRootPart)
					elseif List.Quest and Quest == 'Evo Race V3' then
						if v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 70 then
							table.insert(cac, v.HumanoidRootPart)
						end
					else
						if v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 70 and string.find(tostring(v.Humanoid.DisplayName),'Lv.') then
							table.insert(cac, v.HumanoidRootPart)
						end
					end
				end]]
				local L_88_ = game.Players.LocalPlayer
				local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
					L_88_.Character, {
					L_88_.Character.HumanoidRootPart
				}, 80)
				--bladehit = getAllBladeHits(80)
				if #bladehit > 0 then
					local u8 = debug.getupvalue(AC.attack, 5)
					local u9 = debug.getupvalue(AC.attack, 6)
					local u7 = debug.getupvalue(AC.attack, 4)
					local u10 = debug.getupvalue(AC.attack, 7)
					local u12 = (u8 * 798405 + u7 * 727595) % u9
					local u13 = u7 * 798405
					(function()
						u12 = (u12 * u9 + u13) % 1099511627776
						u8 = math.floor(u12 / u9)
						u7 = u12 - u8 * u9
					end)()
					u10 = u10 + 1
					debug.setupvalue(AC.attack, 5, u8)
					debug.setupvalue(AC.attack, 6, u9)
					debug.setupvalue(AC.attack, 4, u7)
					debug.setupvalue(AC.attack, 7, u10)
					time_x = time_x+1
					time_all_x = time_all_x+1
					if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then
						AC.animator.anims.basic[1]:Play(0.01,0.01,0.01)
						if time_x >= 2 then
							game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
							time_x = 0
						end
						game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
						game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 3, "")
					end
				end
			end
		end
	end)
end
spawn(function()
	while task.wait() do
		pcall(function()
			if FastAttack then
				Click()
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if FastAttack then
				AttackNoCD()
				
			end
		end)
	end
end)
function EquipWeapon()
    if _G.SelectWeapons == "Melee" then
        Melee()
    elseif _G.SelectWeapons == "Sword" then
        Sword()
    elseif _G.SelectWeapons == "Blox Fruit" then
        BloxFruit()   
    end	
end
function Melee()    
    for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v.ClassName == "Tool" then
            if v.ToolTip == "Melee" then
                Equip(v.Name)
            end
        end
    end
end	
function Sword()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v.ClassName == "Tool" then
            if v.ToolTip == "Sword" then
                Equip(v.Name)
            end
        end
    end
end
function Gun()    
    for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v.ClassName == "Tool" then
            if v.ToolTip == "Gun" then
            Equip(v.Name)
            end
        end
    end
end
function BloxFruit()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v.ClassName == "Tool" then
            if v.ToolTip == "Blox Fruit" then
                Equip(v.Name)
            end
        end
    end
end
function Equip(ToolX)
    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ToolX) then
        getgenv().Tol = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ToolX)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tol)
    end
end
function UnEquip()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
end
function BypassTP(xyz)
    pcall(function()
        if (xyz.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 3000 and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
            repeat wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = xyz
                wait(.05)
                game.Players.LocalPlayer.Character.Humanoid.Health = 0
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = xyz
                wait(3.9)
            until (xyz.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 3000 and game.Players.LocalPlayer.Character.Humanoid.Health > 0
        end
    end)
end
if SecondSea then
    while task.wait() do
        pcall(function()
            if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hidden Key") then
                if (CFrame.new(6573, 296, -6964, 1, -1, 0.5, 1, 1, 4, -0.5, 1, 1).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                    Equip("Hidden Key")
                else
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6573, 296, -6964, 1, -1, 0.5, 1, 1, 4, -0.5, 1, 1)
                end
            end
        end)
    end
end
