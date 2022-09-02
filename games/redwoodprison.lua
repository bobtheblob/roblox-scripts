--
getgenv_list = getgenv and getgenv() or {}
getgenv = getgenv or function()
	return getgenv_list
end
-- \\ from https://pastebin.com/raw/yMbms5qR
sv=function(a,b)
	game:GetService("Workspace").resources.RemoteFunction:InvokeServer("setDataValue",a,b)
end
gv=function(a)
	return game:GetService("Workspace").resources.RemoteFunction:InvokeServer("getDataValue",a)
end
-- //
-- upsilon library
calledFromClient = function()
	if game:GetService("Players").LocalPlayer == nil then
		return false
	end
	return true
end
getgenv()._upsilonLibrary = getgenv()._upsilonLibrary or {}
local v1 = getgenv()._upsilonLibrary
if #v1 <= 0 then
	local v2 = false
	v1.customChat = v2
	local v3 = workspace
	v2 = v3.resources
	v1.resources = v2
	v3 = v1.resources
	v2 = v3.RemoteEvent
	v1.revent = v2
	v3 = v1.resources
	v2 = v3.RemoteFunction
	v1.rfunc = v2
	v2 = {}
	v3 = 1314618
	v2[1] = v3
	v2[2] = 1325719
	v2[3] = 6409172
	v1.admins = v2
	v2 = v1.revent
	v3 = v1.rfunc
	v1.FireServer = function(p1, ...)
		v2:FireServer(p1, ...)
	end--
getgenv_list = getgenv and getgenv() or {}
getgenv = getgenv or function()
	return getgenv_list
end
-- \\ from https://pastebin.com/raw/yMbms5qR
sv=function(a,b)
	game:GetService("Workspace").resources.RemoteFunction:InvokeServer("setDataValue",a,b)
end
gv=function(a)
	return game:GetService("Workspace").resources.RemoteFunction:InvokeServer("getDataValue",a)
end
-- //
-- upsilon library
calledFromClient = function()
	if game:GetService("Players").LocalPlayer == nil then
		return false
	end
	return true
end
getgenv()._upsilonLibrary = getgenv()._upsilonLibrary or {}
local v1 = getgenv()._upsilonLibrary
if #v1 <= 0 then
	local v2 = false
	v1.customChat = v2
	local v3 = workspace
	v2 = v3.resources
	v1.resources = v2
	v3 = v1.resources
	v2 = v3.RemoteEvent
	v1.revent = v2
	v3 = v1.resources
	v2 = v3.RemoteFunction
	v1.rfunc = v2
	v2 = {}
	v3 = 1314618
	v2[1] = v3
	v2[2] = 1325719
	v2[3] = 6409172
	v1.admins = v2
	v2 = v1.revent
	v3 = v1.rfunc
	v1.FireServer = function(p1, ...)
		v2:FireServer(p1, ...)
	end
	v1.InvokeServer = function(p2, ...)
		return v3:InvokeServer(p2, ...)
	end
	v1.FireClient = function(p3, p4, ...)
		v2:FireClient(p3, p4, ...)
	end
	v1.FireAllClients = function(p5, ...)
		local v23 = calledFromClient()
		if not v23 then
			v23 = v2
			v23:FireServer("FireAllClients", p5, ...)
			return 
		end
		v2:FireAllClients(p5, ...)
	end
	v1.FireOtherClients = function(p6, ...)
		v2:FireServer("FireOtherClients", p6, ...)
	end
	v1.InvokeClient = function(p7, p8, ...)
		return v3:InvokeClient(p7, p8, ...)
	end
	local function getInfo_1(p9)
		return v3:InvokeServer("getInfo", p9)
	end
	v1.getInfo = getInfo_1
	getInfo_1 = {}
	v1.data = getInfo_1
	getInfo_1 = v1.data
	getInfo_1.getValue = function(p10)
		return v3:InvokeServer("getDataValue", p10)
	end
	getInfo_1.setValue = function(p11, p12)
		return v3:InvokeServer("setDataValue", p11, p12)
	end
	getInfo_1.incValue = function(p13, p14)
		return v3:InvokeServer("incDataValue", p13, p14)
	end
	getInfo_1.setValueWithIndex = function(p15, p16, p17)
		return v3:InvokeServer("setValueWithIndex", p15, p16, p17)
	end
