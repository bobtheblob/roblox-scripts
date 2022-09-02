getgenv_list = getgenv and getgenv() or {}
getgenv = getgenv or function()
	return getgenv_list
end
function httprequire(link)
	return loadstring(game:HttpGet(link))()
end
local lib = httprequire("https://pastebin.com/raw/JUFhCJLQ")
local remotes = workspace:WaitForChild("Remote")
local loadchar = remotes:WaitForChild("loadchar")
local itemhandler = remotes:WaitForChild("ItemHandler")
local items = workspace:WaitForChild("Prison_ITEMS")
local giver = items.giver
local single = items.single
local m9 = giver:WaitForChild'M9'
local cam = workspace.CurrentCamera

local mps = game:GetService("MarketplaceService")
local teams = game:GetService("Teams")
local startergui = game:GetService("StarterGui")
local plrs = game:GetService("Players")
local uis = game:GetService("UserInputService")

local lplr = plrs.LocalPlayer
local mouse = lplr:GetMouse()
local owns_riotpolice = mps:UserOwnsGamePassAsync(lplr.UserId,96651)

local window = lib:newWindow("prison life")
local fastrespawn = false
local fastrespawned = false
local respawninplace = false
local respawned = false
local lastpos = CFrame.new()
local cons = {}
local deadfuncs = {}
local char
local hum
local shutdown = false
local spawns = {}
local isflying = false
local noclipping = false
local airswim = false
local iamspeed = false
local lastws = 16
local runspeed = 80
local lastgrav = workspace.Gravity
--
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastctrl = {f = 0, b = 0, l = 0, r = 0}
local maxspeed = 50
local speed = 0
local mainfly
--
function addcon(event)
	table.insert(cons,event)
