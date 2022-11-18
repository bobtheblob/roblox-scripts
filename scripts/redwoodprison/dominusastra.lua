if getgenv().YO then error'You are currently in Fake Character mode' return end
getgenv().YO = true
--
local tinsert = table.insert
local tremove = table.remove

local v3 = Vector3.new
local cfn = CFrame.new
local c3 = Color3.new
local bkc = BrickColor.new
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

-- functions
getgenv().lasers = getgenv().lasers or {}
drawLaser = function(p84, p85, p86)
	local v1991 = (p84 - p85).magnitude
	local v1992 = Instance.new("Part")
	v1992.Anchored = true
	v1992.CanCollide = false
	v1992.Parent = workspace.ignore
	v1992.Size = v3(0.2, 0.2, v1991)
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
--
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
--
local renderPart = getgenv().FEEffects.Part
local renderSphere = getgenv().FEEffects.Sphere
local renderCylinder = getgenv().FEEffects.Cylinder
--
local renderModels = {}
renderModels.Dominus = function(pos,col)
	renderPart({
		size = Vector3.new(0.211698517203331, 1.1643418073654175, 1.1643418073654175),
		startpos = pos*CFrame.new(-1.28056854e-09, 0.476321459, 3.7252903e-09, 0, -1, 0, 1, 0, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(1.0584925413131714, 1.0584925413131714, 1.0584925413131714),
		startpos = pos*CFrame.new(-1.28056854e-09, -7.4505806e-09, 3.7252903e-09, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.38105711340904236, 0.38105711340904236, 0.1270190328359604),
		startpos = pos*CFrame.new(0.672518492, -0.778368652, -0.5398314, 0.707106769, -0.707106769, 0, 0.707106769, 0.707106769, 0, 0, 0, 1),
		Color = Color3.new(0.905882, 0.905882, 0.92549),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.38105708360671997, 0.38105708360671997, 0.1270190179347992),
		startpos = pos*CFrame.new(-0.672518492, -0.77836895, -0.5398314, 0.707106769, -0.707106769, 0, 0.707106769, 0.707106769, 0, 0, 0, 1),
		Color = Color3.new(0.905882, 0.905882, 0.92549),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(1.1643418073654175, 1.1643418073654175, 0.1058492586016655),
		startpos = pos*CFrame.new(-1.28056854e-09, -3.87430191e-07, 0.529246271, 0, -1, 0, 1, 0, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.1270190179347992, 0.38105708360671997, 0.1270190179347992),
		startpos = pos*CFrame.new(-0.852149367, -0.958001912, -0.5398314, 0.707106769, -0.707106769, 0, 0.707106769, 0.707106769, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.6350951194763184, 0.1270190179347992, 0.1270190179347992),
		startpos = pos*CFrame.new(-0.852150381, -0.598737001, -0.5398314, 0.707106769, -0.707106769, 0, 0.707106769, 0.707106769, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.6350951194763184, 0.6350951194763184, 0.1270190179347992),
		startpos = pos*CFrame.new(-0.672514498, -0.778369308, -0.412812442, 0.707106769, -0.707106769, 0, 0.707106769, 0.707106769, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.1270190179347992, 0.38105708360671997, 0.1270190179347992),
		startpos = pos*CFrame.new(-0.492885619, -0.598737776, -0.5398314, 0.707106769, -0.707106769, 0, 0.707106769, 0.707106769, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.6350951194763184, 0.1270190179347992, 0.1270190179347992),
		startpos = pos*CFrame.new(-0.492886633, -0.958001077, -0.5398314, 0.707106769, -0.707106769, 0, 0.707106769, 0.707106769, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.2116984724998474, 0.3440100848674774, 0.899718701839447),
		startpos = pos*CFrame.new(-1.16298139, -0.58397305, 0.540868402, 0.8415066, 0.353553414, -0.408494055, -0.12940976, 0.866025209, 0.482963413, 0.524518967, -0.353553295, 0.774519742),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.1270190179347992, 0.38105711340904236, 0.1270190328359604),
		startpos = pos*CFrame.new(0.492888629, -0.958001614, -0.5398314, 0.707106769, -0.707106769, 0, 0.707106769, 0.707106769, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.6350951790809631, 0.6350951790809631, 0.1270190328359604),
		startpos = pos*CFrame.new(0.672522545, -0.778369069, -0.412812442, 0.707106769, -0.707106769, 0, 0.707106769, 0.707106769, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.2116984724998474, 0.3440100848674774, 0.899718701839447),
		startpos = pos*CFrame.new(-0.90039134, -0.262174964, -0.0987738669, 0.8415066, 0.353553414, -0.408494055, -0.12940976, 0.866025209, 0.482963413, 0.524518967, -0.353553295, 0.774519742),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.2116984724998474, 0.3440100848674774, 0.899718701839447),
		startpos = pos*CFrame.new(0.873973787, -0.262174964, -0.0525679812, 0.875, -0.129409447, 0.466506779, -0.12940976, 0.866025209, 0.482963413, -0.46650669, -0.482962906, 0.741026044),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.2116984724998474, 0.3440100848674774, 0.899718701839447),
		startpos = pos*CFrame.new(1.01477587, -0.448634624, 0.155366063, 0.875, -0.129409447, 0.466506779, -0.12940976, 0.866025209, 0.482963413, -0.46650669, -0.482962906, 0.741026044),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.2116984724998474, 0.3440100848674774, 0.899718701839447),
		startpos = pos*CFrame.new(1.11138904, -0.556577206, 0.593421519, 0.875, -0.129409447, 0.466506779, -0.12940976, 0.866025209, 0.482963413, -0.46650669, -0.482962906, 0.741026044),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.2116984724998474, 0.3440100848674774, 0.899718701839447),
		startpos = pos*CFrame.new(-1.01006687, -0.448634624, 0.127131537, 0.8415066, 0.353553414, -0.408494055, -0.12940976, 0.866025209, 0.482963413, 0.524518967, -0.353553295, 0.774519742),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.6350951790809631, 0.1270190179347992, 0.1270190328359604),
		startpos = pos*CFrame.new(0.492886633, -0.598736703, -0.5398314, 0.707106769, -0.707106769, 0, 0.707106769, 0.707106769, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.6350951790809631, 0.1270190179347992, 0.1270190328359604),
		startpos = pos*CFrame.new(0.852151334, -0.958000839, -0.5398314, 0.707106769, -0.707106769, 0, 0.707106769, 0.707106769, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.1058492586016655, 1.1643418073654175, 1.1643418073654175),
		startpos = pos*CFrame.new(0.529247284, -7.4505806e-09, 3.7252903e-09, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.1270190179347992, 0.38105711340904236, 0.1270190328359604),
		startpos = pos*CFrame.new(0.852152348, -0.598737538, -0.5398314, 0.707106769, -0.707106769, 0, 0.707106769, 0.707106769, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.1058492586016655, 1.1643418073654175, 1.1643418073654175),
		startpos = pos*CFrame.new(-0.529247284, -7.4505806e-09, 3.7252903e-09, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.1058492586016655, 1.1643418073654175, 1.1643418073654175),
		startpos = pos*CFrame.new(-1.28056854e-09, -0.529246569, 3.7252903e-09, 0, -1, 0, 1, 0, 0, 0, 0, 1),
		Color = col,
		material = Enum.Material.Plastic,
		trans = 0,
	})