end
-- some libraries
getgenv().ease = getgenv().ease or {}
getgenv().ease.outSine = function(p74, p75, p76, p77)
	return p76 - p75 * math.sin(p74 / p77 * math.pi / 2) + p75
end
--

-- functions
getgenv().lasers = getgenv().lasers or {}
drawLaser = function(p84, p85, p86)
	local v1991 = (p84 - p85).magnitude
	local v1992 = Instance.new("Part")
	v1992.Anchored = true
	v1992.CanCollide = false
	v1992.Parent = workspace.ignore
	v1992.Size = Vector3.new(0.2, 0.2, v1991)
	local v2008 = CFrame.new(p84, p85) * CFrame.new(0, 0, -v1991 / 2)
	local v2014 = CFrame.Angles(0, 0, 2 * math.pi * math.random())
	local v2027 = v2008 * v2014
	v1992.CFrame = v2027
	if p86 then
		v2027 = pairs
		v2008 = p86
		local v2015, v2016, v2014 = v2027(v2008)
		for v2018, v2017 in v2015, v2016, v2014 do
			v1992[v2018] = v2017
		end
	end
	table.insert(getgenv().lasers,{
		model = v1992,
		transparency = 0,
	})
	return v1992
end
--
function httprequire(link)
	return loadstring(game:HttpGet(link))()
end
local scripts = {
	['Dominus Astra'] = 'https://raw.githubusercontent.com/bobtheblob/sads/main/scripts/redwoodprison/dominusastra.lua',
	['Agent Agony'] = 'https://raw.githubusercontent.com/bobtheblob/sads/main/scripts/redwoodprison/agentagony.lua',
	['Studio Dummy V3'] = 'https://raw.githubusercontent.com/bobtheblob/sads/main/scripts/redwoodprison/sdv3.lua'
}
local lib = httprequire("https://pastebin.com/raw/JUFhCJLQ")
local cam = workspace.CurrentCamera

local mps = game:GetService("MarketplaceService")
local teams = game:GetService("Teams")
local startergui = game:GetService("StarterGui")
local plrs = game:GetService("Players")
local uis = game:GetService("UserInputService")
local rand = Random.new()

local lplr = plrs.LocalPlayer
local pgui = lplr.PlayerGui
local gui = pgui.GUI
local choiceFrame = gui.choiceFrame
local choiceMsg = choiceFrame.msg
local mouse = lplr:GetMouse()

local window = lib:newWindow("redwood prison")
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
function DrawReplicatedLaser(from,to,props)
	drawLaser(from,to,props)
	getgenv()._upsilonLibrary.FireOtherClients("drawLaser", from, to, props)
end
function Tase(player)
	local pchar = player.Character
	if pchar == nil then return end
	local hum = pchar:FindFirstChildOfClass'Humanoid'
	local from = hum.RootPart.CFrame
	local to = hum.RootPart.CFrame*CFrame.new(0,320,0)
	getgenv()._upsilonLibrary.FireServer("taseNew", player, from.p, to.Position)
end
function Damage(player)
	local pchar = player.Character
	if pchar == nil then return end
	local hum = pchar:FindFirstChildOfClass'Humanoid'
	local from = hum.RootPart.CFrame
	local to = hum.RootPart.CFrame*CFrame.new(0,320,0)
	getgenv()._upsilonLibrary.FireServer("dealBulletDamage", hum, "M98B", from.p, to.Position)
