local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Tester Hub", "LightTheme")
local Tab = Window:NewTab("TabName")
local Section = Tab:NewSection("Section Name")
Section:NewToggle("ToggleText", "ToggleInfo", function(state)
    _G.AutoFarm = state
end)



function Checklevel()
    local mylvl = game:GetService("Players").LocalPlayer.Data.Level.Value
    if mylvl == 1 or mylvl < 10 then
        mon = "Bandit [Lv. 5]"
        monname = "Bandit"
        quest = "BanditQuest1"
        questnum = 1
        questcf = CFrame.new(1059.668212890625, 16.362747192382812, 1549.0234375)
        moncf = CFrame.new(1200.199462890625, 16.703495025634766, 1619.107177734375)
    elseif mylvl == 10 or mylvl < 15 then
        mon = "Monkey [Lv. 14]"
        monname = "Monkey"
        quest = "JungleQuest"
        questnum = 1
        questcf = CFrame.new(-1599.4368896484375, 36.85213851928711, 152.9742431640625)
        moncf = CFrame.new(-1577.9737548828125, 22.85259437561035, 20.22406768798828)
    elseif mylvl == 15 or mylvl < 30 then
        mon = "Gorilla [Lv. 20]"
        monname = "Gorilla"
        quest = "JungleQuest"
        questnum = 2
        questcf = CFrame.new(-1599.4368896484375, 36.85213851928711, 152.9742431640625)
        moncf = CFrame.new(-1281.79931640625, 6.220486640930176, -522.4990844726562)
    elseif mylvl == 30 or mylvl < 40 then
        mon = "Pirate [Lv. 35]"
        monname = "Pirate"
        quest = "BuggyQuest1"
        questnum = 1
        moncf = CFrame.new(-1208.138671875, 4.752060890197754, 3916.29150390625)
        questcf = CFrame.new(-1141.0999755859375, 4.752061367034912, 3829.993896484375)
    elseif mylvl == 40 or mylvl < 60 then
        mon = "Brute [Lv. 45]"
        monname = "Brute"
        quest = "BuggyQuest1"
        questnum = 2
        moncf = CFrame.new(-1048.4010009765625, 14.869885444641113, 4303.21826171875)
        questcf = CFrame.new(-1141.0999755859375, 4.752061367034912, 3829.993896484375)
    elseif  mylvl == 60 or mylvl < 75 then
        mon = "Desert Bandit [Lv. 60]"
        monname = "Desert Bandit"
        quest = "DesertQuest"
        questnum = 1
        moncf = CFrame.new(933.5277099609375, 6.450352191925049, 4486.57421875)
        questcf = CFrame.new(895.6196899414062, 6.438474178314209, 4390.654296875)
    elseif mylvl == 74 or mylvl < 90 then
        mon = "Desert Officer [Lv. 70]"
        monname = "Desert Officer"
        quest = "DesertQuest"
        questnum = 2
        moncf = CFrame.new(1616.0458984375, 1.6109663248062134, 4371.07861328125)
        questcf = CFrame.new(895.6196899414062, 6.438474178314209, 4390.654296875)
    elseif mylvl == 90 or mylvl < 100  then
        mon = "Snow Bandit [Lv. 90]"
        monname = "Snow Bandit"
        quest = "SnowQuest"
        questnum = 1
        moncf = CFrame.new(1283.1610107421875, 87.27277374267578, -1372.334228515625)
        questcf = CFrame.new(1388.1300048828125, 87.27277374267578, -1298.7183837890625)
    elseif mylvl == 100 or mylvl < 120 then
        mon = "Snowman [Lv. 100]"
        monname = "Snowman"
        quest = "SnowQuest"
        questnum = 2
        moncf = CFrame.new(1197.00927734375, 105.77465057373047, -1450.333251953125)
        questcf = CFrame.new(1388.1300048828125, 87.27277374267578, -1298.7183837890625)
    end
end




spawn(function()    -- Spawn AutoFarm
    while wait() do
        pcall(function()
            if _G.AutoFarm then
                Checklevel()
                if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,monname) then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                    tp(questcf)
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - questcf.Position).Magnitude <= 5 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", quest, questnum)
                    end
                else
                    if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                    end
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.name == mon then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                if v.Humanoid.Health >= 0 then
                                    repeat wait()
                                        tp(v.HumanoidRootPart.CFrame * CFrame.new(0,25,0))
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                    until _G.AutoFarm == false or v.Humanoid.Health <= 0
                                end
                            end
                        else
                            tp(moncf)
                        end
                    end
                end
            end
        end)
    end
end)

spawn(function()-- noclib
    game:GetService("RunService").Heartbeat:Connect(function() wait()
        pcall(function()
            if _G.AutoFarm then
                if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
                    setfflag("HumanoidParallelRemoveNoPhysics", "False")
                    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                    game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
                end
            end
        end)
    end)
end)

function tp(CF)
    game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CF.Position).Magnitude/350, Enum.EasingStyle.Linear), {CFrame = CF}):Play()
end



local SuperFastMode = true -- ถ้าเปิดจะเป็น Super Fast Attack มันเร้วมากแต่มีโอกาศหลุด ปิดก้ตีเร็วแต่ไม่หลุด มันต่างกัน By.piyth001

pcall(function()
    

local plr = game.Players.LocalPlayer

local CbFw = debug.getupvalues(require(plr.PlayerScripts.CombatFramework))
local CbFw2 = CbFw[2]

function GetCurrentBlade() 
    local p13 = CbFw2.activeController
    local ret = p13.blades[1]
    if not ret then return end
    while ret.Parent ~= game.Players.LocalPlayer.Character do ret=ret.Parent end
    return ret
end

function AttackNoCD() 
    local AC = CbFw2.activeController
    for i = 1, 1 do 
        local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
            plr.Character,
            {plr.Character.HumanoidRootPart},
            60
        )
        local cac = {}
        local hash = {}
        for k, v in pairs(bladehit) do
            if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                table.insert(cac, v.Parent.HumanoidRootPart)
                hash[v.Parent] = true
            end
        end
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
            pcall(function()
                for k, v in pairs(AC.animator.anims.basic) do
                    v:Play()
                end                  
            end)
            if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then 
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
                game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "") 
            end
        end
    end
end
end)
local cac
if SuperFastMode then 
	cac=task.wait
else
	cac=wait
end
task.spawn(function()
    while cac(0.089) do 
        if _G.AutoFarm then
            repeat wait(.01)
                AttackNoCD()
            until _G.AutoFarm == false
        end
    end
end)
