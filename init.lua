local message = Instance.new("Message")
message.Parent = workspace
message.Text = "Getting gamelist"
local games = loadstring(game:HttpGet'https://raw.githubusercontent.com/bobtheblob/sads/main/gamelist.lua')()
if games[game.PlaceId] then
message.Text = "Found hub for current game"
wait(1)
message.Text = "Loading"
wait(.5)
loadstring(game:HttpGet(games[game.PlaceId]))()
wait(2)
message:Destroy()
else
message.Text = "Cannot find hub for current game"
wait(1)
message.Text = "Loading universal hub"
wait(.5)
wait(2)
message:Destroy()
end