end
function MeleeDamage(player,dmg)
	local pchar = player.Character
	if pchar == nil then return end
	local hum = pchar:FindFirstChildOfClass'Humanoid'
	getgenv()._upsilonLibrary.FireServer("dealMeleeDamage", hum, dmg or 100)
end
function ReloadChar()
	getgenv()._upsilonLibrary.FireServer("reloadMe")
end
function ReloadCharYield()
	getgenv()._upsilonLibrary.FireServer("reloadMe")
	local lastchar = char
	repeat
		task.wait()
	until lastchar ~= char
end
function GetItem(m)
	getgenv()._upsilonLibrary.InvokeServer("giveItemApproved",m)
end
--
getgenv().FEEffects = getgenv().FEEffects or {}
getgenv().FEEffects.Lightning = function(data)
	local length = data.length or 7
	local startpos = data.startpos or Vector3.new(0,100,0)
	local endpos = data.endpos or Vector3.new()
	local thickness = data.thickness or 1
	local mat = data.material or "Neon"
	local color = data.Color or Color3.new(0,1,1)
	local shakeness = data.shakeness or {{-1,1},{-1,1},{-1,1}}
	local ldelay = data.ldelay or 0
	local instant = data.instant or true
	local points = {}
	for i = 0,length do
		local offset = Vector3.new(rand:NextNumber(unpack(shakeness[1])),rand:NextNumber(unpack(shakeness[2])),rand:NextNumber(unpack(shakeness[3])))
		local pos = startpos + (endpos-startpos).Unit * i * (endpos-startpos).Magnitude / length
		if i == 0 or i == length then
			offset = Vector3.new()
		end
		table.insert(points,pos+offset)
	end
	for i,v in pairs(points) do
		if points[i+1] then
			local diff = points[i]-points[i+1]
			local diff2 = points[i]+points[i+1]
			local dist = diff.Magnitude
			DrawReplicatedLaser(startpos,endpos,{
				Size = Vector3.new(thickness,thickness,dist),
				Material = mat,
				CFrame = CFrame.new(diff2/2,points[i+1]),
				Color = color,
				CanCollide = false
			})
			if not instant then
				task.wait(ldelay)
			end
		end
	end
end
getgenv().FEEffects.Sphere = function(data)
	local startpos = data.startpos or Vector3.new()
	local size = data.size or Vector3.new(6,6,6)
	local mat = data.material or "Neon"
	local color = data.Color or Color3.new(0,1,1)
	local points = {}
	DrawReplicatedLaser(startpos,Vector3.new(0,100,0),{
		Size = size,
		Material = mat,
		CFrame = CFrame.new(startpos),
		Color = color,
		Shape = Enum.PartType.Ball,
		CanCollide = false
	})
end
getgenv().FEEffects.Part = function(data)
	local startpos = data.startpos or Vector3.new()
	local size = data.size or Vector3.new(6,6,6)
	local mat = data.material or "Neon"
	local color = data.Color or Color3.new(0,1,1)
	local points = {}
	DrawReplicatedLaser(startpos,Vector3.new(0,100,0),{
		Size = size,
		Material = mat,
		CFrame = CFrame.new(startpos),
		Color = color,
		CanCollide = false
	})
end
getgenv().FEEffects.Cylinder = function(data)
	local startpos = data.startpos or Vector3.new()
	local size = data.size or Vector3.new(6,6,6)
	local mat = data.material or "Neon"
	local color = data.Color or Color3.new(0,1,1)
	local points = {}
	DrawReplicatedLaser(startpos,Vector3.new(0,100,0),{
		Size = size,
		Material = mat,
		CFrame = CFrame.new(startpos),
		Color = color,
		Shape = Enum.PartType.Cylinder,
		CanCollide = false
	})
end
--
function addcon(event)
	table.insert(cons,event)
end
--
function ffconac(par,name,class)
	for i,v in pairs(par:children()) do
		if v.Name == name and v:IsA(class) then
			return v
		end
	end
