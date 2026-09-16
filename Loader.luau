if getgenv().Abysall and getgenv().Abysall.Unload then
    pcall(getgenv().Abysall.Unload)
end
getgenv().Abysall = nil

local GameList = {
  [2440500124] = "Doors"
}

local BaseUrl = "https://raw.githubusercontent.com/alekseypetrov742-dot/Abysall/refs/heads/main/"
local function GetLatest(path)
    return game:HttpGet(BaseUrl .. path .. "?t=" .. tick())
end
getgenv().Abysall = {
    Environment = loadstring(GetLatest("Components/Environment.luau"))(),
    ESPLibrary = loadstring(GetLatest("Components/ESP.luau"))(),

    Legit = true, -- pog
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

if Abysall.Environment.writefile and Abysall.Environment.readfile then
    if not Abysall.Environment.isfile("Abysall/UserData.json") then
        local Data = {
            TotalExecutions = 0,
            UILibrary = "Obsidian"
        }
        Abysall.Environment.writefile("Abysall/UserData.json", Services.HttpService:JSONEncode(Data))
    end

    local UserData = Abysall.Environment.readfile("Abysall/UserData.json")
    local Decoded = Services.HttpService:JSONDecode(UserData)
    if not Decoded.TotalExecutions then
        Decoded.TotalExecutions = 0    
    end

    Decoded.TotalExecutions = Decoded.TotalExecutions + 1

    if not Decoded.UILibrary then
        Decoded.UILibrary = "Obsidian"
    end

    Abysall.TotalExecutions = Decoded.TotalExecutions
    Abysall.UILibrary = Decoded.UILibrary

    Abysall.Environment.writefile("Abysall/UserData.json", Services.HttpService:JSONEncode(Decoded))
end

Abysall.Interface = loadstring(GetLatest("Components/Interface.luau"))()
Abysall.Analytics = {}

local CurrentGame = GameList[game.GameId]
if CurrentGame then
    loadstring(GetLatest("Games/" .. CurrentGame .. "/Loader.luau"))()
else
    loadstring(GetLatest("Games/Universal/Loader.luau"))()
end