end
--
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
con = game:GetService("RunService").Heartbeat:Connect(function()
	hum:Move(charhum.MoveDirection,false)
	hum.Jump = charhum.Jump
	if tick()-lasttick > .1 then
		lasttick = tick()
		for i,v in pairs(fakechar:children()) do
			if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
				local s = v.Size
				local donot = false
				if v.Name == "Head" then
					s = v3(s.Z,s.Z,s.Z)
					donot = true
					renderModels.Dominus(v.CFrame,c3(0.05,0.05,0.15))
				end
				if donot == false then
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
	for i,v in pairs(fakechar:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
end)
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
	charhum:SetStateEnabled(Enum.HumanoidStateType.Seated,false) 
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
		char:PivotTo(humano.RootPart.CFrame*CFrame.new(humano.MoveDirection.X*4,0,humano.MoveDirection.Z*4))
		local opos = v:GetPivot()
		wait(.25)
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
--
local p = Instance.new'Part'
p.Parent = workspace
p.CFrame = cfn(0,4000000,0)
p.Anchored = true
p.Size = Vector3.new(100000,1,100000)
local resetBindable = Instance.new("BindableEvent")
resetBindable.Event:connect(function()
	lplr.Character = fakechar
	lplr.Character = char
	fakechar:Destroy()
	char:BreakJoints()
	plraddcon:Disconnect()
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
	con:Disconnect()
	con2:Disconnect(0)
	p:Destroy()
	ReloadChar()
	wait(1)
	char = lplr.Character
	wait()
	char:PivotTo(lastpos)
	getgenv().YO = false
end)
char = lplr.Character
charhum = char:FindFirstChildWhichIsA("Humanoid")
charhum.RootPart.Anchored = true
charhum:SetStateEnabled(Enum.HumanoidStateType.Seated,false) 
wait()
workspace.CurrentCamera.CameraSubject = hum
lplr.Character:PivotTo(cfn(0,4000005,0))
wait()
lplr.Character:PivotTo(cfn(0,4000005,0))
charhum.RootPart.Anchored = false
charhum.WalkSpeed = 0
getgenv()._upsilonLibrary.FireServer("becomeHostile")
game:GetService("StarterGui"):SetCore("ResetButtonCallback", resetBindable)
char = lplr.Character
charhum = char:FindFirstChildWhichIsA("Humanoid")
Player = lplr
PlayerGui = Player.PlayerGui
Cam = workspace.CurrentCamera
Backpack = Player.Backpack
Character = fakechar
Humanoid = Character.Humanoid
Mouse = lplr:GetMouse()
RootPart = Character["HumanoidRootPart"]
Torso = Character["Torso"]
Head = Character["Head"]
RightArm = Character["Right Arm"]
LeftArm = Character["Left Arm"]
RightLeg = Character["Right Leg"]
LeftLeg = Character["Left Leg"]
RootJoint = RootPart["RootJoint"]
Neck = Torso["Neck"]
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]
local sick = Instance.new("Sound",Character)
sick.SoundId = "rbxasset://songs/mnlibs/In the Final.ogg"
sick.Looped = true
sick.Pitch = 1
sick.Volume = 3
sick:Play()

IT = Instance.new
CF = cfn
VT = v3
RAD = math.rad
C3 = c3
UD2 = UDim2.new
BRICKC = bkc
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor

function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end

function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

--//=================================\\
--||          CUSTOMIZATION
--\\=================================//

Player_Size = 1 --Size of the player.
Animation_Speed = 3
Frame_Speed = 1 / 60 -- (1 / 30) OR (1 / 60)

local Speed = 16
local Effects2 = {}

--//=================================\\
--||      END OF CUSTOMIZATION
--\\=================================//