end
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
	ReloadCharYield()
	repeat task.wait() until char ~= lastchar
	char:PivotTo(pos)
	getgenv()._upsilonLibrary.FireServer("becomeHostile")
	wait(1)
	hum.Name = "1"
	local clone = hum:Clone()
	clone.Name = "Humanoid"
	clone.Parent = char
	hum:Destroy()
	cam.CameraSubject = clone
	task.wait()
	local tool = lplr.Backpack:WaitForChild("Punch")
	tool.Parent = char
	local timer = 0
	clone.RootPart.Anchored = true
	repeat
		task.wait()
		plr:PivotTo(tool:WaitForChild("Handle").CFrame)
		timer = timer + 1
	until tool.Parent == plr or timer > 100
	task.wait(.2)
	ReloadCharYield()
	char:PivotTo(storedpos)
end
--
local teleports = {
	secret1 = CFrame.new(-903, -17, -108),
	secret2 = CFrame.new(70, 5, 63),
	crimbase = CFrame.new(-617, -24, -328),
	crimbase_atv = CFrame.new(-597, -24, -190),
	cell = CFrame.new(-6, 5, 31),
	cafeteria = CFrame.new(0, 5, -117),
	armory = CFrame.new(119, 5, -2),
	guardroom = CFrame.new(70, 5, -38),
	guardroom_windows = CFrame.new(45, 5, -47),
	controlroom = CFrame.new(59, 5, 0),
	mainhall = CFrame.new(110, 5, -113),
	fronthall = CFrame.new(132, 5, -230),
	prison_atv = CFrame.new(14, 6, -245),
	courtyard = CFrame.new(242, 5, -81),
	helipad = CFrame.new(264, 5, 53),
	gatecontrol_2nd = CFrame.new(116, 27, -331),
	gatecontrol_1st = CFrame.new(180, 6, -420),
	gate_1st = CFrame.new(148, 5, -420),
	gate_2nd = CFrame.new(149, 5, -322),
	camp = CFrame.new(273, 5, -280),
	kitchen = CFrame.new(-54, 5, -128),
	crateroom = CFrame.new(-50, 5, -40),
	behindkitchen = CFrame.new(-68, 5, -13),
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
	smite = function(plr)
		if plr.Character == nil then return end
		local lastpos = char:GetPivot()
		local hum = plr.Character:FindFirstChildOfClass("Humanoid")
		char:PivotTo(hum.RootPart.CFrame*CFrame.new(0,0,2))
		local opos = plr.Character:GetPivot()
		wait(.2)
		getgenv().FEEffects.Lightning({
			startpos = (hum.RootPart.CFrame*CFrame.new(0,80,0)).Position,
			endpos = (hum.RootPart.CFrame).Position,
			length = 12,
			instant = true
		})
		getgenv().FEEffects.Sphere({
			startpos = (hum.RootPart.CFrame).Position,
			size = Vector3.new(6,6,6),
			color = Color3.new(0,1,1)
		})
		MeleeDamage(plr,1000)
		char:PivotTo(lastpos)
	end,
}
-- teams
local tab = window:createTab("teams")
local tab_b1 = tab:createButtons()
tab_b1:createButton("Change to Choosing",function()
	fastrespawned = true
	lastpos = char:GetPivot()
	ReloadChar()
	getgenv()._upsilonLibrary.FireServer("choiceResult","returnToMenu",true)
	wait(.5)
	lplr.TeamColor = BrickColor.new("Bronze")
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
-- scripts
local tab52 = window:createTab("fe scripts")
local tab52_b = tab52:createButtons()
local c = 0
for i,v in pairs(scripts) do
	c = c + 1
	if c > 3 then
		tab52_b = tab52:createButtons()
	end	
	tab52_b:createButton(i,function()
		httprequire(v)
	end)
end
-- misc
local tab51 = window:createTab("misc")
local tab51_b = tab51:createButtons()
tab51_b:createButton("Get all gamepasses",function()
	sv("hasPilot",true)
	sv("hasSwat",true)
	sv("hasMerc",true)
	sv("hasSpecOps",true)
	sv("hasATV",true)
end)
local notify = tab51:createTextbox("notify text",function(t)end)
notify:update("Hi")
tab51_b = tab51:createButtons()
tab51_b:createButton("Notify all",function()
	choiceMsg.Text = notify:getText()
	choiceFrame.Visible = true
	getgenv()._upsilonLibrary.FireOtherClients("displayChoice", "CustomNotification", notify:getText())
end)
--
function charsetup()
	if lplr.TeamColor == BrickColor.new("White") and not fastrespawn and respawned then
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
			ReloadChar()
		end
	end))
	respawned = false
	gui = pgui.GUI
	choiceFrame = gui.choiceFrame
	choiceMsg = choiceFrame.msg
	for i,v in pairs(choiceFrame:children()) do
		if v:IsA("TextButton") then
			v.MouseButton1Down:Connect(function()
				choiceFrame.Visible = false
			end)
		end
	end
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
if not getgenv().rwp_init then
	getgenv().rwp_init = true
	getgenv().rwp_hb_cons = {}
	getgenv().rwp_hb_cons[1] = game:GetService("RunService").Heartbeat:Connect(function(dt)
		for i,v in pairs(getgenv().lasers) do
			v.transparency = v.transparency + 5*dt
			if v.transparency >= 1 then
				v.model:Destroy()
				getgenv().lasers[i] = nil
				continue
			else
				v.model.Transparency = v.transparency
			end
		end
	end)
