local BaseUrl = "https://raw.githubusercontent.com/alekseypetrov742-dot/Abysall/refs/heads/main/"
if game.PlaceId ~= 6516141723 then
    loadstring(game:HttpGet(BaseUrl .. "Games/Doors/Main.luau?t=" .. tick()))()
else
    loadstring(game:HttpGet(BaseUrl .. "Games/Doors/Lobby.luau?t=" .. tick()))()
end