local function weldBetween(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = cfn()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end

--//=================================\\
--||          USEFUL VALUES
--\\=================================//

local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local CHANGEDEFENSE = 0
local CHANGEDAMAGE = 0
local CHANGEMOVEMENT = 0
local ANIM = "Idle"
local ATTACK = false
local EQUIPPED = false
local HOLD = false
local COMBO = 1
local Rooted = false
local SINE = 0
local KEYHOLD = false
local CHANGE = 2 / Animation_Speed
local WALKINGANIM = false
local WALK = 0
local VALUE1 = false
local VALUE2 = false
local ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
--ROBLOXIDLEANIMATION.Parent = Humanoid
local WEAPONGUI = IT("ScreenGui", PlayerGui)
WEAPONGUI.Name = "Weapon GUI"
local Effects = IT("Folder", Character)
Effects.Name = "Effects"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character.Animate
local HITPLAYERSOUNDS = {--[["199149137", "199149186", "199149221", "199149235", "199149269", "199149297"--]]"263032172", "263032182", "263032200", "263032221", "263032252", "263033191"}
local HITARMORSOUNDS = {"199149321", "199149338", "199149367", "199149409", "199149452"}
local HITWEAPONSOUNDS = {"199148971", "199149025", "199149072", "199149109", "199149119"}
local HITBLOCKSOUNDS = {"199148933", "199148947"}
local UNANCHOR = true

local SKILLTEXTCOLOR = C3(0.05,0.05,0.15)

--//=================================\\
--\\=================================//


--//=================================\\
--|| SAZERENOS' ARTIFICIAL HEARTBEAT
--\\=================================//
local script = Instance.new("Folder")
ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"

script:WaitForChild("ArtificialHB")

frame = Frame_Speed
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()

con2 = game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			script.ArtificialHB:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				script.ArtificialHB:Fire()
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

--//=================================\\
--\\=================================//





--//=================================\\
--||          SOME FUNCTIONS
--\\=================================//

function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function PositiveAngle(NUMBER)
	if NUMBER >= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function NegativeAngle(NUMBER)
	if NUMBER <= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end

function QuaternionFromCFrame(cf)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end

function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return cfn(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end

function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp;
	if cosTheta >= 0.0001 then
		if (1 - cosTheta) > 0.0001 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	else
		if (1 + cosTheta) > 0.0001 then
			local theta = ACOS(-cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((t - 1) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = t - 1
			finishInterp = t
		end
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end

function Clerp(a, b, t)
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end

function CreateFrame(PARENT, TRANSPARENCY, BORDERSIZEPIXEL, POSITION, SIZE, COLOR, BORDERCOLOR, NAME)
	local frame = IT("Frame")
	frame.BackgroundTransparency = TRANSPARENCY
	frame.BorderSizePixel = BORDERSIZEPIXEL
	frame.Position = POSITION
	frame.Size = SIZE
	frame.BackgroundColor3 = COLOR
	frame.BorderColor3 = BORDERCOLOR
	frame.Name = NAME
	frame.Parent = PARENT
	return frame
end

function CreateLabel(PARENT, TEXT, TEXTCOLOR, TEXTFONTSIZE, TEXTFONT, TRANSPARENCY, BORDERSIZEPIXEL, STROKETRANSPARENCY, NAME)
	local label = IT("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UD2(1, 0, 1, 0)
	label.Position = UD2(0, 0, 0, 0)
	label.TextColor3 = TEXTCOLOR
	label.TextStrokeTransparency = STROKETRANSPARENCY
	label.TextTransparency = TRANSPARENCY
	label.FontSize = TEXTFONTSIZE
	label.Font = TEXTFONT
	label.BorderSizePixel = BORDERSIZEPIXEL
	label.TextScaled = false
	label.Text = TEXT
	label.Name = NAME
	label.Parent = PARENT
	return label
end

function NoOutlines(PART)
	PART.TopSurface, PART.BottomSurface, PART.LeftSurface, PART.RightSurface, PART.FrontSurface, PART.BackSurface = 10, 10, 10, 10, 10, 10
end


function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = IT(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
end

function CreateSound(ID, PARENT, VOLUME, PITCH)
	local NEWSOUND = nil
	coroutine.resume(coroutine.create(function()
		NEWSOUND = IT("Sound", PARENT)
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id="..ID
		Swait()
		NEWSOUND:play()
		game:GetService("Debris"):AddItem(NEWSOUND, 10)
	end))
	return NEWSOUND
end

function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CF(at.x, at.y, at.z, right.x, top.x, back.x, right.y, top.y, back.y, right.z, top.z, back.z)
end

function CreateSwirl(SIZE,WAIT,CFRAME,DOESROT,ROT,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0.5, BRICKC(COLOR), "Effect", VT(0,0,0))
	wave.Color = COLOR
	local mesh = CreateMesh("SpecialMesh", wave, "FileMesh", "1051557", "", SIZE, VT(0,0,0))
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			mesh.Offset = VT(0,0,-(mesh.Scale.X/8))
			if DOESROT == true then
				wave.CFrame = wave.CFrame * CFrame.fromEulerAnglesXYZ(0,ROT,0)
			end
			wave.Transparency = wave.Transparency + (0.5/WAIT)
			if wave.Transparency > 0.99 then
				wave:Destroy()
			end
		end
	end))
end

function MagicSphere(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0, BRICKC(COLOR), "Effect", VT(1,1,1), true)
	wave.Color = COLOR
	local mesh = CreateMesh("SpecialMesh", wave, "Sphere", "", "", SIZE, VT(0,0,0))
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		local ls = tick()
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.Transparency = wave.Transparency + (1/WAIT)
			if tick()-ls > .09 then
				ls = tick()
				getgenv().FEEffects.Sphere({
					size = mesh.Scale,
					Color = COLOR,
					trans = wave.Transparency,
					startpos = CFRAME,
					material = wave.Material,
				})
			end
			if wave.Transparency > 0.99 then
				wave:Destroy()
			end
		end
	end))
end

function Slice(KIND,SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0.5, BRICKC(COLOR), "Effect", VT(1,1,1), true)
	local mesh = nil
	if KIND == "Base" then
		mesh = CreateMesh("SpecialMesh", wave, "FileMesh", "448386996", "", VT(0,SIZE/10,SIZE/10), VT(0,0,0))
	elseif KIND == "Thin" then
		mesh = CreateMesh("SpecialMesh", wave, "FileMesh", "662586858", "", VT(SIZE/10,0,SIZE/10), VT(0,0,0))
	elseif KIND == "Round" then
		mesh = CreateMesh("SpecialMesh", wave, "FileMesh", "662585058", "", VT(SIZE/10,0,SIZE/10), VT(0,0,0))
	end
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW/10
			wave.Transparency = wave.Transparency + (0.5/WAIT)
			if wave.Transparency > 0.99 then
				wave:Destroy()
			end
		end
	end))