end
	v1.InvokeServer = function(p2, ...)
		return v3:InvokeServer(p2, ...)
	end
	v1.FireClient = function(p3, p4, ...)
		v2:FireClient(p3, p4, ...)
	end
	v1.FireAllClients = function(p5, ...)
		local v23 = calledFromClient()
		if not v23 then
			v23 = v2
			v23:FireServer("FireAllClients", p5, ...)
			return 
		end
		v2:FireAllClients(p5, ...)
	end
	v1.FireOtherClients = function(p6, ...)
		v2:FireServer("FireOtherClients", p6, ...)
	end
	v1.InvokeClient = function(p7, p8, ...)
		return v3:InvokeClient(p7, p8, ...)
	end
	local function getInfo_1(p9)
		return v3:InvokeServer("getInfo", p9)
	end
	v1.getInfo = getInfo_1
	getInfo_1 = {}
	v1.data = getInfo_1
	getInfo_1 = v1.data
	getInfo_1.getValue = function(p10)
		return v3:InvokeServer("getDataValue", p10)
	end
	getInfo_1.setValue = function(p11, p12)
		return v3:InvokeServer("setDataValue", p11, p12)
	end
	getInfo_1.incValue = function(p13, p14)
		return v3:InvokeServer("incDataValue", p13, p14)
	end
	getInfo_1.setValueWithIndex = function(p15, p16, p17)
		return v3:InvokeServer("setValueWithIndex", p15, p16, p17)
	end
end
-- some libraries
getgenv().ease = getgenv().ease or {}
getgenv().ease.outSine = function(p74, p75, p76, p77)
	return p76 - p75 * math.sin(p74 / p77 * math.pi / 2) + p75
end
--

-- functions
getgenv().lasers = getgenv().lasers or {}
drawLaser = function(p84, p85, p86)
	local v1991 = (p84 - p85).magnitude
	local v1992 = Instance.new("Part")
	v1992.Anchored = true
	v1992.CanCollide = false
	v1992.Parent = workspace.ignore
	v1992.Size = Vector3.new(0.2, 0.2, v1991)
	local v2008 = CFrame.new(p84, p85) * CFrame.new(0, 0, -v1991 / 2)
	local v2014 = CFrame.Angles(0, 0, 2 * math.pi * math.random())
	local v2027 = v2008 * v2014
	v1992.CFrame = v2027
	if p86 then
		v2027 = pairs
		v2008 = p86
		local v2015, v2016, v2014 = v2027(v2008)
		for v2018, v2017 in v2015, v2016, v2014 do
			v1992[v2018] = v2017
		end
	end
	table.insert(getgenv().lasers,{
		model = v1992,
		transparency = 0,
	})
	return v1992
