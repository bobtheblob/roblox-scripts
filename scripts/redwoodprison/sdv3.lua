if getgenv().YO then error'You are currently in Fake Character mode' return end
getgenv().YO = true
local descons = {}
--
local tinsert = table.insert
local tremove = table.remove
local tfind = table.find

local v3 = Vector3.new
local cfn = CFrame.new
local c3 = Color3.new
local bkc = BrickColor.new
--
local newraycast = workspace.Raycast
--
getgenv_list = getgenv and getgenv() or {}
getgenv = getgenv or function()
	return getgenv_list
end
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
--
local partexclusion = {}
-- functions
getgenv().lasers = getgenv().lasers or {}
local notready = {}
drawLaser = function(p84, p85, p86)
	local v1991 = (p84 - p85).magnitude
	local v1992 = Instance.new("Part")
	local i = #notready+1
	v1992.Anchored = true
	v1992.CanCollide = false
	notready[i] = v1992
	tinsert(partexclusion,v1992)
	v1992.Parent = workspace.ignore
	v1992.Size = v3(0.2, 0.2, v1991)
	notready[i] = nil
	local v2008 = cfn(p84, p85) * cfn(0, 0, -v1991 / 2)
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
	tinsert(getgenv().lasers,{
		model = v1992,
		transparency = 0,
	})
	return v1992
end
--

local mps = game:GetService("MarketplaceService")
local teams = game:GetService("Teams")
local startergui = game:GetService("StarterGui")
local plrs = game:GetService("Players")
local uis = game:GetService("UserInputService")
local rand = Random.new()

local lplr = plrs.LocalPlayer
local pgui = lplr.PlayerGui
local char = lplr.Character
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
	local to = hum.RootPart.CFrame*cfn(0,320,0)
	getgenv()._upsilonLibrary.FireServer("taseNew", player, from.p, to.Position)
end
function Damage(player)
	local pchar = player.Character
	if pchar == nil then return end
	local hum = pchar:FindFirstChildOfClass'Humanoid'
	local from = hum.RootPart.CFrame
	local to = hum.RootPart.CFrame*cfn(0,320,0)
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
getgenv().FEEffects = getgenv().FEEffects or {}
getgenv().FEEffects.Lightning = function(data)
	local length = data.length or 7
	local startpos = data.startpos or v3(0,100,0)
	local endpos = data.endpos or v3()
	local thickness = data.thickness or 1
	local mat = data.material or "Neon"
	local color = data.Color or c3(0,1,1)
	local shakeness = data.shakeness or {{-1,1},{-1,1},{-1,1}}
	local ldelay = data.ldelay or 0
	local instant = data.instant or true
	local points = {}
	for i = 0,length do
		local offset = v3(rand:NextNumber(unpack(shakeness[1])),rand:NextNumber(unpack(shakeness[2])),rand:NextNumber(unpack(shakeness[3])))
		local pos = startpos + (endpos-startpos).Unit * i * (endpos-startpos).Magnitude / length
		if i == 0 or i == length then
			offset = v3()
		end
		tinsert(points,pos+offset)
	end
	for i,v in pairs(points) do
		if points[i+1] then
			local diff = points[i]-points[i+1]
			local diff2 = points[i]+points[i+1]
			local dist = diff.Magnitude
			DrawReplicatedLaser(startpos,endpos,{
				Size = v3(thickness,thickness,dist),
				Material = mat,
				CFrame = cfn(diff2/2,points[i+1]),
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
	local startpos = data.startpos or v3()
	local size = data.size or v3(6,6,6)
	local mat = data.material or "Neon"
	local color = data.Color or c3(0,1,1)
	local points = {}
	local trans = data.trans or 0
	DrawReplicatedLaser(v3(0,1,0),v3(0,100,0),{
		Size = size,
		Material = mat,
		CFrame = startpos,
		Color = color,
		Transparency = trans,
		Shape = Enum.PartType.Ball,
		CanCollide = false
	})
end
getgenv().FEEffects.Part = function(data)
	local startpos = data.startpos or v3()
	local size = data.size or v3(6,6,6)
	local mat = data.material or "Neon"
	local color = data.Color or c3(0,1,1)
	local points = {}
	local trans = data.trans or 0
	DrawReplicatedLaser(v3(0,1,0),v3(0,100,0),{
		Size = size,
		Material = mat,
		CFrame = startpos,
		Color = color,
		Transparency = trans,
		CanCollide = false
	})
end
getgenv().FEEffects.Cylinder = function(data)
	local startpos = data.startpos or v3()
	local size = data.size or v3(6,6,6)
	local mat = data.material or "Neon"
	local color = data.Color or c3(0,1,1)
	local trans = data.trans or 0
	local points = {}
	DrawReplicatedLaser(v3(0,1,0),v3(0,100,0),{
		Size = size,
		Material = mat,
		CFrame = startpos,
		Color = color,
		Shape = Enum.PartType.Cylinder,
		Transparency = trans,
		CanCollide = false
	})
end
local fakechar = game:GetService("Players"):CreateHumanoidModelFromDescription(Instance.new("HumanoidDescription"),"R6")
local lastpos = char:GetPivot()
fakechar:PivotTo(lastpos)
fakechar.Parent = workspace
char:PivotTo(cfn(0,100,0))
wait()
local con
local hum = fakechar:FindFirstChildWhichIsA("Humanoid")
local charhum = char:FindFirstChildWhichIsA("Humanoid")
local lasttick = tick()
local modelrendertick = tick()
local renderModels = {}
local renderPart = getgenv().FEEffects.Part
local renderSphere = getgenv().FEEffects.Sphere
local renderCylinder = getgenv().FEEffects.Cylinder
--
renderModels.shotgun = function(pos,col)
	renderPart({
		size = Vector3.new(0.30000001192092896, 0.8999999761581421, 0.4000000059604645),
		startpos = pos*CFrame.new(-2.75000191, -0.0750000477, -1.90734863e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.4999999403953552, 0.7999999523162842, 0.4000000059604645),
		startpos = pos*CFrame.new(-2.35000229, -0.0250000358, -1.90734863e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.20000000298023224, 0.5999999046325684, 0.4000000059604645),
		startpos = pos*CFrame.new(-2.00000191, 0.0749999881, -1.90734863e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.3999999761581421, 0.7499998807907104, 0.4000000059604645),
		startpos = pos*CFrame.new(-1.70000172, -0.0500000715, -1.90734863e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.10000000149011612, 0.5999999046325684, 0.4000000059604645),
		startpos = pos*CFrame.new(-1.45000172, 0.0749999881, -1.90734863e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.30000001192092896, 0.49999988079071045, 0.4000000059604645),
		startpos = pos*CFrame.new(-1.25000095, 0.325000048, -1.90734863e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(1.3499999046325684, 0.5499998927116394, 0.4000000059604645),
		startpos = pos*CFrame.new(-0.424999237, 0.350000083, -1.90734863e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(3.1500000953674316, 0.20000000298023224, 0.20000000298023224),
		startpos = pos*CFrame.new(1.82500172, 0.475000679, 0, 1, 0, 0, 0, 0.707106709, 0.707106829, 0, -0.707106829, 0.707106709),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(2.0999999046325684, 0.1899999976158142, 0.1899999976158142),
		startpos = pos*CFrame.new(1.3000021, 0.250000834, 0, 1, 0, 0, 0, 0.707106709, 0.707106829, 0, -0.707106829, 0.707106709),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(1.100000023841858, 0.34999990463256836, 0.3499999940395355),
		startpos = pos*CFrame.new(1.50000191, 0.249999881, 1.90734863e-06, 1, 0, 0, 0, 0.707106769, 0.707106769, 0, -0.707106769, 0.707106769),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.0499999038875103, 0.24999988079071045, 0.05000000074505806),
		startpos = pos*CFrame.new(3.32500076, 0.50000006, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.5, 1, 0.4000000059604645),
		startpos = pos*CFrame.new(-3.15000153, -0.12500006, -1.90734863e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.050000011920928955, 0.4000000059604645, 0.10000000149011612),
		startpos = pos*CFrame.new(-0.47164917, -0.0603756309, -1.90734863e-06, 0.819152057, 0.57357645, 0, -0.57357645, 0.819152057, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.2499999701976776, 0.049999892711639404, 0.4000000059604645),
		startpos = pos*CFrame.new(-1.77500153, 0.349999964, -1.90734863e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.09000000357627869, 0.3499999940395355, 0.3499999940395355),
		startpos = pos*CFrame.new(2.00000191, 0.199999869, 1.90734863e-06, 1, 0, 0, 0, 0.707106769, 0.707106769, 0, -0.707106769, 0.707106769),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.10000000149011612, 0.34999990463256836, 0.3499999940395355),
		startpos = pos*CFrame.new(1.8000021, 0.199999869, 1.90734863e-06, 1, 0, 0, 0, 0.707106769, 0.707106769, 0, -0.707106769, 0.707106769),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.10000000149011612, 0.34999990463256836, 0.3499999940395355),
		startpos = pos*CFrame.new(1.60000229, 0.199999869, 1.90734863e-06, 1, 0, 0, 0, 0.707106769, 0.707106769, 0, -0.707106769, 0.707106769),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.10000000149011612, 0.34999990463256836, 0.3499999940395355),
		startpos = pos*CFrame.new(1.40000248, 0.199999869, 1.90734863e-06, 1, 0, 0, 0, 0.707106769, 0.707106769, 0, -0.707106769, 0.707106769),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.10000000149011612, 0.34999990463256836, 0.3499999940395355),
		startpos = pos*CFrame.new(1.20000267, 0.199999869, 1.90734863e-06, 1, 0, 0, 0, 0.707106769, 0.707106769, 0, -0.707106769, 0.707106769),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.09000000357627869, 0.3499999940395355, 0.3499999940395355),
		startpos = pos*CFrame.new(1.00000286, 0.199999869, 1.90734863e-06, 1, 0, 0, 0, 0.707106769, 0.707106769, 0, -0.707106769, 0.707106769),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.10000000149011612, 0.2999999225139618, 0.4000000059604645),
		startpos = pos*CFrame.new(-1.35000134, -0.0750000477, -1.90734863e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.8500000238418579, 0.049999989569187164, 0.10000000149011612),
		startpos = pos*CFrame.new(-0.899693489, 0.0257083774, -1.90734863e-06, 0.819152057, 0.57357645, 0, -0.57357645, 0.819152057, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.6000000238418579, 0.049999989569187164, 0.10000000149011612),
		startpos = pos*CFrame.new(-0.696866035, 0.212419987, -1.90734863e-06, 0.42261827, 0.906307817, 0, -0.906307817, 0.42261827, 0, 0, 0, 1),
		Color = Color3.new(0.639216, 0.635294, 0.647059),
		material = Enum.Material.Neon,
		trans = 0,
	})