end

function MakeForm(PART,TYPE)
	if TYPE == "Cyl" then
		local MSH = IT("CylinderMesh",PART)
	elseif TYPE == "Ball" then
		local MSH = IT("SpecialMesh",PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IT("SpecialMesh",PART)
		MSH.MeshType = "Wedge"
	end
end

function CheckTableForString(Table, String)
	for i, v in pairs(Table) do
		if string.find(string.lower(String), string.lower(v)) then
			return true
		end
	end
	return false
end

function CheckIntangible(Hit)
	local ProjectileNames = {"Water", "Arrow", "Projectile", "Effect", "Rail", "Lightning", "Bullet"}
	if Hit and Hit.Parent then
		if ((not Hit.CanCollide or CheckTableForString(ProjectileNames, Hit.Name)) and not Hit.Parent:FindFirstChild("Humanoid")) then
			return true
		end
	end
	return false
end

Debris = game:GetService("Debris")

function CastZapRay(StartPos, Vec, Length, Ignore, DelayIfHit)
	local Direction = cfn(StartPos, Vec).lookVector
	local Ignore = ((type(Ignore) == "table" and Ignore) or {Ignore})
	local RayHit, RayPos, RayNormal = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(StartPos, Direction * Length), Ignore)
	if RayHit and CheckIntangible(RayHit) then
		if DelayIfHit then
			wait()
		end
		RayHit, RayPos, RayNormal = CastZapRay((RayPos + (Vec * 0.01)), Vec, (Length - ((StartPos - RayPos).magnitude)), Ignore, DelayIfHit)
	end
	return RayHit, RayPos, RayNormal
end

function FireArc(Part,ToLocation,AmountOfTime,Height,DoesCourontine)
	if DoesCourontine == false then
		local Direction = CF(Part.Position,ToLocation)
		local Distance = (Part.Position - ToLocation).magnitude
		for i = 1, AmountOfTime do
			Swait()
			Part.CFrame = Direction*CF(0,(AmountOfTime/200)+((AmountOfTime/Height)-((i*2)/Height)),-Distance/AmountOfTime)
			Direction = Part.CFrame
		end
		Part:Destroy()
	elseif DoesCourontine == true then
		coroutine.resume(coroutine.create(function()
			local Direction = CF(Part.Position,ToLocation)
			local Distance = (Part.Position - ToLocation).magnitude
			for i = 1, AmountOfTime do
				Swait()
				Part.CFrame = Direction*CF(0,(AmountOfTime/200)+((AmountOfTime/Height)-((i*2)/Height)),-Distance/AmountOfTime)
				Direction = Part.CFrame
			end
			Part:Destroy()
		end))
	end
end

function turnto(position)
	RootPart.CFrame=cfn(RootPart.CFrame.p,VT(position.X,RootPart.Position.Y,position.Z)) * cfn(0, 0, 0)
end

--//=================================\\
--||         WEAPON CREATION
--\\=================================//

local naeeym2 = Instance.new("BillboardGui",Character)
naeeym2.AlwaysOnTop = true
naeeym2.Size = UDim2.new(5,35,2,15)
naeeym2.StudsOffset = v3(0,3,0)
naeeym2.Adornee = Character.Head
naeeym2.Name = "Name"
naeeym2.PlayerToHideFrom = Player
local tecks2 = Instance.new("TextLabel",naeeym2)
tecks2.BackgroundTransparency = 1
tecks2.TextScaled = true
tecks2.BorderSizePixel = 0
tecks2.Text = "Dominus Astra"
tecks2.Font = "Fantasy"
tecks2.TextSize = 30
tecks2.TextStrokeTransparency = 0
tecks2.TextColor3 = c3(0.05,0.05,0.15)
tecks2.TextStrokeColor3 = c3(0,0,0)
tecks2.Size = UDim2.new(1,0,0.5,0)
tecks2.Parent = naeeym2

function Transparency(TRANS)
	tecks2.TextTransparency = TRANS
	tecks2.TextStrokeTransparency = TRANS
	for _, c in pairs(Character:GetChildren()) do
		if c.ClassName == "Part" and c ~= RootPart then
			c.Transparency = TRANS
			if c:FindFirstChildOfClass("Decal") then
				c:FindFirstChildOfClass("Decal").Transparency = TRANS
			end
		elseif c.ClassName == "Accessory" then
			c.Handle.Transparency = TRANS
		elseif c.ClassName == "Model" then
			for _, q in pairs(c:GetChildren()) do
				if q.ClassName == "Part" then
					q.Transparency = TRANS
					if q:FindFirstChildOfClass("Decal") then
						q:FindFirstChildOfClass("Decal").Transparency = TRANS
					end
				end
			end
		end
	end