end
--
function httprequire(link)
	return loadstring(game:HttpGet(link))()
end
local scripts = {
	['Dominus Astra'] = 'https://pastebin.com/raw/qWaqThgh',
	['Agent Agony'] = 'https://pastebin.com/raw/AJVCACbN'
}
local lib = httprequire("https://pastebin.com/raw/JUFhCJLQ")
local cam = workspace.CurrentCamera

local mps = game:GetService("MarketplaceService")
local teams = game:GetService("Teams")
local startergui = game:GetService("StarterGui")
local plrs = game:GetService("Players")
local uis = game:GetService("UserInputService")
local rand = Random.new()

local lplr = plrs.LocalPlayer
local pgui = lplr.PlayerGui
local gui = pgui.GUI
local choiceFrame = gui.choiceFrame
local choiceMsg = choiceFrame.msg
local mouse = lplr:GetMouse()

local window = lib:newWindow("redwood prison")
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
function DrawReplicatedLaser(from,to,props)
	drawLaser(from,to,props)
	getgenv()._upsilonLibrary.FireOtherClients("drawLaser", from, to, props)
end
function Tase(player)
	local pchar = player.Character
	if pchar == nil then return end
	local hum = pchar:FindFirstChildOfClass'Humanoid'
	local from = hum.RootPart.CFrame
	local to = hum.RootPart.CFrame*CFrame.new(0,320,0)
	getgenv()._upsilonLibrary.FireServer("taseNew", player, from.p, to.Position)
end
function Damage(player)
	local pchar = player.Character
	if pchar == nil then return end
	local hum = pchar:FindFirstChildOfClass'Humanoid'
	local from = hum.RootPart.CFrame
	local to = hum.RootPart.CFrame*CFrame.new(0,320,0)
	getgenv()._upsilonLibrary.FireServer("dealBulletDamage", hum, "M98B", from.p, to.Position)
end
function MeleeDamage(player,dmg)
	local pchar = player.Character
	if pchar == nil then return end
	local hum = pchar:FindFirstChildOfClass'Humanoid'
	getgenv()._upsilonLibrary.FireServer("dealMeleeDamage", hum, dmg or 100)
end
function ReloadChar()
	getgenv()._upsilonLibrary.FireServer("reloadMe")
end
function ReloadCharYield()
	getgenv()._upsilonLibrary.FireServer("reloadMe")
	local lastchar = char
	repeat
		task.wait()
	until lastchar ~= char
end
function GetItem(m)
	getgenv()._upsilonLibrary.InvokeServer("giveItemApproved",m)
end
--
getgenv().FEEffects = getgenv().FEEffects or {}
getgenv().FEEffects.Lightning = function(data)
	local length = data.length or 7
	local startpos = data.startpos or Vector3.new(0,100,0)
	local endpos = data.endpos or Vector3.new()
	local thickness = data.thickness or 1
	local mat = data.material or "Neon"
	local color = data.Color or Color3.new(0,1,1)
	local shakeness = data.shakeness or {{-1,1},{-1,1},{-1,1}}
	local ldelay = data.ldelay or 0
	local instant = data.instant or true
	local points = {}
	for i = 0,length do
		local offset = Vector3.new(rand:NextNumber(unpack(shakeness[1])),rand:NextNumber(unpack(shakeness[2])),rand:NextNumber(unpack(shakeness[3])))
		local pos = startpos + (endpos-startpos).Unit * i * (endpos-startpos).Magnitude / length
		if i == 0 or i == length then
			offset = Vector3.new()
		end
		table.insert(points,pos+offset)
	end
	for i,v in pairs(points) do
		if points[i+1] then
			local diff = points[i]-points[i+1]
			local diff2 = points[i]+points[i+1]
			local dist = diff.Magnitude
			DrawReplicatedLaser(startpos,endpos,{
				Size = Vector3.new(thickness,thickness,dist),
				Material = mat,
				CFrame = CFrame.new(diff2/2,points[i+1]),
				Color = color,
				CanCollide = false
			})
			if not instant then
				task.wait(ldelay)
			end
		end
	end