end
--
function flysetup(dofly)
	repeat wait() until char
	local plr = lplr
	local torso = hum.RootPart
	local deb = true

	local function Fly()
		task.spawn(function()
			local bg = Instance.new("BodyGyro", torso)
			bg.P = 9e4
			bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			bg.cframe = torso.CFrame
			local bv = Instance.new("BodyVelocity", torso)
			bv.velocity = Vector3.new(0,0.1,0)
			bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
			repeat task.wait()
				hum.PlatformStand = true
				if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
					speed = speed+.5+(speed/maxspeed)
					if speed > maxspeed then
						speed = maxspeed
					end
				elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
					speed = speed-1
					if speed < 0 then
						speed = 0
					end
				end
				if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
					bv.velocity = ((cam.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((cam.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
					lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
				elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
					bv.velocity = ((cam.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((cam.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				else
					bv.velocity = Vector3.new(0,0.1,0)
				end
				bg.cframe = cam.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
			until not isflying or char:IsDescendantOf(workspace) == false or hum.Health <= 0
			ctrl = {f = 0, b = 0, l = 0, r = 0}
			lastctrl = {f = 0, b = 0, l = 0, r = 0}
			speed = 0
			bg:Destroy()
			bv:Destroy()
			hum.PlatformStand = false
		end)
	end
	if dofly then
		Fly()
	end
	return {
		dofly = Fly
	}
end
addcon(mouse.KeyDown:connect(function(key)
	if key:lower() == "w" then
		ctrl.f = 1
	elseif key:lower() == "s" then
		ctrl.b = -1
	elseif key:lower() == "a" then
		ctrl.l = -1
	elseif key:lower() == "d" then
		ctrl.r = 1
	end
end))
addcon(mouse.KeyUp:connect(function(key)
	if key:lower() == "w" then
		ctrl.f = 0
	elseif key:lower() == "s" then
		ctrl.b = 0
	elseif key:lower() == "a" then
		ctrl.l = 0
	elseif key:lower() == "d" then
		ctrl.r = 0
	end
end))
--
function notify(data)
	local title = data.title or "Notification"
	local text = data.text or "Hello world!"
	local dur = data.dur
	local cb = data.callback
	local b1 = data.button1
	local b2 = data.button2
	startergui:SetCore("SendNotification", {
		Title = title,
		Text = text,
		Duration = dur,
		Callback = cb,
		Button1 = b1,
		Button2 = b2,
	})
end
--
function getplayer(name)
	local list = {}
	local lowername = name:lower()
	if lowername == "all" then
		return plrs:GetPlayers()
	end
	if name:sub(1,1) == "%" and teams:FindFirstChild(name:sub(2)) then
		for _, player in ipairs(teams:FindFirstChild(name:sub(2)):GetPlayers()) do
			table.insert(list,player)
		end
		return list
	end
	for _, player in ipairs(plrs:GetPlayers()) do
		if lowername == player.Name:lower():sub(1, #lowername) then
			table.insert(list,player)
		end
	end
	return list
end
--
for i,v in pairs(workspace:GetDescendants()) do
	if v:IsA("SpawnLocation") and v.TeamColor ~= BrickColor.new("Medium stone grey") then
		table.insert(spawns,v)
	end
end
--
function teleport(plr,pos)
	if plr == char then return end
	task.wait(.2)
	local lastchar = char
	local storedpos = char:GetPivot()
	fastrespawned = true
	lastpos = char:GetPivot()
	loadchar:InvokeServer()
	repeat task.wait() until char ~= lastchar
	char:PivotTo(pos)
	itemhandler:InvokeServer(m9.ITEMPICKUP)
	hum.Name = "1"
	local clone = hum:Clone()
	clone.Name = "Humanoid"
	clone.Parent = char
	hum:Destroy()
	cam.CameraSubject = clone
	task.wait()
	local tool = char:FindFirstChild("M9") or lplr.Backpack:FindFirstChild("M9")
	if not tool then
		itemhandler:InvokeServer(m9.ITEMPICKUP)
		tool = char:FindFirstChild("M9") or lplr.Backpack:FindFirstChild("M9")
	end
	tool.Parent = char
	local timer = 0
	repeat
		task.wait()
		plr:PivotTo(clone.RootPart.CFrame*CFrame.new(.3,0,-.75))
		timer = timer + 1
		if tool.Parent ~= plr and tool.Parent ~= char then
			itemhandler:InvokeServer(m9.ITEMPICKUP)
			tool = char:FindFirstChild("M9") or lplr.Backpack:FindFirstChild("M9")
		end
	until tool.Parent == plr or timer > 100
	task.wait(.2)
	loadchar:InvokeServer()
	char:PivotTo(storedpos)
end
--
local teleports = {
	armory = CFrame.new(832, 101, 2265),
	guardroom = CFrame.new(836, 101, 2310),
	nexus = CFrame.new(919, 101, 2376),
	mainhall = CFrame.new(828, 101, 2360),
	cafeteria = CFrame.new(915, 101, 2330),
	gate = CFrame.new(487, 99, 2219),
	yard = CFrame.new(815, 99, 2456),
	cell = CFrame.new(916, 101, 2421),
	behindcell = CFrame.new(985, 99, 2417),
	office = CFrame.new(691, 101, 2339),
	
	crimbase_outside = CFrame.new(-921, 96, 2138),
	crimbase_inside = CFrame.new(-976, 110, 2062),
	crimbase_armory = CFrame.new(-944, 95, 2062),
	
	bridge_basement = CFrame.new(-41, 14, 1300),
	armoryplus = CFrame.new(401, 17, 1141),
	lakesidegrocer = CFrame.new(473, 16, 1139),
	
	secret1 = CFrame.new(-341, 78, 1806),
	secret2 = CFrame.new(-299, 100, 2028),
	secret3 = CFrame.new(-691, 69, 2583),
	secret4 = CFrame.new(905, 162, 2945),
	secret5 = CFrame.new(277, 64, 2376),
	secret6 = CFrame.new(1109, 22, 1489),
	
	neutralspawn = CFrame.new(880, 31, 2346),
}
--
local playersfunc = {
	goto = function(plr)
		if not plr.Character then return end
		char:PivotTo(plr.Character:GetPivot())
	end,
	bring = function(plr)
		if not plr.Character then return end
		teleport(plr.Character,char:GetPivot())
	end,
	getteamcolor = function(plr)
		notify({
			text = plr.DisplayName.."'s TeamColor : "..tostring(plr.TeamColor)
		})
	end,
}
-- teams
local tab = window:createTab("teams")
local textbox = tab:createTextbox("Team color",function(text)end)
local tab_b1 = tab:createButtons()
tab_b1:createButton("change color",function()
	fastrespawned = true
	lastpos = char:GetPivot()
	loadchar:InvokeServer(lplr,textbox:getText())
end)
-- character
local tab2 = window:createTab("character")
tab2:createToggle("fast respawn",function(bool)
	fastrespawn = bool
end,fastrespawn)
tab2:createToggle("fly",function(bool)
	isflying = bool
	if isflying and mainfly then
		mainfly:dofly()
	end
end,isflying)
tab2:createTextbox("fly max speed",function(t)
	maxspeed = tonumber(t) or 50
end):update(maxspeed)
tab2:createToggle("noclip",function(bool)
	noclipping = bool
end,noclipping)
tab2:createToggle("airswim",function(bool)
	airswim = bool
	if airswim then
		local enums = Enum.HumanoidStateType:GetEnumItems()
		table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
		table.remove(enums, table.find(enums, Enum.HumanoidStateType.Dead))
		for i, v in pairs(enums) do
			hum:SetStateEnabled(v, false)
		end
		hum:ChangeState(Enum.HumanoidStateType.Swimming)
		lastgrav = workspace.Gravity
		workspace.Gravity = 0
	else
		local enums = Enum.HumanoidStateType:GetEnumItems()
		table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
		table.remove(enums, table.find(enums, Enum.HumanoidStateType.Dead))
		for i, v in pairs(enums) do
			hum:SetStateEnabled(v, true)
		end
		workspace.Gravity = lastgrav
	end
end,airswim)
tab2:createToggle("loop walkspeed",function(bool)
	iamspeed = bool
	if iamspeed == true then
		lastws = hum.WalkSpeed
	else
		hum.WalkSpeed = lastws
	end
end,iamspeed)
tab2:createTextbox("run speed",function(t)
	runspeed = tonumber(t) or 50
end):update(runspeed)
-- weapon modding
local wepsettings = {}
wepsettings.MaxAmmo = 1000
wepsettings.FireRate = 0.001
wepsettings.AutoFire = true
wepsettings.Range = 400
wepsettings.Spread = 1
wepsettings.ReloadTime = 0
wepsettings.Bullets = 10
local tab3 = window:createTab("weapon modding")
for i,v in pairs(wepsettings) do
	if type(v) == 'boolean' then
		tab3:createToggle(i,function(t)
			wepsettings[i] = t
		end,v)
	else
		tab3:createTextbox(i,function(t)
			local num = tonumber(t)
			if num then
				wepsettings[i] = num
			end
		end):update(v)
	end
end

local tab3_b1 = tab3:createButtons()
tab3_b1:createButton("mod weapon",function()
	local tool = char:FindFirstChildWhichIsA("Tool")
	if tool and tool:FindFirstChild("GunStates") then
		local module = require(tool:FindFirstChild("GunStates"))
		for i,v in pairs(wepsettings) do
			module[i] = v
		end
	end
end)
-- weapons
local ignores = {"Lunch","Breakfast","Dinner","nil"}
local tab4 = window:createTab("weapons")
for i,v in pairs(giver:children()) do
	local premium = v:FindFirstChild("premiumType")
	local pickup = v:FindFirstChild("ITEMPICKUP")
	if pickup and table.find(ignores,v.Name) == nil then
		if premium and premium.Value == "Riot Police" and not owns_riotpolice then
			continue
		end
		local buttons = tab4:createButtons()
		buttons:createButton(v.Name,function()
			itemhandler:InvokeServer(pickup)
		end)
	end
end
-- teleports
local tab5 = window:createTab("teleports")
for i,v in pairs(teleports) do
	local tab5_b = tab5:createButtons()
	tab5_b:createButton(i,function()
		char:PivotTo(v)
	end)
end
-- players
local tab6 = window:createTab("players")
local target = tab6:createTextbox("target name",function(t)end)
for i,v in pairs(playersfunc) do
	local tab6_b = tab6:createButtons()
	tab6_b:createButton(i,function()
		local player = getplayer(target:getText())
		for i2,play in pairs(player) do
			v(play)
		end
	end)
end


-- misc
local tab1234 = window:createTab("misc")
local tab1234_b = tab1234:createButtons()
tab1234_b:createButton("collect key cards",function()
	for i,v in pairs(single:children()) do
		local pickup = v:FindFirstChild("ITEMPICKUP")
		if pickup and v.Name:lower():find("key") then
			itemhandler:InvokeServer(pickup)
		end
	end
end)
--
function charsetup()
	if lplr.Team == nil and not fastrespawn and respawned then
		local selectspawn = spawns[math.random(1,#spawns)]
		local offset = CFrame.new()
		if selectspawn.AllowTeamChangeOnTouch then
			offset = CFrame.new(0,0,-5)
		end
		char:PivotTo(selectspawn.CFrame*CFrame.new(0,4,0)*offset)
	end
	if fastrespawned then
		fastrespawned = false
		char:PivotTo(lastpos)
	end
	mainfly = flysetup(isflying)
	if airswim then
		local enums = Enum.HumanoidStateType:GetEnumItems()
		table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
		table.remove(enums, table.find(enums, Enum.HumanoidStateType.Dead))
		for i, v in pairs(enums) do
			hum:SetStateEnabled(v, false)
		end
		hum:ChangeState(Enum.HumanoidStateType.Swimming)
	end
	local humcons = {}
	table.insert(humcons,hum.Died:Connect(function()
		if shutdown then return end
		lastpos = char:GetPivot()
		for i,v in pairs(humcons) do
			v:Disconnect()
		end
		for i,v in pairs(deadfuncs) do
			v()
		end
		humcons = {}
		if fastrespawn then
			fastrespawned = true
			loadchar:InvokeServer(lplr)
		end
	end))
	respawned = false
end
addcon(lplr.CharacterAdded:Connect(function(ch)
	respawned = true
	ch:WaitForChild("Humanoid")
	char = ch
	hum = ch:WaitForChild("Humanoid")
	charsetup()
end))
window.onRemoved:Connect(function()
	if airswim then
		local enums = Enum.HumanoidStateType:GetEnumItems()
		table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
		table.remove(enums, table.find(enums, Enum.HumanoidStateType.Dead))
		for i, v in pairs(enums) do
			hum:SetStateEnabled(v, true)
		end
		workspace.Gravity = lastgrav
	end
	isflying = false
	noclipping = false
	airswim = false
	iamspeed = false
	shutdown = true
	for i,v in pairs(cons) do
		v:Disconnect()
	end
	cons = {}
	fastrespawn = false
	char = nil
	hum = nil
end)

if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then
	char = lplr.Character
	hum = char:WaitForChild("Humanoid")
	charsetup()
end
addcon(game:GetService("RunService").Stepped:Connect(function()
	if char and hum then
		if noclipping then
			for i,v in pairs(char:GetDescendants()) do
				if v:IsA("BasePart") and v.CanCollide == true then
					v.CanCollide = false
				end
			end
		end
		if iamspeed then
			hum.WalkSpeed = runspeed
		end
	end
end))
addcon(game:GetService("RunService").Heartbeat:Connect(function()
	if char and hum then
		if airswim then
			hum.RootPart.Velocity = ((hum.MoveDirection ~= Vector3.new() or uis:IsKeyDown(Enum.KeyCode.Space)) and hum.RootPart.Velocity or Vector3.new())
		end
	end
end))