end

Humanoid.Died:connect(function()

end)

local SKILL1FRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.23, 0, 0.80, 0), UD2(0.26, 0, 0.07, 0), C3(0,0,0), C3(0, 0, 0), "Skill 1 Frame")
local SKILL2FRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.50, 0, 0.80, 0), UD2(0.26, 0, 0.07, 0), C3(0,0,0), C3(0, 0, 0), "Skill 2 Frame")
local SKILL3FRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.365, 0, 0.1, 0), UD2(0.26, 0, 0.07, 0), C3(0,0,0), C3(0, 0, 0), "Skill 3 Frame")
local SKILLEFRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.365, 0, 0.9, 0), UD2(0.26, 0, 0.07, 0), C3(0,0,0), C3(0, 0, 0), "Skill Warp Frame")

local SKILL1TEXT = CreateLabel(SKILL1FRAME, "[Z] Lunar Blast", SKILLTEXTCOLOR, 7, "Fantasy", 0, 2, 0, "Text 1")
local SKILL2TEXT = CreateLabel(SKILL2FRAME, "[B] Star Cutter", SKILLTEXTCOLOR, 7, "Fantasy", 0, 2, 0, "Text 2")
local SKILL3TEXT = CreateLabel(SKILL3FRAME, "[C] Supernova", SKILLTEXTCOLOR, 10, "Fantasy", 0, 2, 0, "Text 3")
local SKILLETEXT = CreateLabel(SKILLEFRAME, "[Q] Astral Hop", SKILLTEXTCOLOR, 7, "Fantasy", 0, 2, 0, "Text Warp")

--//=================================\\
--||            DAMAGING
--\\=================================//

function killnearest(position,range,maxstrength)
	for i,v in pairs(workspace:GetPartBoundsInRadius(position,range)) do
		if v.Parent:FindFirstChildWhichIsA("Humanoid") then
			dmg(v.Parent,math.huge)
		end
	end
end

--//=================================\\
--||    ATTACK FUNCTIONS AND STUFF
--\\=================================//

function Lunar_Blast()
	local HITBODIES = {}
	local CENTER = CreatePart(3, Effects, "SmoothPlastic", 0, 1, "Relly red", "CenterPart", VT(0,0,0))
	local HITFLOOR,ECH,NORMAL = Raycast(Mouse.Hit.p+VT(0,2,0), (CF(Mouse.Hit.p, Mouse.Hit.p + VT(0, -1, 0))).lookVector, 10000000, Character)
	CENTER.CFrame = CF(ECH)
	local RAY = CreatePart(3, Effects, "Neon", 0, 1, "Relly red", "Laser01", VT(25,99999,25))
	RAY.Color = C3(0.05,0.05,0.15)
	MakeForm(RAY,"Cyl")
	RAY.CFrame = CF(ECH)
	local ls = tick()
	for i = 1, 75 do
		Swait()
		RAY.Transparency = RAY.Transparency - 1/75
		RAY.Size = RAY.Size - VT(25/75,0,25/75)
		if tick()-ls > .06 then
			ls = tick()
			getgenv().FEEffects.Cylinder({
				size = VT(1000,RAY.Size.Y,RAY.Size.Z),
				Color = RAY.Color,
				startpos = RAY.CFrame*ANGLES(0,0,RAD(90)),
				trans = RAY.Transparency,
				material = RAY.Material,
			})
			MagicSphere(VT(1,1,1),15,CF(ECH)*CF(MRANDOM(-15,15),MRANDOM(0,100),MRANDOM(-15,15)),C3(1,1,1),VT(0,0,0))
		end
	end
	killnearest(ECH,25,25)
	MagicSphere(VT(0,0,0),55,CF(ECH),C3(0.05,0.05,0.15),VT(2,2,2))
	CreateSound("168586621", CENTER, 10, 0.8)
	RAY:Destroy()
	Debris:AddItem(CENTER,5)
end