end
getgenv().FEEffects.Sphere = function(data)
	local startpos = data.startpos or Vector3.new()
	local size = data.size or Vector3.new(6,6,6)
	local mat = data.material or "Neon"
	local color = data.Color or Color3.new(0,1,1)
	local points = {}
	DrawReplicatedLaser(startpos,Vector3.new(0,100,0),{
		Size = size,
		Material = mat,
		CFrame = CFrame.new(startpos),
		Color = color,
		Shape = Enum.PartType.Ball,
		CanCollide = false
	})
end
getgenv().FEEffects.Part = function(data)
	local startpos = data.startpos or Vector3.new()
	local size = data.size or Vector3.new(6,6,6)
	local mat = data.material or "Neon"
	local color = data.Color or Color3.new(0,1,1)
	local points = {}
	DrawReplicatedLaser(startpos,Vector3.new(0,100,0),{
		Size = size,
		Material = mat,
		CFrame = CFrame.new(startpos),
		Color = color,
		CanCollide = false
	})
end
getgenv().FEEffects.Cylinder = function(data)
	local startpos = data.startpos or Vector3.new()
	local size = data.size or Vector3.new(6,6,6)
	local mat = data.material or "Neon"
	local color = data.Color or Color3.new(0,1,1)
	local points = {}
	DrawReplicatedLaser(startpos,Vector3.new(0,100,0),{
		Size = size,
		Material = mat,
		CFrame = CFrame.new(startpos),
		Color = color,
		Shape = Enum.PartType.Cylinder,
		CanCollide = false
	})
end
--
function addcon(event)
	table.insert(cons,event)
end
--
function ffconac(par,name,class)
	for i,v in pairs(par:children()) do
		if v.Name == name and v:IsA(class) then
			return v
		end
	end
end
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
	ReloadCharYield()
	repeat task.wait() until char ~= lastchar
	char:PivotTo(pos)
	getgenv()._upsilonLibrary.FireServer("becomeHostile")
	wait(1)
	hum.Name = "1"
	local clone = hum:Clone()
	clone.Name = "Humanoid"
	clone.Parent = char
	hum:Destroy()
	cam.CameraSubject = clone
	task.wait()
	local tool = lplr.Backpack:WaitForChild("Punch")
	tool.Parent = char
	local timer = 0
	clone.RootPart.Anchored = true
	repeat
		task.wait()
		plr:PivotTo(tool:WaitForChild("Handle").CFrame)
		timer = timer + 1
	until tool.Parent == plr or timer > 100
	task.wait(.2)
	ReloadCharYield()
	char:PivotTo(storedpos)
