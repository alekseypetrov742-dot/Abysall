return function(Window)
    local LatestChangelog = {
        "14/9/2026 (Update 3)",
        "<font color='rgb(0, 255, 0)'>+ Correct Room status & [CORRECT] tag now only show in minigames / fake door rooms</font>",
        "<font color='rgb(0, 255, 0)'>+ Fixed Auto Interact to open ALL lockers, multi-door wardrobes, cabinets, desks & drawers</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Shakelight (10 coin green flashlight) vending machine to Junk filter</font>",
        "<font color='rgb(0, 255, 0)'>+ Fixed Position Spoof: smooth normal movement & jumping without sinking into floor</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Bypass Electrified Water: completely blocks electric puddle damage</font>",
        "<font color='rgb(0, 255, 0)'>+ Added full immunity & collision bypass for Drone Stampede / Rush Hour running drones</font>",
        "14/9/2026 (Update 2)",
        "<font color='rgb(0, 255, 0)'>+ Fixed FOV stutter/glitches (Added Custom Field of View toggle)</font>",
        "<font color='rgb(0, 255, 0)'>+ Fixed Crouch & Shift locking; enabled Jumping by default</font>",
        "<font color='rgb(0, 255, 0)'>+ Fixed Closet/Locker exit delay & added Emergency Exit Closet button</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Room Status Notifier (Real vs Fake Dupe Room/Door) & ESP markers</font>",
        "<font color='rgb(0, 255, 0)'>+ Consolidated Auto Interact filters into a single 'Junk' category</font>",
        "<font color='rgb(0, 255, 0)'>+ Fixed Auto Interact Locker opening regression (Open/Search/Loot once)</font>",
        "14/9/2026",
        "<font color='rgb(0, 255, 0)'>+ Added Bypass Drones (Immunity & Noclip against Drones)</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Water Cooler ESP & Spawn Notifier</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Disable Push Chairs Toggle</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Auto Interact Filters (Terminals, Trashcans, Printers, Fish Tank, Lockers Once)</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Water Cup ESP (Good/Bad/Terrible tiers)</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Locker Auto-Loot & Seat Ignoring for Auto Interact</font>",
        "<font color='rgb(0, 255, 0)'>+ Added New Items to ESP (Pizza, PaperPlane, FihFlakes, WaterCup, PocketMirror)</font>",
        "11/7/2026",
        "<font color='rgb(0, 255, 0)'>+ Added Entity ESP Selection</font>",
		"<font color='rgb(0, 255, 0)'>+ Added Item Notifier</font>",
		"<font color='rgb(0, 255, 0)'>+ Added Remove Surge</font>",
		"<font color='rgb(0, 255, 0)'>+ Added Death Farm</font>",
		"<font color='rgb(0, 255, 0)'>+ Fixed Some Broken Features (Bypass Eyes, etc)</font>",
    }

    local function CloneReference(Object)
        if Abysall and Abysall.Environment.cloneref then
            return Abysall.Environment.cloneref(Object)
        else
            return Object
        end
    end

    local Services = setmetatable({}, {
        __index = function(self, Name)
            return CloneReference(game:GetService(Name))
        end
    })

    local Library = Abysall.Interface.Library
    local SaveManager = Abysall.Interface.SaveManager
    local ThemeManager = Abysall.Interface.ThemeManager

    local Toggles = Library.Toggles
    local Options = Library.Options

    local LocalPlayer = Services.Players.LocalPlayer
    local InfoTab = Window:AddTab("Info", "user")

    local User = InfoTab:AddLeftGroupbox("User Info")

    local ImageSize = Enum.ThumbnailSize.Size420x420
    local ImageType = Enum.ThumbnailType.HeadShot

    local Content = Services.Players:GetUserThumbnailAsync(LocalPlayer.UserId, ImageType, ImageSize)

    User:AddImage("UserIcon", {
        Image = Content
    })

    User:AddLabel("ID: " .. LocalPlayer.Name, true)
    User:AddLabel("Total Executions: " .. (Abysall.TotalExecutions and Abysall.TotalExecutions or "N/A"), true)

    local Changelog = InfoTab:AddRightGroupbox("Changelog")
    for Index, Change in pairs(LatestChangelog) do
        Changelog:AddLabel(Change, true)
    end

    local Name, Version = Abysall.Environment.identifyexecutor()
    local Executor = InfoTab:AddRightGroupbox("Executor Info")
    Executor:AddLabel("Name: " .. Name, true)
	Executor:AddLabel("Version: " .. (Version and Version or "N/A"), true)
    Executor:AddDivider()
    Executor:AddLabel("Test Result: ", true)

    for Index, Result in pairs(Abysall.Environment.Results) do
		-- fix for veloshitty 💔
		Result = Result:gsub("<", "(")
		Result = Result:gsub(">", ")")
		
        Executor:AddLabel(Result, true)
    end

    local Community = InfoTab:AddLeftGroupbox("Community")
    Community:AddButton("Copy Discord Invite", function()
	    toclipboard("https://dsc.gg/abysallhub")
	    Library:Notify("Discord invite copied.")
    end)
end