function Star_Cutter()
	local HITFLOOR,HITPOS,NORMAL = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 7 * Player_Size, Character)
	if HITFLOOR ~= nil then
		ATTACK = true
		Rooted = true
		local GYRO = IT("BodyGyro",RootPart)
		GYRO.D = 100
		GYRO.P = 2000
		GYRO.MaxTorque = VT(0,4000000,0)
		GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
		CreateSound("429459101", RightArm, 10, 0.8)
		for i=0, 3.5, 0.1 / Animation_Speed do
			Swait()
			GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
			Slice("Thin",0.3,5,RightArm.CFrame * CF(0,-1.1,0) * ANGLES(RAD(MRANDOM(-180,180)),RAD(MRANDOM(-180,180)),RAD(MRANDOM(-180,180))),"Really red",VT(-0.01,0,-0.01))
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(-15 + 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 + 4.5 * SIN(SINE / 12)), RAD(0), RAD(15 - 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(-45), RAD(0 - 7.5 * SIN(SINE / 12)), RAD(32 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(5), RAD(0 + 7.5 * SIN(SINE / 12)), RAD(-12 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-7.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-7.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		GYRO:Destroy()
		for i=0, 0.15, 0.1 / Animation_Speed do
			Swait()
			GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
			Slice("Thin",0.3,5,RightArm.CFrame * CF(0,-1.1,0) * ANGLES(RAD(MRANDOM(-180,180)),RAD(MRANDOM(-180,180)),RAD(MRANDOM(-180,180))),"Really red",VT(-0.01,0,-0.01))
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(85 + 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 + 4.5 * SIN(SINE / 12)), RAD(0), RAD(-85 - 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(0 - 7.5 * SIN(SINE / 12)), RAD(90 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(5), RAD(0 + 7.5 * SIN(SINE / 12)), RAD(-12 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-7.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-7.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		local BOMBSPOTS = {}
		for i = 1, 25 do
			local SPOT = CreatePart(3, Effects, "Neon", 0, 0, "Relly blue", "Blade", VT(8,1,8))
			SPOT.Color = SKILLTEXTCOLOR
			SPOT.CFrame = RootPart.CFrame*CF((MRANDOM(-15,15)/40)*i,-5,-i*5)
			tinsert(BOMBSPOTS,SPOT)
			MakeForm(SPOT,"Cyl")
			getgenv().FEEffects.Cylinder({
				startpos = SPOT.CFrame*ANGLES(0,0,RAD(90)),
				size = VT(SPOT.Size.Y,SPOT.Size.X,SPOT.Size.Z),
				Color = SPOT.Color,
				material = SPOT.Material
			})
		end
		for i=0, 0.2, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(85 + 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 + 4.5 * SIN(SINE / 12)), RAD(0), RAD(-85 - 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(145), RAD(0 - 7.5 * SIN(SINE / 12)), RAD(-15 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(-25), RAD(0 + 7.5 * SIN(SINE / 12)), RAD(-12 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-7.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-7.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		ATTACK = false
		Rooted = false
		coroutine.resume(coroutine.create(function()
			Swait(3)
			for i = 1, #BOMBSPOTS do
				if BOMBSPOTS[i] ~= nil then
					local E = BOMBSPOTS[i]
					coroutine.resume(coroutine.create(function()
						local BLADE = CreatePart(3, Effects, "SmoothPlastic", 0, 1, "Relly blue", "Blade", VT(0,0,0))
						BLADE.Color = SKILLTEXTCOLOR
						CreateMesh("SpecialMesh", BLADE, "FileMesh", "93108071", "", VT(0.6,1,0.4)*3, VT(0,0,0))
						CreateSound(HITWEAPONSOUNDS[MRANDOM(1,#HITWEAPONSOUNDS)], BLADE, 4, 0.6)
						BLADE.CFrame = E.CFrame*CF(0,-3,0)*ANGLES(RAD(MRANDOM(-15,15)),RAD(90),RAD(MRANDOM(-15,15)))
						killnearest(BLADE.Position,6,80)
						local BLADEACTIVE = true
						local lasts = tick()
						task.spawn(function()
							while BLADEACTIVE do
								task.wait()
								if tick()-lasts > .06 then
									lasts = tick()
									getgenv().FEEffects.Part({
										startpos = BLADE.CFrame,
										size = VT(0.6,6,0.6)*3,
										Color = BLADE.Color,
										material = BLADE.Material,
										trans = BLADE.Transparency
									})
									getgenv().FEEffects.Cylinder({
										startpos = E.CFrame*ANGLES(0,0,RAD(90)),
										size = VT(E.Size.Y,E.Size.X,E.Size.Z),
										Color = E.Color,
										material = E.Material,
										trans = BLADE.Transparency
									})
								end
							end
						end)
						for i = 1, 10 do
							Swait()
							BLADE.CFrame = BLADE.CFrame*CF(0,0.3,0)
							BLADE.Transparency = BLADE.Transparency - 0.1
						end
						Swait(45)
						for i = 1, 100 do
							Swait()
							BLADE.Transparency = BLADE.Transparency + 0.01
							E.Transparency = E.Transparency + 0.01
						end
						BLADEACTIVE = false
						BLADE:Destroy()
						E:Destroy()
					end))
				end
			end
		end))
	end
end

function Supernova()
	local HITFLOOR,HITPOS,NORMAL = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 7 * Player_Size, Character)
	if HITFLOOR ~= nil then
		local HITBODIES = {}
		ATTACK = true
		Rooted = true
		local ABSOLUTE = CreatePart(3, Effects, "Neon", 0, 1, "Relly red", "Star", VT(0,0,0))
		MakeForm(ABSOLUTE,"Ball")
		CreateSound("429459101", ABSOLUTE, 10, 1)
		for i=0, 4, 0.1 / Animation_Speed do
			Swait()
			ABSOLUTE.Size = ABSOLUTE.Size + VT(0.2,0.2,0.2)
			ABSOLUTE.CFrame = RootPart.CFrame*CF(0,5+(ABSOLUTE.Size.Y/2),0)
			ABSOLUTE.Transparency = ABSOLUTE.Transparency - 0.01
			local CHARGE = CreatePart(3, Effects, "Neon", 0, 0, "Really red", "Star", VT(1,1,1))
			MakeForm(CHARGE,"Ball")
			CHARGE.Color = C3(1,1,1)
			CHARGE.CFrame = CF(RootPart.Position) * CF(MRANDOM(-15,15),-6,MRANDOM(-15,15))
			FireArc(CHARGE,ABSOLUTE.Position,45,45,true)
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(15 + 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-25 + 4.5 * SIN(SINE / 12)), RAD(25), RAD(-15 - 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 1.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(170), RAD(0 - 7.5 * SIN(SINE / 12)), RAD(-12 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(0 + 7.5 * SIN(SINE / 12)), RAD(-12 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-7.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-7.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		CreateSound("907330103", Head, 10, 1.2)
		for i = 1, 75 do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(15 + 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-25 + 4.5 * SIN(SINE / 12)), RAD(25), RAD(-15 - 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 1.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(170), RAD(0 - 7.5 * SIN(SINE / 12)), RAD(-12 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(0 + 7.5 * SIN(SINE / 12)), RAD(-12 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-7.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-7.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		coroutine.resume(coroutine.create(function()
			for i = 1, 13 do
				for e = 1, 8 do
					Swait()
					MagicSphere(VT(1,1,1),15,CF(ABSOLUTE.Position)*CF(MRANDOM(-45,45),MRANDOM(-45,45),MRANDOM(-45,45)),C3(1,1,1),VT(0,0,0))
					CreateSwirl(ABSOLUTE.Size/2,15,CF(HITPOS),true,15,BRICKC"Slime green".Color,VT(i,0.3,i)*2)
				end
				for i = 1, 5 do
					Slice("Round",0,35,CF(ABSOLUTE.Position)*ANGLES(RAD(MRANDOM(-18,18)),RAD(MRANDOM(-180,180)),RAD(MRANDOM(-18,18))),C3(1,1,1),VT(i,0,i)/3)
					Slice("Thin",i,55,ABSOLUTE.CFrame * CF(0,-1.1,0) * ANGLES(RAD(MRANDOM(-180,180)),RAD(MRANDOM(-180,180)),RAD(MRANDOM(-180,180))),C3(1,0,0),VT(0,0,0))
				end
				CreateSwirl(ABSOLUTE.Size/2,25,CF(ABSOLUTE.Position),true,-25,BRICKC"Relly red".Color,VT(i,i*2,i))
				CreateSwirl(ABSOLUTE.Size/2,55,CF(ABSOLUTE.Position),true,25,C3(0.05,0.05,0.15),VT(i,i*2,i))
				CreateSound("168586621", ABSOLUTE, 4, 0.8)
				CreateSound("201858144", ABSOLUTE, 10, 0.8)
				killnearest(ABSOLUTE.Position,i*18,i)
				ABSOLUTE.Size = ABSOLUTE.Size*0.9
				MagicSphere(ABSOLUTE.Size,25,CF(ABSOLUTE.Position),BRICKC"Relly red".Color,VT(i,i,i)/1.1)
				MagicSphere(ABSOLUTE.Size,45,CF(ABSOLUTE.Position),C3(0.05,0.05,0.15),VT(i,i,i))
			end
			ABSOLUTE.Transparency = 1
			Debris:AddItem(ABSOLUTE,10)
		end))
		ATTACK = false
		Rooted = false
	end
end

local Decal = IT("Decal")

function Astral_Hop()
	ATTACK = true
	Rooted = false
	local O1 = CreatePart(3, Effects, "Neon", 0, 1, "Really black", "Warphole", VT(0,0,0))
	O1.CFrame = RootPart.CFrame*CF(0,0,-3)*ANGLES(RAD(90),RAD(0),RAD(0))
	local decal = Decal:Clone()
	decal.Parent = O1
	decal.Face = "Top"
	decal.Texture = "http://www.roblox.com/asset/?id=349165228"
	local decal2 = Decal:Clone()
	decal2.Parent = O1
	decal2.Face = "Bottom"
	decal2.Texture = "http://www.roblox.com/asset/?id=349165228"
	local O2 = CreatePart(3, Effects, "Neon", 0, 1, "Really black", "Warphole", VT(0,0,0))
	local POS = VT(RootPart.Position.X,Mouse.Hit.p.Y+6,RootPart.Position.Z)
	O2.CFrame = CF(Mouse.Hit.p+VT(0,6,0),POS)*ANGLES(RAD(90),RAD(0),RAD(0))
	local ROOT = CreatePart(3, Effects, "Neon", 0, 1, "Really black", "Warphole", VT(0,0,0))
	ROOT.CFrame = CF(O2.Position,RootPart.Position)
	local decal = Decal:Clone()
	decal.Parent = O2
	decal.Face = "Top"
	decal.Texture = "http://www.roblox.com/asset/?id=349165228"
	local decal2 = Decal:Clone()
	decal2.Parent = O2
	decal2.Face = "Bottom"
	decal2.Texture = "http://www.roblox.com/asset/?id=349165228"
	CreateSound("84005018", O1, 10, 0.7)
	CreateSound("84005018", O2, 10, 0.7)
	local PORTALACTIVE = true
	local lasts = tick()
	task.spawn(function()
		while PORTALACTIVE do
			task.wait()
			if tick()-lasts > .06 then
				lasts = tick()
				getgenv().FEEffects.Part({
					startpos = O1.CFrame,
					size = O1.Size,
					Color = O1.Color,
					material = O1.Material,
					trans = O1.Transparency
				})
				getgenv().FEEffects.Part({
					startpos = O2.CFrame,
					size = O2.Size,
					Color = O2.Color,
					material = O2.Material,
					trans = O2.Transparency
				})
			end
		end
	end)
	for i = 1, 75 do
		Swait()
		O1.Size = O1.Size + VT(0.1,0,0.1)
		O1.CFrame = RootPart.CFrame*CF(0,0,-3)*ANGLES(RAD(90),RAD(i),RAD(0))
		O2.Size = O2.Size + VT(0.1,0,0.1)
		O2.CFrame = O2.CFrame*ANGLES(RAD(0),RAD(i),RAD(0))
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(5 + 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 + 4.5 * SIN(SINE / 12)), RAD(0), RAD(-5 - 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(90), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(5 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(90), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(-5 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	Rooted = true
	UNANCHOR = false
	RootPart.Anchored = true
	VALUE1 = true
	for i = 1, 15 do
		Transparency(i/15)
		Swait()
		RootPart.CFrame = RootPart.CFrame*CF(0,0,-0.13)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(16 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(5 + 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-15 + 4.5 * SIN(SINE / 12)), RAD(0), RAD(-5 - 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(-15), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(5 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(-15), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(-5 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	RootPart.CFrame = ROOT.CFrame
	ROOT:Destroy()
	for i = 1, 15 do
		Transparency(1-(i/15))
		Swait()
		RootPart.CFrame = RootPart.CFrame*CF(0,0,-0.5)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(16 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(5 + 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-15 + 4.5 * SIN(SINE / 12)), RAD(0), RAD(-5 - 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(-15), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(5 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(-15), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(-5 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	VALUE1 = false
	coroutine.resume(coroutine.create(function()
		for i = 1, 75 do
			Swait()
			O1.Size = O1.Size - VT(0.1,0,0.1)
			O1.CFrame = O1.CFrame*ANGLES(RAD(0),RAD(i),RAD(0))
			O2.Size = O2.Size - VT(0.1,0,0.1)
			O2.CFrame = O2.CFrame*ANGLES(RAD(0),RAD(i),RAD(0))
		end
		PORTALACTIVE = false
		O1:Destroy()
		O2:Destroy()
	end))

	UNANCHOR = true
	RootPart.Anchored = false
	ATTACK = false
	Rooted = false
end

--//=================================\\
--||      ASSIGN THINGS TO KEYS
--\\=================================//

function MouseDown(Mouse)
	if ATTACK == false then
	end
end

function MouseUp(Mouse)
	HOLD = false
end

function KeyDown(Key)
	KEYHOLD = true
	if Key == "z" and ATTACK == false then
		Lunar_Blast()
	end

	if Key == "b" and ATTACK == false then
		Star_Cutter()
	end

	if Key == "c" and ATTACK == false then
		--Supernova()
	end

	if Key == "q" and ATTACK == false then
		Astral_Hop()
	end
end

function KeyUp(Key)
	KEYHOLD = false
end

Mouse.Button1Down:connect(function(NEWKEY)
	MouseDown(NEWKEY)
end)
Mouse.Button1Up:connect(function(NEWKEY)
	MouseUp(NEWKEY)
end)
Mouse.KeyDown:connect(function(NEWKEY)
	KeyDown(NEWKEY)
end)
Mouse.KeyUp:connect(function(NEWKEY)
	KeyUp(NEWKEY)
end)

--//=================================\\
--\\=================================//


function unanchor()
	if UNANCHOR == true then
		g = Character:GetChildren()
		for i = 1, #g do
			if g[i].ClassName == "Part" then
				g[i].Anchored = false
			end
		end
	end
end


--//=================================\\
--||    WRAP THE WHOLE SCRIPT UP
--\\=================================//

Humanoid.Changed:connect(function(Jump)
	if Jump == "Jump" and (Disable_Jump == true) then
		Humanoid.Jump = false
	end
end)

Humanoid.HipHeight = 2
Head:ClearAllChildren()
local FF = IT("ForceField",Character)
FF.Visible = false
Speed = 35

sick.Parent = Character

while true do
	Swait()
	ANIMATE.Parent = nil
	SINE = SINE + CHANGE
	local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.y
	local LV = Torso.CFrame:pointToObjectSpace(Torso.Velocity - Torso.Position)
	local HITFLOOR,HITPOS,NORMAL = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 7 * Player_Size, Character)
	if ATTACK == false then
		if TORSOVELOCITY < 1 then
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(5 + 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 + 4.5 * SIN(SINE / 12)), RAD(0), RAD(-5 - 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(5 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(-5 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		elseif TORSOVELOCITY > 1 then
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(25 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(5 + 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-25 + 4.5 * SIN(SINE / 12)), RAD(0), RAD(-5 - 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(-25), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(15 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(-25), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(-15 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-25-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	end
	unanchor()
	Humanoid.MaxHealth = "inf"
	Humanoid.Health = "inf"
	if Rooted == false then
		Disable_Jump = false
		Humanoid.WalkSpeed = Speed
	elseif Rooted == true then
		Disable_Jump = true
		Humanoid.WalkSpeed = 0
	end
	for _, c in pairs(Character:GetChildren()) do
		if c.ClassName == "Part" then
			c.Material = "Neon"
			if c:FindFirstChildOfClass("ParticleEmitter") then
				c:FindFirstChildOfClass("ParticleEmitter"):Destroy()
			end
			if c == Torso then
				c.Color = C3(0,0,0)
			elseif c == RightArm then
				c.Color = C3(0.05,0.05,0.15)
			elseif c == LeftArm then
				c.Color = C3(0.05,0.05,0.15)
			elseif c == RightLeg then
				c.Color = C3(0,0,0.05)
			elseif c == LeftLeg then
				c.Color = C3(0,0,0.05)
			elseif c == Head then
				if c:FindFirstChild("Dominus") == nil then
					local M = CreateMesh("SpecialMesh", c, "FileMesh", "162384581", "162384608", VT(1,1,1)*1.1, VT(0,0,0))
					M.Name = "Dominus"
				end
				if c:FindFirstChild("face") then
					c.face:Destroy()
				end
			end
		elseif c.ClassName == "Shirt" or c.ClassName == "Pants" or c.ClassName == "CharacterMesh" or c.ClassName == "Accessory" or c.Name == "Body Colors" then
			c:Destroy()
		end
	end
	FOUNDFORGOTTEN = false
	Humanoid.DisplayDistanceType = "None"
	if FOUNDFORGOTTEN == true then
		sick:Stop()
	else
		sick.Playing = true
	end
end

--//=================================\\
--\\=================================//





--//====================================================\\--
--||                     END OF SCRIPT
--\\====================================================/