end
--
local teleports = {
	secret1 = CFrame.new(-903, -17, -108),
	secret2 = CFrame.new(70, 5, 63),
	crimbase = CFrame.new(-617, -24, -328),
	crimbase_atv = CFrame.new(-597, -24, -190),
	cell = CFrame.new(-6, 5, 31),
	cafeteria = CFrame.new(0, 5, -117),
	armory = CFrame.new(119, 5, -2),
	guardroom = CFrame.new(70, 5, -38),
	guardroom_windows = CFrame.new(45, 5, -47),
	controlroom = CFrame.new(59, 5, 0),
	mainhall = CFrame.new(110, 5, -113),
	fronthall = CFrame.new(132, 5, -230),
	prison_atv = CFrame.new(14, 6, -245),
	courtyard = CFrame.new(242, 5, -81),
	helipad = CFrame.new(264, 5, 53),
	gatecontrol_2nd = CFrame.new(116, 27, -331),
	gatecontrol_1st = CFrame.new(180, 6, -420),
	gate_1st = CFrame.new(148, 5, -420),
	gate_2nd = CFrame.new(149, 5, -322),
	camp = CFrame.new(273, 5, -280),
	kitchen = CFrame.new(-54, 5, -128),
	crateroom = CFrame.new(-50, 5, -40),
	behindkitchen = CFrame.new(-68, 5, -13),
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
	smite = function(plr)
		if plr.Character == nil then return end
		local lastpos = char:GetPivot()
		local hum = plr.Character:FindFirstChildOfClass("Humanoid")
		char:PivotTo(hum.RootPart.CFrame*CFrame.new(0,0,2))
		local opos = plr.Character:GetPivot()
		wait(.2)
		getgenv().FEEffects.Lightning({
			startpos = (hum.RootPart.CFrame*CFrame.new(0,80,0)).Position,
			endpos = (hum.RootPart.CFrame).Position,
			length = 12,
			instant = true
		})
		getgenv().FEEffects.Sphere({
			startpos = (hum.RootPart.CFrame).Position,
			size = Vector3.new(6,6,6),
			color = Color3.new(0,1,1)
		})
		MeleeDamage(plr,1000)
		char:PivotTo(lastpos)
	end,
}
-- teams
local tab = window:createTab("teams")
local tab_b1 = tab:createButtons()
tab_b1:createButton("Change to Choosing",function()
	fastrespawned = true
	lastpos = char:GetPivot()
	ReloadChar()
	getgenv()._upsilonLibrary.FireServer("choiceResult","returnToMenu",true)
	wait(.5)
	lplr.TeamColor = BrickColor.new("Bronze")
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
-- scripts
local tab52 = window:createTab("scripts")
local tab52_b = tab52:createButtons()
local c = 0
for i,v in pairs(scripts) do
	c = c + 1
	if c > 3 then
		tab52_b = tab52:createButtons()
	end	
	tab52_b:createButton(i,function()
		httprequire(v)
	end)
end
-- misc
local tab51 = window:createTab("misc")
local tab51_b = tab51:createButtons()
tab51_b:createButton("Get all gamepasses",function()
	sv("hasPilot",true)
	sv("hasSwat",true)
	sv("hasMerc",true)
	sv("hasSpecOps",true)
	sv("hasATV",true)
end)
local notify = tab51:createTextbox("notify text",function(t)end)
notify:update("Hi")
tab51_b = tab51:createButtons()
tab51_b:createButton("Notify all",function()
	choiceMsg.Text = notify:getText()
	choiceFrame.Visible = true
	getgenv()._upsilonLibrary.FireOtherClients("displayChoice", "CustomNotification", notify:getText())
end)
--
function charsetup()
	if lplr.TeamColor == BrickColor.new("White") and not fastrespawn and respawned then
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
			ReloadChar()
		end
	end))
	respawned = false
	gui = pgui.GUI
	choiceFrame = gui.choiceFrame
	choiceMsg = choiceFrame.msg
	for i,v in pairs(choiceFrame:children()) do
		if v:IsA("TextButton") then
			v.MouseButton1Down:Connect(function()
				choiceFrame.Visible = false
			end)
		end
	end
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
if not getgenv().rwp_init then
	getgenv().rwp_init = true
	getgenv().rwp_hb_cons = {}
	getgenv().rwp_hb_cons[1] = game:GetService("RunService").Heartbeat:Connect(function(dt)
		for i,v in pairs(getgenv().lasers) do
			v.transparency = v.transparency + 5*dt
			if v.transparency >= 1 then
				v.model:Destroy()
				getgenv().lasers[i] = nil
				continue
			else
				v.model.Transparency = v.transparency
			end
		end
	end)
end