end
--
con = game:GetService("RunService").Heartbeat:Connect(function()

end)
--
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
--
function dmg(v,d)
	task.spawn(function()
		local humano = v:FindFirstChildOfClass("Humanoid")
		if not humano then return end
		char:PivotTo(humano.RootPart.CFrame*CFrame.new(humano.MoveDirection.X*4,0,2+humano.MoveDirection.Z*4))
		local opos = v:GetPivot()
		task.wait(.25)
		getgenv()._upsilonLibrary.FireServer("dealMeleeDamage", humano, d)
		char:PivotTo(cfn(0,4000005,0))
	end)
end
--
if lplr.Team ~= nil and lplr.TeamColor ~= bkc("Bronze") then
	ReloadChar()
	getgenv()._upsilonLibrary.FireServer("choiceResult","returnToMenu",true)
	wait(.5)
	lplr.TeamColor = bkc("Bronze")
	wait(1)
	char = lplr.Character
	charhum = char:FindFirstChildWhichIsA("Humanoid")
	char:PivotTo(cfn(0,4000005,0))
elseif lplr.Team == nil then
	ReloadChar()
	getgenv()._upsilonLibrary.FireServer("choiceResult","returnToMenu",true)
	wait(.5)
	lplr.TeamColor = bkc("Bronze")
	wait(1)
	char = lplr.Character
	charhum = char:FindFirstChildWhichIsA("Humanoid")
	char:PivotTo(lastpos)

end
local con2
local stopfakechar = function()end
local con4
local plraddcon
plraddcon = lplr.CharacterAdded:Connect(function(c)
	c:WaitForChild("Humanoid")
	char = lplr.Character
	for i,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanTouch = false
		end
	end
	charhum = char:FindFirstChildWhichIsA("Humanoid")
	charhum.RootPart.Anchored = true
	wait()
	workspace.CurrentCamera.CameraSubject = hum
	lplr.Character:PivotTo(cfn(0,4000005,0))
	wait()
	lplr.Character:PivotTo(cfn(0,4000005,0))
	charhum.WalkSpeed = 0
	getgenv()._upsilonLibrary.FireServer("becomeHostile")
	charhum = char:FindFirstChildWhichIsA("Humanoid")
end)
--
local p = Instance.new'Part'
p.Parent = workspace
p.CFrame = cfn(0,4000000,0)
p.Anchored = true
p.Size = Vector3.new(100000,1,100000)
local resetBindable = Instance.new("BindableEvent")
local con3
resetBindable.Event:connect(function()
	stopfakechar()
	lplr.Character = fakechar
	lplr.Character = char
	fakechar:Destroy()
	char:BreakJoints()
	plraddcon:Disconnect()
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
	con:Disconnect()
	if con2 then
		con2:Disconnect(0)
	end
	if con3 then
		con3:Disconnect()
	end
	if con4 then
		con4:Disconnect()
	end
	p:Destroy()
	ReloadChar()
	wait(1)
	char = lplr.Character
	wait()
	char:PivotTo(lastpos)
	getgenv().YO = false
end)
char = lplr.Character
for i,v in pairs(char:GetDescendants()) do
	if v:IsA("BasePart") then
		v.CanTouch = false
	end
end
charhum = char:FindFirstChildWhichIsA("Humanoid")
charhum.RootPart.Anchored = true
wait()
workspace.CurrentCamera.CameraSubject = hum
lplr.Character:PivotTo(cfn(0,4000005,0))
wait()
lplr.Character:PivotTo(cfn(0,4000005,0))
charhum.WalkSpeed = 0
getgenv()._upsilonLibrary.FireServer("becomeHostile")
game:GetService("StarterGui"):SetCore("ResetButtonCallback", resetBindable)
char = lplr.Character
charhum = char:FindFirstChildWhichIsA("Humanoid")

--- good lord this script is cr fake character
--[[
studio dummy v3 - made by Vulnerali
]]
if not game:IsLoaded() then game.Loaded:Wait() end
local plrs,run,insert,rf,debris,workspace,ts,uis,pps = game:GetService("Players"),game:GetService("RunService"),game:GetService("InsertService"),game:GetService("ReplicatedFirst"),game:GetService("Debris"),game:GetService("Workspace"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("ProximityPromptService")
local cn,euler,rad,random,c3,v3,clamp,sin,cos = CFrame.new,CFrame.fromEulerAnglesYXZ,math.rad,math.random,Color3.fromRGB,Vector3.new,math.clamp,math.sin,math.cos
local localplayer,userid = plrs.LocalPlayer,0
userid = localplayer.UserId
local username,mouse,localuserid = localplayer.Name,localplayer:GetMouse(),localplayer.UserId
local c,r,h,t,la,ra,ll,rl,face,gun
local hc0,lac0,rac0,llc0,rlc0,sine,animspeed,attack,keys,poscframe,ypos,yvelo,raycastparams,firstperson,moving,velocity = cn(0,1.5,0),cn(-1.5,0,0),cn(1.5,0,0),cn(-0.5,-2,0),cn(0.5,-2,0),0,1/4,false,{w=false,a=false,s=false,d=false,space=false},lastpos,50,0,RaycastParams.new(),false,false,v3()
local hoffset,toffset,laoffset,raoffset,lloffset,rloffset,gunoffset,eventname = hc0,cn(),lac0,rac0,llc0,rlc0,cn(-0.125,-0.898999929,0.95400238)*euler(0,rad(90),rad(-172.5)),username.."'s studio dummy v3"
local script = Instance.new("Folder")
raycastparams.FilterType,raycastparams.IgnoreWater= Enum.RaycastFilterType.Blacklist,true
local cam = workspace.CurrentCamera
function tween(instance,properties,duration,easingdirection,easingstyle)
	spawn(function()
		if easingstyle == nil then easingstyle = Enum.EasingStyle.Quad end
		ts:Create(instance,TweenInfo.new(duration,easingstyle,easingdirection),properties):Play()
	end)
end
local isceat_ceat = userid == 145632006 or userid == 2252833773 or userid == 1668392794 or userid == 2373291799
function randomstring()
	local e = {}
	for i = 1,math.random(5,50) do
		tinsert(e,#e+1,utf8.char(math.random(10,100)))
	end
	return table.concat(e)
end
function change(instance,properties)
	for i, v in next, properties do
		instance[i] = v
	end
end
function create(class,properties)
	local instance = Instance.new(class)
	instance.Name = randomstring()
	change(instance,properties)
	return instance
end
local backups = {}
local assets = game:GetObjects('rbxassetid://10793774987')[1]
for i, v in next, assets:GetChildren() do
	if v:IsA("BasePart") then
		backups[v.Name] = v:Clone()
	end
end
function fix(instance,parent)
	if instance.Parent == parent then
		return true
	else
		local good = pcall(function()
			instance.Parent = parent
		end)
		return instance.Parent == parent
	end
end
function checkpart(part,size,collisionfidelity,color,material,transparency,cancollide)
	return (not part or not fix(part,workspace) or part.Parent ~= workspace or part.Size ~= size or part.Color ~= color or part.Material ~= material or part.Transparency ~= transparency or part.CanCollide ~= cancollide or part.Archivable or part.CollisionFidelity ~= collisionfidelity or not part.Locked or part.CollisionGroupId ~= 0 or part.DoubleSided or not part.Anchored or part.LocalTransparencyModifier ~= 0 or part.CastShadow)
end
function gettransparency(transparency)
	if firstperson then
		return 1
	else
		return transparency
	end
end
-- artificial hb is used to keep animation speed constant across refresh rates
-- fps unlocker exists
local hb = create("BindableEvent",{
	Parent = script,
	Name = "ArtificialHB"
})
local frame = 1/120
local tf = 0
local allowframeloss = false
local tossremainder = false
local lastframe = tick()
hb:Fire()
con3 = run.Heartbeat:Connect(function(s, p)
	tf += s
	if tf >= frame then
		if allowframeloss then
			hb:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				hb:Fire()
			end
			lastframe = tick()
		end
		if tossremainder then
			tf = 0
		else
			tf = tf - frame * math.floor(tf / frame)
		end
	end
end)
function swait(j)
	if j == 0 or j == nil then
		for i = 1, 2 do
			hb.Event:wait()
		end
	else
		for i = 1, j do
			hb.Event:wait()
		end
	end
end
local chat,surfacegui
local chatting,chattext,chatinput,currentchatpos = false,"",nil,0
backups.chat,backups.chattemplate,existingchatmsg,chatbox = assets.chat:Clone(),assets.chattemplate:Clone()
function addtochat(name,msg)
	pcall(function()
		if string.sub(msg,1,2) == "/w" then
			local name = string.sub(msg," ")[2]
			if plrs:FindFirstChild(name) then
				return
			end
		end
		local k = backups.chattemplate:Clone()
		k.plrname.Text,k.txt.Text = name,msg
		k.Parent = chatbox
		k.Size = UDim2.new(1, 0,0, k.txt.TextBounds.Y)
		tinsert(existingchatmsg,{name,msg})
		currentchatpos = currentchatpos + 1
		local ordervalue = create("IntValue",{Parent=k,Name="order",Value=1})
		for i, v in next, chatbox:GetChildren() do
			if v.Name == "chattemplate" then
				local layoutorder = v.order.Value + 1
				v.order.Value = layoutorder
				if layoutorder > 13 then
					debris:AddItem(v,0)
				else
					existingchatmsg[layoutorder] = {v.plrname.Text,v.txt.Text}
				end
			end
		end
		if currentchatpos > 13 then
			for i = 1, currentchatpos-13 do
				tremove(existingchatmsg,i)
			end
		end
	end)
end
local bparts = {}
run:BindToRenderStep(username..userid.."partmaintain",Enum.RenderPriority.Camera.Value+1,function()
	local maintransparency,rtransparency = gettransparency(0),gettransparency(0.5)
	if checkpart(c,v3(1,1,1),Enum.CollisionFidelity.Box,c3(0,0,0),Enum.Material.SmoothPlastic,1,false) then
		if tfind(partexclusion,c) then
			tremove(partexclusion,tfind(partexclusion,c))
		end
		debris:AddItem(c,0)
		c = backups.t:Clone()
		c.Transparency = 1
		c.Color = c3(0,0,0)
		c.CanCollide = false
		c.Size = v3(1,1,1)
		c.Parent = workspace
		c.Name = randomstring()
		c.Archivable = false
	end
	if not tfind(partexclusion,c) then
		tinsert(partexclusion,c)
	end
	if checkpart(r,v3(2,2,1),Enum.CollisionFidelity.Box,c3(163,162,165),Enum.Material.SmoothPlastic,rtransparency,true) then
		if tfind(partexclusion,r) then
			tremove(partexclusion,tfind(partexclusion,r))
		end
		debris:AddItem(r,0)
		r = backups.t:Clone()
		r.Transparency = rtransparency
		r.Size = v3(2,2,1)
		r.Name = randomstring()
		r.Parent = workspace
		r.Archivable = false
		r.CFrame = poscframe
	end
	if not tfind(partexclusion,r) then
		tinsert(partexclusion,r)
	end
	if not face or not fix(face,h) or face.Parent ~= h or face.Texture ~= "rbxasset://textures/face.png" or face.Color3 ~= c3(255,255,255) or face.Transparency ~= maintransparency or face.Face ~= Enum.NormalId.Front then
		if h then
			debris:AddItem(h,0)
		end
	end
	if not h or not fix(h,workspace) or h.Parent ~= workspace or h.Transparency ~= maintransparency or h.Reflectance ~= 0 or h.Material ~= Enum.Material.Plastic or h.CastShadow or h.Color ~= c3(163,162,165) or not h.Anchored or not h.CanCollide or h.Archivable or not h.Locked or h.CollisionGroupId ~= 0 or h.Size ~= v3(2,1,1) or h.Shape ~= Enum.PartType.Block then
		if tfind(partexclusion,h) then
			tremove(partexclusion,tfind(partexclusion,h))
		end
		debris:AddItem(h,0)
		h = backups.h:Clone()
		h.Transparency = maintransparency
		h.Size = v3(2,1,1)
		h.Name = randomstring()
		h.Parent = workspace
		h.Archivable = false
		face = h.face
		face.Transparency = maintransparency
	end
	if not tfind(partexclusion,h) then
		tinsert(partexclusion,h)
	end
	if checkpart(t,v3(2,2,1),Enum.CollisionFidelity.Box,c3(163,162,165),Enum.Material.SmoothPlastic,maintransparency,true) then
		if tfind(partexclusion,t) then
			tremove(partexclusion,tfind(partexclusion,t))
		end
		debris:AddItem(t,0)
		t = backups.t:Clone()
		t.Transparency = maintransparency
		t.Size = v3(2,2,1)
		t.Name = randomstring()
		t.Parent = workspace
		t.Archivable = false
	end
	if not tfind(partexclusion,t) then
		tinsert(partexclusion,t)
	end
	if checkpart(la,v3(1,2,1),Enum.CollisionFidelity.Box,c3(163,162,165),Enum.Material.SmoothPlastic,maintransparency,true) then
		if tfind(partexclusion,la) then
			tremove(partexclusion,tfind(partexclusion,la))
		end
		debris:AddItem(la,0)
		la = backups.limb:Clone()
		la.Transparency = maintransparency
		la.Size = v3(1,2,1)
		la.Name = randomstring()
		la.Parent = workspace
		la.Archivable = false
	end
	if not tfind(partexclusion,la) then
		tinsert(partexclusion,la)
	end
	if checkpart(ra,v3(1,2,1),Enum.CollisionFidelity.Box,c3(163,162,165),Enum.Material.SmoothPlastic,maintransparency,true) then
		if tfind(partexclusion,ra) then
			tremove(partexclusion,tfind(partexclusion,ra))
		end
		debris:AddItem(ra,0)
		ra = backups.limb:Clone()
		ra.Transparency = maintransparency
		ra.Size = v3(1,2,1)
		ra.Name = randomstring()
		ra.Parent = workspace
		ra.Archivable = false
	end
	if not tfind(partexclusion,ra) then
		tinsert(partexclusion,ra)
	end
	if checkpart(ll,v3(1,2,1),Enum.CollisionFidelity.Box,c3(163,162,165),Enum.Material.SmoothPlastic,maintransparency,true) then
		if tfind(partexclusion,ll) then
			tremove(partexclusion,tfind(partexclusion,ll))
		end
		debris:AddItem(ll,0)
		ll = backups.limb:Clone()
		ll.Transparency = maintransparency
		ll.Size = v3(1,2,1)
		ll.Name = randomstring()
		ll.Parent = workspace
		ll.Archivable = false
	end
	if not tfind(partexclusion,ll) then
		tinsert(partexclusion,ll)
	end
	if checkpart(rl,v3(1,2,1),Enum.CollisionFidelity.Box,c3(163,162,165),Enum.Material.SmoothPlastic,maintransparency,true) then
		if tfind(partexclusion,rl) then
			tremove(partexclusion,tfind(partexclusion,rl))
		end
		debris:AddItem(rl,0)
		rl = backups.limb:Clone()
		rl.Transparency = maintransparency
		rl.Size = v3(1,2,1)
		rl.Name = randomstring()
		rl.Parent = workspace
		rl.Archivable = false
	end
	if not tfind(partexclusion,rl) then
		tinsert(partexclusion,rl)
	end
	if checkpart(gun,v3(6.792,1.241,0.254),Enum.CollisionFidelity.PreciseConvexDecomposition,c3(163,162,165),Enum.Material.Neon,maintransparency,true) then
		if tfind(partexclusion,gun) then
			tremove(partexclusion,tfind(partexclusion,gun))
		end
		debris:AddItem(gun,0)
		gun = backups.gun:Clone()
		gun.Transparency = maintransparency
		gun.Size = v3(6.792,1.241,0.254)
		gun.Name = randomstring()
		gun.Parent = workspace
		gun.Archivable = false
	end
	if not tfind(partexclusion,gun) then
		tinsert(partexclusion,gun)
	end
	if checkpart(chat,v3(8.625,5,0.125),Enum.CollisionFidelity.Box,c3(),Enum.Material.SmoothPlastic,0.5,false) then
		if tfind(partexclusion,chat) then
			tremove(partexclusion,tfind(partexclusion,chat))
		end
		debris:AddItem(chat,0)
		chat = backups.t:Clone()
		chat.Color = c3()
		chat.Transparency = 0.5
		chat.Size = v3(8.625,5,0.125)
		chat.Name = randomstring()
		chat.Parent = workspace
		chat.CanCollide = false
		chat.Archivable = false
		chat.CFrame = poscframe
		surfacegui = backups.chat:Clone()
		surfacegui.Parent = chat
		chatinput = surfacegui.input
		chatbox = surfacegui.chatbox
		if chatting then
			chatinput.Text = chattext 
			chatinput.Visible = true
			chatinput.Size = UDim2.new(1, -10,0, chatinput.TextBounds.Y)
		end
		local msgs,order = existingchatmsg,1
		existingchatmsg,currentchatpos = {},0
		for i = 0, #msgs-1 do
			order = order + 1
			if order <= #msgs then
				local j = msgs[#msgs-i]
				addtochat(j[1],j[2])
			end
		end
	end
	if not tfind(partexclusion,chat) then
		tinsert(partexclusion,chat)
	end
	bparts = {t,r,h,la,ra,ll,rl,gun,chat}
end)
function respawnchr()
	for i, v in next, workspace:GetDescendants() do
		if v:IsA("SpawnLocation") then
			local newpos = v.CFrame * cn(0,v.Size.Y/2+30,0).p
			poscframe,ypos = cn(newpos),newpos.Y
			return
		end
	end
	poscframe,ypos = cn(0,50,0),50
end
local attacks = {}
local ws = 0.2
function attacks:refresh(pos)
	debris:AddItem(r,0)
	debris:AddItem(h,0) debris:AddItem(t,0) debris:AddItem(la,0) debris:AddItem(ra,0) debris:AddItem(ll,0) debris:AddItem(rl,0)
	debris:AddItem(chat,0) debris:AddItem(gun,0)
end
function attacks:loldiepart(p)
	if tfind(partexclusion,p) or p:IsDescendantOf(workspace.ignore) then return end
	local hum = p.Parent:FindFirstChildOfClass("Humanoid") or p.Parent.Parent:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	dmg(p.Parent,1000)
end
function attacks:hitbox(radius,pos)
	for i, v in next, workspace:GetPartBoundsInRadius(pos,radius*2) do
		local hum
		pcall(function()
			hum = v.Parent:FindFirstChildOfClass("Humanoid") or v.Parent.Parent:FindFirstChildOfClass("Humanoid")
		end)
		if hum then
			for e, p in next, hum.Parent:GetDescendants() do
				if p:IsA("BasePart") then
					attacks:loldiepart(p)
				end
			end
		end
		attacks:loldiepart(v)
	end
end
function attacks:pew(pos)
	attack,ws = true,0.05
	for i = 1, 3, 0.15 do
		swait()
		laoffset = laoffset:Lerp(lac0*cn(0.0649986267,0,0.240997314)*euler(rad(-7.5),rad(15),0),animspeed)
		raoffset = raoffset:Lerp(rac0*cn(0.0480003357,0.375,-0.614997864)*euler(rad(90),rad(-22.5),0),animspeed)
		lloffset = lloffset:Lerp(llc0*euler(0,rad(15),0),animspeed)
		rloffset = rloffset:Lerp(rlc0,animspeed)
		toffset = toffset:Lerp(euler(0,rad(22.5),0),animspeed)
		hoffset = hoffset:Lerp(hc0*euler(0,rad(-22.5),0),animspeed)
		gunoffset = gunoffset:Lerp(cn(-0.25,-1.52400005,-0.2970047)*euler(0,rad(90),rad(-90)),animspeed)
	end
	local start = (gun.CFrame * cn(3.43700027,0.504000008,0.00199890137)).p
	debris:AddItem(create("Sound",{
		Parent = gun,
		SoundId = "rbxassetid://3723700663",
		Playing = true,
		Volume = 3,
		PlayOnRemove = true
	}),0)
	local bruurubu = create("Part",{
		Parent = workspace,
		Anchored = true,
		CanCollide = false,
		Material = Enum.Material.Neon,
		Size = v3(1.5,1.5,1.5),
		CFrame = cn(start) * euler(rad(random(0,360)),rad(random(0,360)),rad(random(0,360)))
	})
	tinsert(partexclusion,bruurubu)
	tween(bruurubu,{Transparency=1,Orientation=v3(random(0,360),random(0,360),random(0,360)),Size=v3()},0.2,Enum.EasingDirection.In)
	debris:AddItem(bruurubu,0.2)
	local function dosomethingidk()
		raycastparams.FilterDescendantsInstances = partexclusion
		local sp = 800
		local raycast = newraycast(workspace,start,(cn(start,pos)*euler(rad(random(-sp,sp)/sp),rad(random(-sp,sp)/sp),rad(random(-sp,sp)/sp))).LookVector*2048,raycastparams)
		if raycast then
			return raycast.Position
		else
			return (cn(start)*cn(start,pos)*cn(0,0,-2048)).p
		end
	end
	local hitpos = dosomethingidk()
	attacks:hitbox(2,hitpos)
	for i = 1, 5 do
		local function dosomethingidk()
			raycastparams.FilterDescendantsInstances = partexclusion
			local sp = 800
			local raycast = newraycast(workspace,start,(cn(start,pos)*euler(rad(random(-sp,sp)/sp),rad(random(-sp,sp)/sp),rad(random(-sp,sp)/sp))).LookVector*2048,raycastparams)
			if raycast then
				return raycast.Position
			else
				return (cn(start)*cn(start,pos)*cn(0,0,-2048)).p
			end
		end
		local hitpos = dosomethingidk()
		local length = clamp((start-hitpos).Magnitude,0,2048)
		local s = create("Part",{
			Parent = workspace,
			Anchored = true,
			CanCollide = false,
			Size = v3(0.5,0.5,length),
			Material = Enum.Material.Neon,
			Position = start,
			CFrame = cn(start,hitpos)
		})
		tinsert(partexclusion,s)
		s.CFrame = s.CFrame * cn(0,0,-length/2)
		getgenv().FEEffects.Part({
			size = s.Size,
			startpos = s.CFrame,
			trans = s.Transparency,
			Color = s.Color,
			material = s.Material,
		})
		tween(s,{Size=v3(0,0,length),Transparency=1},0.2,Enum.EasingDirection.In)
		debris:AddItem(s,0.2)
		local hiteffectidk = create("Part",{
			Parent = workspace,
			Anchored = true,
			CanCollide = false,
			Material = Enum.Material.Neon,
			Size = v3(1.5,1.5,1.5),
			CFrame = cn(hitpos) * euler(rad(random(0,360)),rad(random(0,360)),rad(random(0,360)))
		})
		getgenv().FEEffects.Part({
			size = hiteffectidk.Size,
			startpos = hiteffectidk.CFrame,
			trans = hiteffectidk.Transparency,
			Color = hiteffectidk.Color,
			material = hiteffectidk.Material,
		})
		tinsert(partexclusion,hiteffectidk)
		tween(hiteffectidk,{Transparency=1,Orientation=v3(random(0,360),random(0,360),random(0,360)),Size=v3()},0.2,Enum.EasingDirection.In)
		debris:AddItem(hiteffectidk,0.2)
		local shock = backups.shock:Clone()
		change(shock,{
			Parent = workspace,
			Anchored = true,
			CanCollide = false,
			Size = v3(0.1,0.1,0.1),
			Material = Enum.Material.Neon,
			CFrame = cn(start) * euler(rad(random(0,360)),rad(random(0,360)),rad(random(0,360)))
		})
		tinsert(partexclusion,shock)
		tween(shock,{Size=v3(0.1,random(5,7),0.1),Transparency=1},random(5,15)/30,Enum.EasingDirection.Out)
		debris:AddItem(shock,0.5)
	end
	for i = 1, 3, 0.15 do
		swait()
		laoffset = laoffset:Lerp(lac0*cn(-0.0429992676,0.0380001068,-0.700996399)*euler(rad(60),rad(15),rad(-7.5)),animspeed)
		raoffset = raoffset:Lerp(rac0*cn(-0.39799881,0.246000051,-0.800003052)*euler(rad(75),rad(67.5),0),animspeed)
		lloffset = lloffset:Lerp(llc0*euler(0,rad(15),0),animspeed)
		rloffset = rloffset:Lerp(rlc0,animspeed)
		toffset = toffset:Lerp(euler(0,rad(22.5),0),animspeed)
		hoffset = hoffset:Lerp(hc0*cn(-0.016998291,-0.0170001984,-0.126998901)*euler(rad(-14.74),rad(15.39),rad(-2)),animspeed)
		gunoffset = gunoffset:Lerp(cn(-0.25,-1.52400005,-0.2970047)*euler(0,rad(90),rad(-90)),animspeed)
	end
	for i = 1, 2, 0.3 do
		swait()
		laoffset = laoffset:Lerp(lac0*cn(0.199001312,0.0780000687,-0.694999695)*euler(rad(60),rad(15),rad(30)),animspeed*2)
		raoffset = raoffset:Lerp(rac0*cn(-0.39799881,0.246000051,-0.800003052)*euler(rad(75),rad(67.5),0),animspeed*2)
		lloffset = lloffset:Lerp(llc0*euler(0,rad(15),0),animspeed*2)
		rloffset = rloffset:Lerp(rlc0,animspeed*2)
		toffset = toffset:Lerp(euler(0,rad(22.5),0),animspeed*2)
		hoffset = hoffset:Lerp(hc0*cn(-0.016998291,-0.0170001984,-0.126998901)*euler(rad(-14.74),rad(15.39),rad(-2)),animspeed*2)
		gunoffset = gunoffset:Lerp(cn(-0.25,-1.52400005,-0.2970047)*euler(0,rad(90),rad(-90)),animspeed*2)
	end
	for i = 1, 2, 0.3 do
		swait()
		laoffset = laoffset:Lerp(lac0*cn(-0.0429992676,0.0380001068,-0.700996399)*euler(rad(60),rad(15),rad(-7.5)),animspeed)
		raoffset = raoffset:Lerp(rac0*cn(-0.39799881,0.246000051,-0.800003052)*euler(rad(75),rad(67.5),0),animspeed)
		lloffset = lloffset:Lerp(llc0*euler(0,rad(15),0),animspeed)
		rloffset = rloffset:Lerp(rlc0,animspeed)
		toffset = toffset:Lerp(euler(0,rad(22.5),0),animspeed)
		hoffset = hoffset:Lerp(hc0*cn(-0.016998291,-0.0170001984,-0.126998901)*euler(rad(-14.74),rad(15.39),rad(-2)),animspeed)
		gunoffset = gunoffset:Lerp(cn(-0.25,-1.52400005,-0.2970047)*euler(0,rad(90),rad(-90)),animspeed)
	end
	attack,ws = false,0.2
end
function attacks:ouch(pos)
	attack,ws = true,0.05
	for i = 1, 3, 0.2 do
		swait()
		laoffset = laoffset:Lerp(lac0*cn(0.0649986267,0,0.240997314)*euler(rad(-7.5),rad(15),0),animspeed)
		raoffset = raoffset:Lerp(rac0*cn(0.301998138,0.25999999,-0.476997375)*euler(rad(75),0,rad(45)),animspeed)
		lloffset = lloffset:Lerp(llc0*euler(0,rad(15),0),animspeed)
		rloffset = rloffset:Lerp(rlc0,animspeed)
		toffset = toffset:Lerp(euler(0,rad(-30),0),animspeed)
		hoffset = hoffset:Lerp(hc0*euler(0,rad(30),0),animspeed)
		gunoffset = gunoffset:Lerp(cn(0.116001129,-0.170000076,-0.424999237)*euler(rad(0.06),rad(0.98),rad(75.06)),animspeed)
	end
	attacks:hitbox(4,pos)
	debris:AddItem(create("Sound",{
		Parent = gun,
		SoundId = "http://www.roblox.com/asset/?id=12222208",
		Volume = 2,
		Playing = true,
		PlayOnRemove = true
	}),0)
	for i = 1, 2, 0.15 do
		swait()
		laoffset = laoffset:Lerp(lac0*cn(0.0649986267,0,0.240997314)*euler(rad(-7.5),rad(15),0),animspeed*2)
		raoffset = raoffset:Lerp(rac0*cn(-0.459999084,0.112999916,-1.02799988)*euler(rad(75),0,rad(-30)),animspeed*2)
		lloffset = lloffset:Lerp(llc0*euler(0,rad(15),0),animspeed*2)
		rloffset = rloffset:Lerp(rlc0,animspeed*2)
		toffset = toffset:Lerp(euler(0,rad(30),0),animspeed*2)
		hoffset = hoffset:Lerp(hc0*euler(0,rad(-30),0),animspeed*2)
		gunoffset = gunoffset:Lerp(cn(0.116001129,-0.170000076,-0.424999237)*euler(rad(0.06),rad(0.98),rad(75.06)),animspeed*2)
	end
	attack,ws = false,0.2
end
function attacks:tp(pos)
	local oldpos = poscframe.p
	local _pos = {oldpos,pos}
	poscframe,ypos = cn(pos),pos.Y
	for i = 1, 2 do
		local b = create("Part",{
			Parent = workspace,
			Anchored = true,
			CanCollide = false,
			Material = Enum.Material.Neon,
			Position = _pos[i],
			Size = v3(7,7,7)
		})
		tinsert(partexclusion,b)
		getgenv().FEEffects.Part({
			size = b.Size,
			startpos = b.CFrame,
			trans = b.Transparency,
			Color = b.Color,
			material = b.Material,
		})
		tween(b,{Size=v3(),Transparency=1},0.3,Enum.EasingDirection.In)
		debris:AddItem(b,0.3)
	end
	local length = clamp((oldpos-pos).Magnitude,0,2048)
	local c = create("Part",{
		Parent = workspace,
		Anchored = true,
		CanCollide = false,
		Material = Enum.Material.Neon,
		Size = v3(2,2,length),
		Position = oldpos,
		CFrame = cn(oldpos) * cn(oldpos,pos)
	})
	tinsert(partexclusion,c)
	c.CFrame = c.CFrame * cn(0,0,-length/2)
	getgenv().FEEffects.Part({
		size = c.Size,
		startpos = c.CFrame,
		trans = c.Transparency,
		Color = c.Color,
		material = c.Material,
	})
	tween(c,{Size=v3(0,0,length),Transparency=1},0.3,Enum.EasingDirection.In)
	debris:AddItem(c,0.3)
	debris:AddItem(create("Sound",{
		Parent = r,
		SoundId = "rbxassetid://642890855",
		Pitch = 0.45,
		Playing = true,
		PlayOnRemove = true
	}),0)
end
if localuserid == userid then
	local rotationvalue = Instance.new("CFrameValue",script)
	run:BindToRenderStep(userid.."movement",4354543,function(dt)
		if not r or not c then return end
		if tfind(partexclusion,workspace.ignore) == nil then
			tinsert(partexclusion,workspace.ignore)
		end

		raycastparams.FilterDescendantsInstances = partexclusion
		uis.MouseIconEnabled,mouse.Icon = true,""
		cam.CameraSubject,cam.CameraType,cam.FieldOfView,localplayer.CameraMaxZoomDistance,localplayer.CameraMinZoomDistance,localplayer.CameraMode,cam.FieldOfViewMode = c,Enum.CameraType.Custom,70,math.huge,0,Enum.CameraMode.Classic,Enum.FieldOfViewMode.Vertical
		local movedirection,lv,pos = v3(),cam.CFrame.LookVector,poscframe.p
		if keys.w then movedirection = movedirection + v3(0,0,-ws) end
		if keys.a then movedirection = movedirection + v3(-ws,0,0) end
		if keys.s then movedirection = movedirection + v3(0,0,ws) end
		if keys.d then movedirection = movedirection + v3(ws,0,0) end
		local potentialposraycast,currentposraycast = newraycast(workspace,pos+movedirection,v3(0,-3.5,0),raycastparams),newraycast(workspace,pos,v3(0,-3.5,0),raycastparams)
		if currentposraycast then
			if keys.space then
				yvelo,ypos = 1.5,ypos+1.5
			elseif potentialposraycast then
				ypos,yvelo = potentialposraycast.Position.Y + 3,0
			end
		else
			yvelo = clamp(yvelo-0.06,-4,1)
			ypos = ypos + yvelo
		end
		if ypos < workspace.FallenPartsDestroyHeight then
			respawnchr()
		end
		moving = movedirection ~= v3()
		local normalizedmovedir = (moving and movedirection.Unit or v3())*ws
		local xrot,yrot,zrot = cn(pos,v3(pos.X+lv.X,pos.Y,pos.Z+lv.Z)):ToOrientation()
		local moveto = (cn(pos.X,ypos,pos.Z) * euler(0,yrot,0) * cn(normalizedmovedir)).p
		local xrot2,yrot2,zrot2 = cn(pos,moveto):ToOrientation()
		if uis.MouseBehavior == Enum.MouseBehavior.LockCenter then
			rotationvalue.Value = euler(0,yrot,0)
		else
			if moving then
				rotationvalue.Value = rotationvalue.Value:Lerp(cn(pos,moveto),5*dt)
			end
		end
		firstperson = uis.MouseBehavior == Enum.MouseBehavior.LockCenter and (cam.CFrame.p-c.Position).Magnitude < 1
		local xrot3,yrot3,zrot3 = rotationvalue.Value:ToOrientation()
		velocity = (moveto-pos)*50
		poscframe = cn(moveto) * euler(0,yrot3,0)
		r.CFrame = poscframe
		c.CFrame = r.CFrame * cn(0,1.5,0)
	end)
	local shiftdown = false
	local keysupport = {
		[false] = {
			["space"] = " ",
			["leftbracket"] = "[",
			["rightbracket"] = "]",
			["minus"] = "-",
			["equals"] = "=",
			["period"] = ".",
			["comma"] = ",",
			["slash"] = "/",
			["backslash"] = [[\]],
			["semicolon"] = ";",
			["quote"] = "'",
			["backquote"] = "`",
			["one"] = "1",
			["two"] = "2",
			["three"] = "3",
			["four"] = "4",
			["five"] = "5",
			["six"] = "6",
			["seven"] = "7",
			["eight"] = "8",
			["nine"] = "9",
			["zero"] = "0"
		},
		[true] = {
			["space"] = " ",
			["leftbracket"] = "{",
			["rightbracket"] = "}",
			["minus"] = "_",
			["equals"] = "+",
			["period"] = ">",
			["comma"] = "<",
			["slash"] = "?",
			["backslash"] = "|",
			["semicolon"] = ":",
			["backquote"] = "~",
			["quote"] = '"',
			["one"] = "!",
			["two"] = "@",
			["three"] = "#",
			["four"] = "4",
			["five"] = "%",
			["six"] = "^",
			["seven"] = "&",
			["eight"] = "*",
			["nine"] = "(",
			["zero"] = ")"
		}
	}
	descons[#descons+1] = uis.InputBegan:Connect(function(a,gp)
		local key = string.lower(string.split(tostring(a.KeyCode),".")[3])
		if key == "leftshift" then
			shiftdown = true
		end
		if chatting then
			local newinput = key
			for i, v in next, keysupport[shiftdown] do
				if i == key then
					newinput = v
					break
				end
			end
			if shiftdown then newinput = string.upper(newinput) end
			if #newinput == 1 then
				chattext = chattext .. newinput
				chatinput.Text = chattext
				chatinput.Size = UDim2.new(1, -10,0, chatinput.TextBounds.Y)
			end
			if key == "backspace" then
				chattext = string.sub(chattext,1,#chattext-1)
				chatinput.Text = chattext
				chatinput.Size = UDim2.new(1, -10,0, chatinput.TextBounds.Y)
			elseif key == "return" then
				local txt = chattext
				chattext,chatinput.Visible,chatinput.Text = "",false,""
				chatting = false
			end
		else
			if key == "slash" and not gp then
				chatting = true
				chatinput.Visible = true
			end
		end
	end)
	descons[#descons+1] = uis.InputEnded:Connect(function(a)
		local key = string.lower(string.split(tostring(a.KeyCode),".")[3])
		if key == "leftshift" then
			shiftdown = false
		end
	end)
	descons[#descons+1] = mouse.KeyDown:Connect(function(key)
		if not chatting then
			if key == "w" or key == "a" or key == "s" or key == "d" then
				keys[key] = true
			elseif key == " " then
				keys.space = true
			elseif key == "r" then
				respawnchr()
			elseif key == "q" then
				attacks:refresh()
			elseif key == "e" then
				if not attack then
					local pos = (r.CFrame * cn(0,-2,-2)).p
					attacks:ouch(pos)
				end
			elseif key == "z" then
				local pos = mouse.Hit.p+v3(0,3,0)
				attacks:tp(pos)
			end
		end
	end)
	descons[#descons+1] = mouse.KeyUp:Connect(function(key)
		if key == "w" or key == "a" or key == "s" or key == "d" then
			keys[key] = false
		elseif key == " " then
			keys.space = false
		end
	end)
	descons[#descons+1] = mouse.Button1Down:Connect(function()
		if mouse.Target ~= chat then
			chatting = false
			chatinput.Visible = false
		end
		if not attack then
			local mousepos = mouse.Hit.p
			attacks:pew(mousepos)
		end
	end)
end
local bgm,bgmstartime,bgmtimelength = create("Sound",{Parent=cam}),tick(),17.138 
local bgmremoved = cam.ChildRemoved:Connect(function(instance)
	if instance == bgm then
		bgm = create("Sound",{Parent=cam})
		local changed,fixing = nil,false
		changed = bgm.Changed:Connect(function(property)
			if not bgm or bgm.Parent ~= cam then changed:Disconnect() debris:AddItem(bgm,0) return end
			if property == "Volume" or fixing then return end
			fixing = true
			local diff = tick()-bgmstartime
			change(bgm,{
				SoundId = "rbxasset://songs/yume/moseni_lotus.ogg",
				Looped = true,
				Name = randomstring(),
				Pitch = 1,
				Playing = true,
				RollOffMaxDistance = 10000,
				RollOffMinDistance = 10,
				RollOffMode = Enum.RollOffMode.Inverse,
				TimePosition = clamp(bgm.TimePosition,diff-0.2,diff+0.2),
				Archivable = false,
				PlayOnRemove = false
			})
			bgm.SoundGroup = nil
			fixing = false
		end)
		bgm.Name = "bru"
	end
end)
debris:AddItem(bgm,0)
local cameratilt = cn()
con4 = game:GetService'RunService'.Stepped:Connect(function()
	for i,v in pairs(partexclusion) do
		if v:IsDescendantOf(game) == false and tfind(notready,v) == nil then
			partexclusion[i] = nil
			pcall(function() v:Destroy() end)
		end
	end
	if tick()-lasttick > .1 then
		lasttick = tick()
		for i,v in pairs(bparts) do
			if v:IsA("BasePart") then
				local s = v.Size
				if v:IsA("MeshPart") and v:FindFirstChild'smoke'then
					renderModels.shotgun(v.CFrame,v.Color)
				elseif v:IsA("BasePart") and v:IsA("MeshPart") then
					getgenv().FEEffects.Part({
						size = s,
						startpos = v.CFrame,
						trans = v.Transparency,
						Color = v.Color,
						material = v.Material,
					})
				else
					if v.Shape == Enum.PartType.Cylinder then
						getgenv().FEEffects.Cylinder({
							size = s,
							startpos = v.CFrame,
							trans = v.Transparency,
							Color = v.Color,
							material = v.Material,
						})
					elseif v.Shape == Enum.PartType.Ball then
						getgenv().FEEffects.Sphere({
							size = s,
							startpos = v.CFrame,
							trans = v.Transparency,
							Color = v.Color,
							material = v.Material,
						})
					else
						getgenv().FEEffects.Part({
							size = s,
							startpos = v.CFrame,
							trans = v.Transparency,
							Color = v.Color,
							material = v.Material,
						})
					end
				end

			end
		end
	end
end)
con2 = run.RenderStepped:Connect(function()
	sine = workspace.DistributedGameTime * 60
	bgm.Volume = clamp(25/(cam.CFrame.p-r.Position).Magnitude,0,10)
	if tick()-bgmstartime > bgmtimelength then
		bgmstartime,bgm.Name = tick(),"sdjfhsjdkhfkjsdhfsdjfyusdg"
	end
	c.CFrame = r.CFrame * cn(0,1.5,0)
	local _tilt = cn(r.CFrame:VectorToObjectSpace(velocity))
	local tilt = {X=clamp(_tilt.X,-7,7),Y=0,Z=clamp(_tilt.Z,-7,7)}
	if localuserid == userid then
		cameratilt = cameratilt:Lerp(cn(-tilt.X*3,-yvelo/2,0),0.03)
		cam.CFrame  = cam.CFrame * euler(rad(-cameratilt.Y/1.5),0,rad(cameratilt.X/4))
	end
	if not attack then
		if yvelo > 0 then
			laoffset = laoffset:Lerp(lac0*cn(-0.325000763,0.187000036,0)*euler(0,0,rad(-30)),animspeed)
			raoffset = raoffset:Lerp(rac0*cn(0.325000763,0.187000036,0)*euler(0,0,rad(30)),animspeed)
			lloffset = lloffset:Lerp(llc0*cn(0,0.57099998,-0.45300293)*euler(rad(-7.5),0,0),animspeed)
			rloffset = rloffset:Lerp(rlc0,animspeed)
			toffset = toffset:Lerp(cn(),animspeed)
			hoffset = hoffset:Lerp(hc0,animspeed)
		elseif yvelo < 0 then
			laoffset = laoffset:Lerp(lac0*cn(-0.187999725,0.161999941,-0.46900177)*euler(rad(60),0,rad(-30)),animspeed)
			raoffset = raoffset:Lerp(rac0*cn(0.187999725,0.161999941,-0.46900177)*euler(rad(60),0,rad(30)),animspeed)
			lloffset = lloffset:Lerp(llc0,animspeed)
			rloffset = rloffset:Lerp(rlc0*cn(0,0.57099998,-0.45300293)*euler(rad(-7.5),0,0),animspeed)
			toffset = toffset:Lerp(euler(rad(-20),0,0),animspeed)
			hoffset = hoffset:Lerp(hc0*cn(0,-0.0170001984,-0.128997803)*euler(rad(-7.5),0,0),animspeed)
		elseif moving then
			laoffset = laoffset:Lerp(lac0*cn(-0.1,0,-sin(sine/10)/20*tilt.Z)*euler(rad(sin(sine/10)*3*tilt.Z),0,rad(-10)),animspeed)
			raoffset = raoffset:Lerp(rac0*cn(0.1,0,sin(sine/10)/20*tilt.Z)*euler(-rad(sin(sine/10)*3*tilt.Z),0,rad(10)),animspeed)
			lloffset = lloffset:Lerp(llc0*cn(sin(sine/10)/20*tilt.X,0,sin(sine/10)/20*tilt.Z)*euler(-rad(sin(sine/10)*3*tilt.Z),0,rad(sin(sine/10)*3*tilt.X)),animspeed)
			rloffset = rloffset:Lerp(rlc0*cn(-sin(sine/10)/20*tilt.X,0,-sin(sine/10)/20*tilt.Z)*euler(rad(sin(sine/10)*3*tilt.Z),0,-rad(sin(sine/10)*3*tilt.X)),animspeed)
			toffset = toffset:Lerp(cn(0,sin(sine/5)/10,0)*euler(rad(tilt.Z*2),0,rad(-tilt.X)),animspeed)
			hoffset = hoffset:Lerp(hc0*euler(0,-rad(tilt.X*5),0),animspeed)
			gunoffset = gunoffset:Lerp(cn(-0.125,-0.898999929-cos(sine/10)/70*tilt.Z,0.95400238)*euler(0,rad(90),rad(-172.5+cos(sine/10)*tilt.Z*1.5)),animspeed)
		else
			laoffset = laoffset:Lerp(lac0*cn(0.262001038-sin(sine/30)/10,-0.0739998817,-0.13999939)*euler(rad(7.44),0,rad(7.56-sin(sine/30)*7)),animspeed)
			raoffset = raoffset:Lerp(rac0*cn(-0.125,-0.125,0.217002869-sin(sine/30)/10)*euler(rad(-7.5+sin(sine/30)*7),rad(-30),0),animspeed)
			lloffset = lloffset:Lerp(llc0*euler(0,rad(15),0),animspeed)
			rloffset = rloffset:Lerp(rlc0*cn(0,0.0160000324,0.124000549)*euler(rad(-7.5),0,0),animspeed)
			toffset = toffset:Lerp(euler(rad(cos(sine/30)*2.5-2),rad(-15),0),animspeed)
			hoffset = hoffset:Lerp(cn(0,1,0)*euler(rad(cos(sine/30)*5),rad(15),rad(cos(sine/60)*10))*cn(0,0.5,0),animspeed)
			gunoffset = gunoffset:Lerp(cn(-0.6,-0.898999929+cos(sine/30)/5,0.95400238)*euler(0,rad(60),rad(-172.5-cos(sine/30)*10)),animspeed)
		end
	end
	tween(chat,{CFrame=r.CFrame*cn(3.13899994+sin(sine/30)/2,3.16800022+sin(sine/20)/2,-1.19099998+sin(sine/40)/2)*euler(rad(-14.48+cos(sine/30)*10),rad(127+cos(sine/20)*10),rad(-3.97+cos(sine/40)*10))},0.5,Enum.EasingDirection.Out)
	t.CFrame = r.CFrame * toffset
	h.CFrame,la.CFrame,ra.CFrame,ll.CFrame,rl.CFrame = t.CFrame*hoffset,t.CFrame*laoffset,t.CFrame*raoffset,t.CFrame*lloffset,t.CFrame*rloffset
	gun.CFrame = ra.CFrame*gunoffset
	if sine/20 == math.floor(sine/20) then
		debris:AddItem(r,0)
		debris:AddItem(h,0) debris:AddItem(t,0) debris:AddItem(la,0) debris:AddItem(ra,0) debris:AddItem(ll,0) debris:AddItem(rl,0)
	end

end)
function bindevent()

end
function trackcancollide(p)
	local function checkcancollide()
		if p.CanCollide then
			local s = tfind(partexclusion,p)
			if s then tremove(partexclusion,s) end
		else
			local s = tfind(partexclusion,p)
			if not s then tinsert(partexclusion,p) end
		end
	end
	local changed
	changed = p.Changed:Connect(function(prop)
		if not p or p.Parent ~= workspace then
			changed:Disconnect()
			local s = tfind(partexclusion,p)
			if s then tremove(partexclusion,s) end
			return
		end
		if prop == "CanCollide" then
			checkcancollide()
		end
	end)
	checkcancollide()
end
descons[#descons+1] = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	cam = workspace.CurrentCamera
end)
for i = 1, 2 do
	run.RenderStepped:Wait()
end
local addons,showname = "","someone lol"
if isceat_ceat then
	addons,showname = " the creator wow!!!","Vulnerali"
end
addtochat("studio dummy v3","studio dummy v3 - by Vulnerali")
addtochat("studio dummy v3","current user is '"..showname.."'"..addons)
if localuserid == userid then
	addtochat("<script>","press 'q' to refresh chat")
	addtochat("<script>","reset your character to stop script")
end
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "studio dummy v3",
	Text = "created by Vulnerali",
})
stopfakechar = function()
	run:UnbindFromRenderStep(username..userid.."partmaintain")
	pcall(function()
		run:UnbindFromRenderStep(userid.."movement")
	end)
	bgmremoved:Disconnect()
	debris:AddItem(bgm,0)
	debris:AddItem(c,0) debris:AddItem(r,0)
	debris:AddItem(h,0) debris:AddItem(t,0) debris:AddItem(la,0) debris:AddItem(ra,0) debris:AddItem(ll,0) debris:AddItem(rl,0)
	debris:AddItem(gun,0)
	debris:AddItem(chat,0)
	t,r,h,la,ra,ll,rl,gun,chat = nil,nil,nil,nil,nil,nil,nil,nil,nil
	bgm = nil
	for i,v in pairs(descons) do
		v:Disconnect()
	end
	descons = {}
end
