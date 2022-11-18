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
local it = false
local renderModels = {
	Shedo = function(pos)
		renderPart({
			size = v3(1.1, 0.6, 0.2),
			material = "SmoothPlastic",
			Color = bkc("Bright red").Color,
			startpos = pos*cfn(-0.65, 0.5, -1.5),
		})
		renderPart({
			size = v3(0.4, 0.25, 1.5),
			Color = bkc("Really black").Color,
			material = "SmoothPlastic",
			startpos = pos*cfn(1.4, 0.675, -0.85),
		})
		renderPart({
			size = v3(0.2, 0.15, 0.2),
			Color = bkc("Really black").Color,
			material = "SmoothPlastic",
			startpos = pos*cfn(0, 0.725, -1.5),
		})
		renderPart({
			size = v3(1.1, 0.6, 0.2),
			Color = bkc("Bright red").Color,
			material = "SmoothPlastic",
			startpos = pos*cfn(0.65, 0.5, -1.5),
		})
		renderPart({
			size = v3(0.4, 0.25, 1.5),
			Color = bkc("Really black").Color,
			material = "SmoothPlastic",
			startpos = pos*cfn(-1.4, 0.675, -0.85),
		})
	end,
	FShedo = function(pos)
		renderPart({
			size = v3(1.1, 0.6, 0.2),
			material = "SmoothPlastic",
			Color = bkc("Bright red").Color,
			startpos = pos*cfn(-0.65, 0, -0.65),
		})
		renderPart({
			size = v3(0.4, 0.25, 1.5),
			Color = bkc("Really black").Color,
			material = "SmoothPlastic",
			startpos = pos*cfn(1.4, 0.175, 0),
		})
		renderPart({
			size = v3(0.2, 0.15, 0.2),
			Color = bkc("Really black").Color,
			material = "SmoothPlastic",
			startpos = pos*cfn(0, 0.225, -0.65),
		})
		renderPart({
			size = v3(1.1, 0.6, 0.2),
			Color = bkc("Bright red").Color,
			material = "SmoothPlastic",
			startpos = pos*cfn(0.65, 0, -0.65),
		})
		renderPart({
			size = v3(0.4, 0.25, 1.5),
			Color = bkc("Really black").Color,
			material = "SmoothPlastic",
			startpos = pos*cfn(-1.4, 0.175, 0),
		})
	end,
}
renderModels.leg = function(pos,col)
	renderPart({
		size = Vector3.new(3.049999952316284, 6.050000190734863, 3.049999952316284),
		startpos = pos*CFrame.new(0, -0.0125000477, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
end
renderModels.arm = function(pos,col)
	renderPart({
		size = Vector3.new(3.0899999141693115, 0.6000000238418579, 3.0899999141693115),
		startpos = pos*CFrame.new(0, -2.01250005, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.972549, 0.972549, 0.972549),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(3.049999952316284, 5.050000190734863, 3.049999952316284),
		startpos = pos*CFrame.new(0, 0.487499952, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
end
renderModels.tors = function(pos,col)
	renderPart({
		size = Vector3.new(2.0500001907348633, 3.450000286102295, 3.049999952316284),
		startpos = pos*CFrame.new(0, -1.30055225, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(2.0500001907348633, 6.050000190734863, 0.04999995231628418),
		startpos = pos*CFrame.new(0, -0.000552177429, 1.5, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(2.9200000762939453, 6.019999980926514, 3.0199999809265137),
		startpos = pos*CFrame.new(-1.54999924, -0.000552415848, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.972549, 0.972549, 0.972549),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(4.519999980926514, 6.019999980926514, 0.019999980926513672),
		startpos = pos*CFrame.new(-0.75, -0.000552415848, -1.5, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.972549, 0.972549, 0.972549),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(2.3199996948242188, 2.119999885559082, 0.9199999570846558),
		startpos = pos*CFrame.new(-0.0499992371, 1.94944787, -0.25, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.972549, 0.972549, 0.972549),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(2.1500000953674316, 6.050000190734863, 3.049999952316284),
		startpos = pos*CFrame.new(-1.95000076, -0.000552415848, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.5199999809265137, 3.109999656677246, 0.029999999329447746),
		startpos = pos*CFrame.new(0, 0.949447393, -1.5, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.105882, 0.164706, 0.207843),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.6000000238418579, 0.5099999904632568, 0.029999999329447746),
		startpos = pos*CFrame.new(0, 2.74944711, -1.5, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.105882, 0.164706, 0.207843),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(4.550000190734863, 1.1500000953674316, 3.049999952316284),
		startpos = pos*CFrame.new(0.655445099, 0.691090345, 0, 0.342020154, -0.939692497, 0, 0.939692497, 0.342020154, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(4.550000190734863, 1.1500000953674316, 3.049999952316284),
		startpos = pos*CFrame.new(-0.644561768, 0.691090345, 0, 0.342020035, 0.939692616, 0, -0.939692616, 0.342020035, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(2.0500001907348633, 0.05000019073486328, 1.75),
		startpos = pos*CFrame.new(0, 2.99944854, 0.649995804, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(2.9200000762939453, 6.019999980926514, 3.0199999809265137),
		startpos = pos*CFrame.new(1.54999924, -0.000552415848, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.972549, 0.972549, 0.972549),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(2.1500000953674316, 6.050000190734863, 3.049999952316284),
		startpos = pos*CFrame.new(1.95000076, -0.000552415848, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
end
renderModels.introface = function(pos,col)
	renderPart({
		size = Vector3.new(0.22499994933605194, 0.32500001788139343, 0.39999985694885254),
		startpos = pos*CFrame.new(-0.237510681, 0.512499332, -1.35439301, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.22499996423721313, 0.29999998211860657, 0.39999985694885254),
		startpos = pos*CFrame.new(0.262489319, 0.524999142, -1.35439301, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.44999995827674866, 0.05000000074505806, 0.39999985694885254),
		startpos = pos*CFrame.new(-0.250009537, 0.699999332, -1.35439301, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.4249999523162842, 0.04999998211860657, 0.39999985694885254),
		startpos = pos*CFrame.new(0.287490845, 0.699999094, -1.35439301, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.29999998211860657, 0.07499997317790985, 0.39999985694885254),
		startpos = pos*CFrame.new(0.321357727, -0.525187969, -1.35439301, 0.965925813, 0.258819044, 0, -0.258819044, 0.965925813, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.29999998211860657, 0.07499997317790985, 0.39999985694885254),
		startpos = pos*CFrame.new(-0.325576782, -0.525187969, -1.35439301, 0.965925813, -0.258819044, 0, 0.258819044, 0.965925813, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.3999999761581421, 0.07499998062849045, 0.39999985694885254),
		startpos = pos*CFrame.new(-0.00210952759, -0.488554955, -1.35439301, 0.99999994, 0, 0, 0, 0.99999994, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.19999997317790985, 0.04999998211860657, 0.39999985694885254),
		startpos = pos*CFrame.new(0.0228919983, -0.626054883, -1.35439301, 0.99999994, 0, 0, 0, 0.99999994, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
end
renderModels.face = function(pos,col)
	renderPart({
		size = Vector3.new(0.7249999046325684, 0.07499998807907104, 0.39999985694885254),
		startpos = pos*CFrame.new(0.0124912262, -0.237500787, -1.35552025, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.07499987632036209, 0.42499998211860657, 0.39999985694885254),
		startpos = pos*CFrame.new(0.410531998, -0.467310905, -1.35552025, 0.965925813, -0.258819044, 0, 0.258819044, 0.965925813, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.07499987632036209, 0.42499998211860657, 0.39999985694885254),
		startpos = pos*CFrame.new(-0.389467239, -0.467310905, -1.35552025, 0.965925813, 0.258819044, 0, -0.258819044, 0.965925813, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.4249998927116394, 0.04999999329447746, 0.39999985694885254),
		startpos = pos*CFrame.new(-0.256017685, -0.603128612, -1.35552025, 0.965925813, -0.258819044, 0, 0.258819044, 0.965925813, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.4249998927116394, 0.04999999329447746, 0.39999985694885254),
		startpos = pos*CFrame.new(0.243982315, -0.603128672, -1.35552025, 0.965925813, 0.258819044, 0, -0.258819044, 0.965925813, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.1749999225139618, 0.04999999329447746, 0.39999985694885254),
		startpos = pos*CFrame.new(-5.53131104e-05, -0.55783534, -1.35552025, 0.99999994, 0, 0, 0, 0.99999994, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.12499988824129105, 0.12499996274709702, 0.39999985694885254),
		startpos = pos*CFrame.new(0.367839813, -0.464075565, -1.35552025, 0.707106709, -0.707106769, 0, 0.707106769, 0.707106709, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.09999988228082657, 0.2749999761581421, 0.39999985694885254),
		startpos = pos*CFrame.new(0.398458481, -0.51884234, -1.35552025, 0.965925694, -0.258819044, 0, 0.258819044, 0.965925694, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.12499988824129105, 0.09999996423721313, 0.39999985694885254),
		startpos = pos*CFrame.new(0.357013702, -0.407825589, -1.35552025, 0.499999911, -0.866025329, 0, 0.866025329, 0.499999911, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.12499988824129105, 0.09999996423721313, 0.39999985694885254),
		startpos = pos*CFrame.new(-0.346334457, -0.407825589, -1.35552025, -0.499999911, 0.866025329, 0, 0.866025329, 0.499999911, 0, 0, 0, -1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.12499988824129105, 0.12499996274709702, 0.39999985694885254),
		startpos = pos*CFrame.new(-0.357160568, -0.464075565, -1.35552025, -0.707106709, 0.707106769, 0, 0.707106769, 0.707106709, 0, 0, 0, -1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.09999988228082657, 0.2749999761581421, 0.39999985694885254),
		startpos = pos*CFrame.new(-0.401540756, -0.51884234, -1.35552025, 0.965925694, 0.258818984, 0, -0.258818984, 0.965925694, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.09999996423721313, 0.3499999940395355, 0.39999985694885254),
		startpos = pos*CFrame.new(-0.197841644, 0.856502533, -1.35552025, -0.258818984, -0.965925813, 0, -0.965925813, 0.258818984, 0, -0, 0, -1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.09999996423721313, 0.15000000596046448, 0.39999985694885254),
		startpos = pos*CFrame.new(-0.431966782, 0.89999938, -1.35552025, 5.96046448e-08, -1, 0, -1, -5.96046448e-08, 0, 0, 0, -1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.19999995827674866, 0.3499999940395355, 0.39999985694885254),
		startpos = pos*CFrame.new(-0.249990463, 0.599999189, -1.35552025, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.09999996423721313, 0.3499999940395355, 0.39999985694885254),
		startpos = pos*CFrame.new(0.197841644, 0.856502533, -1.35552025, -0.258818984, 0.965925813, 0, 0.965925813, 0.258818984, 0, 0, 0, -1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.09999996423721313, 0.15000000596046448, 0.39999985694885254),
		startpos = pos*CFrame.new(0.431968689, 0.89999938, -1.35552025, 5.96046448e-08, 1, 0, 1, -5.96046448e-08, 0, 0, 0, -1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
	renderPart({
		size = Vector3.new(0.19999995827674866, 0.3499999940395355, 0.39999985694885254),
		startpos = pos*CFrame.new(0.249990463, 0.599999189, -1.35552025, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Color = Color3.new(0.0666667, 0.0666667, 0.0666667),
		material = Enum.Material.Plastic,
		trans = 0,
	})
end
--
local fakechar = game:GetService("Players"):CreateHumanoidModelFromDescription(Instance.new("HumanoidDescription"),"R6")
local lastpos = lplr.Character:GetPivot()
fakechar:PivotTo(lastpos)
fakechar.Parent = workspace
lplr.Character:PivotTo(cfn(0,100,0))
wait()
local con
local hum = fakechar:FindFirstChildWhichIsA("Humanoid")
local charhum = lplr.Character:FindFirstChildWhichIsA("Humanoid")
local lasttick = tick()
local FakeHead
con = game:GetService("RunService").Heartbeat:Connect(function()
	hum:Move(charhum.MoveDirection,false)
	hum.Jump = charhum.Jump
	if tick()-lasttick > .1 then
		lasttick = tick()
		for i,v in pairs(fakechar:children()) do
			if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and v.Name ~= "Ring" and v.Name ~= "HolShot" and v.Name ~= "HolPist" then
				local s = v.Size
				if v.Name == "Head" then
					s = v3(s.Z,s.Z,s.Z)
					if FakeHead then
						if it then
							--renderModels.face(FakeHead.CFrame)
						else
							--renderModels.introface(FakeHead.CFrame)
						end
					end
				end
				if v.Name == "Torso" then
					renderModels.tors(v.CFrame,c3())
				end
				if v.Name:find("Arm") then
					renderModels.arm(v.CFrame,c3())
				end
				if v.Name:find("Leg") then
					renderModels.leg(v.CFrame,c3())
				end
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
					if v.Name:find("Leg") == nil and v.Name:find("Torso") == nil then
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
function dodmg(v,d)
	if v == fakechar then return end
	task.spawn(function()
		local humano = v:FindFirstChildOfClass("Humanoid")
		if not humano then return end
		lplr.Character:PivotTo(humano.RootPart.CFrame*cfn(humano.MoveDirection.X*4,0,2+humano.MoveDirection.Z*4))
		local opos = v:GetPivot()
		wait(.25)
		getgenv()._upsilonLibrary.FireServer("dealMeleeDamage", humano, d)
		lplr.Character:PivotTo(cfn(0,700010,0))
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
	char:PivotTo(cfn(0,4005,0))
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
p.CFrame = cfn(0,700000,0)
p.Anchored = true
p.Size = v3(100000,1,100000)
local resetBindable = Instance.new("BindableEvent")
local plraddcon
plraddcon = lplr.CharacterAdded:Connect(function(c)
	c:WaitForChild("Humanoid")
	char = lplr.Character
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
wait()
workspace.CurrentCamera.CameraSubject = hum
lplr.Character:PivotTo(cfn(0,700010,0))
wait()
lplr.Character:PivotTo(cfn(0,700010,0))
charhum.RootPart.Anchored = false
charhum.WalkSpeed = 0
getgenv()._upsilonLibrary.FireServer("becomeHostile")
game:GetService("StarterGui"):SetCore("ResetButtonCallback", resetBindable)
char = lplr.Character
charhum = char:FindFirstChildWhichIsA("Humanoid")
---
local script = Instance.new('Folder')
---------------
--Agent Agony--
----------------------------------------------------------------
--By CKbackup (Sugarie Saffron)                               --
--YT: https://www.youtube.com/channel/UC8n9FFz7e6Zo13ob_5F9MJw--
--Discord: Sugarie Saffron#4705                               --
----------------------------------------------------------------

print([[
--Agent Agony--
By CKbackup (Sugarie Saffron)                               
YT: https://www.youtube.com/channel/UC8n9FFz7e6Zo13ob_5F9MJw
Discord: Sugarie Saffron#4705    
--------------------------------
As I've been demoted from my SB
Mod rank in VSB, I don't see the
need to hold this back any longer.

Also, if the anims look weird or
the weapon looks out of place,
it's because it's actually modeled
off a scaled rig with a package.
It looks better with the Boy
package.
--------------------------------
(Keys)
M - Mute/Play Music

-Common Keys-
F - Kick
V - Stomp
T - Equip/Unequip Pistol
Y - Equip/Unequip Shotgun

-CQC (no weapon)-
Click - Kick
Z - Smash (AoE attack)
X - Grab (to throw a player)
C - Head Rip and Throw

-Pistol-
Click - Shoot

-Shotgun-
Click - Shoot
Z - Load a Slug
(this makes the next shotgun
shot single, powerful, and
accurate)
]])

wait(1/60)
Effects = { }
local Player = lplr
local chara = fakechar
local Humanoid = chara:FindFirstChildOfClass("Humanoid")
local Mouse = Player:GetMouse()
local LeftArm = chara["Left Arm"]
local RightArm = chara["Right Arm"]
local LeftLeg = chara["Left Leg"]
local RightLeg = chara["Right Leg"]
local Head = chara.Head
local Torso = chara.Torso
local Camera = workspace.CurrentCamera
local RootPart = chara.HumanoidRootPart
local RootJoint = RootPart.RootJoint
local attack = false
local Anim = 'Idle'
local attacktype = 1
local delays = false
local play = true
local targetted = nil
local Torsovelocity = (RootPart.Velocity * v3(1, 0, 1)).magnitude 
local velocity = RootPart.Velocity.y
local sine = 0
local change = 1
local doe = 0
local Create = function(class)
	return function(l)
		local inst = Instance.new(class)
		for i,v in pairs(l) do
			pcall(function()
				inst[i] = v
			end)
		end
		return inst
	end
end
local debby = game:GetService("Debris")
local CurrentWep = "CQC"
Humanoid.WalkSpeed = 8

Humanoid.Animator.Parent = nil
chara.Animate.Parent = nil

local newMotor = function(part0, part1, c0, c1)
	local w = Create('Motor'){
		Parent = part0,
		Part0 = part0,
		Part1 = part1,
		C0 = c0,
		C1 = c1,
	}
	return w
end

function clerp(a, b, t)
	return a:lerp(b, t)
end

RootCF = CFrame.fromEulerAnglesXYZ(-1.57, 0, 3.14)
NeckCF = cfn(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)

LeftArm.Size = LeftArm.Size * 3
RightArm.Size = RightArm.Size * 3
LeftLeg.Size = LeftLeg.Size * 3
RightLeg.Size = RightLeg.Size * 3
Torso.Size = Torso.Size * 3
Head.Size = Head.Size * 3
RootPart.Size = RootPart.Size * 3

local RW = newMotor(Torso, RightArm, cfn(4.5, 0, 0), cfn(0, 0, 0)) 
local LW = newMotor(Torso, LeftArm, cfn(-4.5, 0, 0), cfn(0, 0, 0))
local Neck = newMotor(Torso, Head, cfn(0,4.5,0), cfn())
local RH = newMotor(Torso, RightLeg, cfn(1.5, -3, 0), cfn(0, 0, 0))
local LH = newMotor(Torso, LeftLeg, cfn(-1.5, -3, 0), cfn(0, 0, 0))
local RootJoint = newMotor(RootPart, Torso, cfn(0,-2,0), cfn(0,-2,0))

local rarmc1 = RW.C1
local larmc1 = LW.C1
local rlegc1 = RH.C1
local llegc1 = LH.C1

local resetc1 = false

function PlayAnimationFromTable(table, speed, bool)
	RootJoint.C0 = clerp(RootJoint.C0, table[1], speed) 
	Neck.C0 = clerp(Neck.C0, table[2], speed) 
	RW.C0 = clerp(RW.C0, table[3], speed) 
	LW.C0 = clerp(LW.C0, table[4], speed) 
	RH.C0 = clerp(RH.C0, table[5], speed) 
	LH.C0 = clerp(LH.C0, table[6], speed) 
	if bool == true then
		if resetc1 == false then
			resetc1 = true
			RootJoint.C1 = RootJoint.C1
			Neck.C1 = Neck.C1
			RW.C1 = rarmc1
			LW.C1 = larmc1
			RH.C1 = rlegc1
			LH.C1 = llegc1
		end
	end
end

ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "Heartbeat"
script:WaitForChild("Heartbeat")
frame = 0.03333333333333
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.Heartbeat:Fire()
con2 = game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			script.Heartbeat:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				script.Heartbeat:Fire()
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
function swait(num)
	if num == 0 or num == nil then
		ArtificialHB.Event:wait()
	else
		for i = 0, num do
			ArtificialHB.Event:wait()
		end
	end
end

function RemoveOutlines(part)
	part.TopSurface, part.BottomSurface, part.LeftSurface, part.RightSurface, part.FrontSurface, part.BackSurface = 10, 10, 10, 10, 10, 10
end

function so(id,par,pit,vol)
	local sou = Instance.new("Sound", par or workspace)
	if par == chara then
		sou.Parent = chara.Torso
	end
	sou.Volume = vol
	sou.Pitch = pit or 1
	sou.SoundId = "rbxassetid://" .. id
	sou.PlayOnRemove = true
	sou:Destroy()
end

--This is just for builds--
New = function(Object, Parent, Name, Data)
	local Object = Instance.new(Object)
	for Index, Value in pairs(Data or {}) do
		Object[Index] = Value
	end
	Object.Parent = Parent
	Object.Name = Name
	return Object
end
FakeHeadM = New("Model",chara,"FakeHeadM",{})
FakeHead = New("Part",FakeHeadM,"FakeHead",{Size = v3(6, 3, 3),CFrame = cfn(26.5, 1.5, -49.8000183, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,})
Mesh = New("SpecialMesh",FakeHead,"Mesh",{Scale = v3(1.25, 1.25, 1.25),})
Fays = New("Decal",FakeHead,"Decal",{Texture = "rbxassetid://315622231",})
Weld = New("ManualWeld",FakeHead,"Weld",{Part0 = FakeHead,Part1 = Head,})
Shedo = New("Part",FakeHeadM,"Shedo",{Transparency = 1,FormFactor = Enum.FormFactor.Symmetric,Size = v3(1, 1, 1),CFrame = cfn(26.5000114, 2.19999933, -50.2999916, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,})
Mesh = New("SpecialMesh",Shedo,"Mesh",{Scale = v3(3, 3, 3),VertexColor = v3(1, 0, 0),MeshId = "rbxassetid://18755442",TextureId = "rbxassetid://65032890",MeshType = Enum.MeshType.FileMesh,})
Weld = New("ManualWeld",Shedo,"Weld",{Part0 = Shedo,Part1 = FakeHead,C1 = cfn(1.14440918e-05, 0.699999332, -0.499973297, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Head.Transparency = 1
Humanoid.CameraOffset = v3(0,3,0)

Shotii = New("Model",chara,"Shotii",{})
SHandaru = New("Part",Shotii,"SHandaru",{Transparency = 1,Transparency = 1,Size = v3(0.299999952, 0.299999923, 0.299999803),CFrame = cfn(82.7000122, 8.4184885, -48.6482887, 0, 0, 1, -0.173647001, 0.984807968, 0, -0.984807968, -0.173647001, 0),CanCollide = false,BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,})
Mesh = New("SpecialMesh",SHandaru,"Mesh",{Scale = v3(0.00400000019, 0.00400000019, 0.00400000019),MeshId = "rbxassetid://450250994",TextureId = "rbxassetid://450251128",MeshType = Enum.MeshType.FileMesh,})
Weld = New("ManualWeld",SHandaru,"Weld",{Part0 = SHandaru,Part1 = RightArm,C0 = cfn(0, 0, 0, 0, -0.173647001, -0.984807968, 0, 0.984807968, -0.173647001, 1, 0, 0),C1 = cfn(0.292991638, -7.6862278, -0.349998474, 0.984807849, -0.030152997, -0.171009988, 0.173647955, 0.17100893, 0.969846547, 4.55671426e-07, -0.984807968, 0.173646942),})
SShot = New("Part",Shotii,"SShot",{Transparency = 1,Transparency = 1,Size = v3(0.299999952, 0.299999923, 0.299999803),CFrame = cfn(82.7000122, 8.3150301, -54.4179688, 0, 0, 1, -0.173647001, 0.984807968, 0, -0.984807968, -0.173647001, 0),CanCollide = false,BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,})
Weld = New("ManualWeld",SShot,"Weld",{Part0 = SShot,Part1 = SHandaru,C0 = cfn(0, 0, 0, 0, -0.173647001, -0.984807968, 0, 0.984807968, -0.173647001, 1, 0, 0),C1 = cfn(5.69999313, 0.900001526, 0, 0, -0.173647001, -0.984807968, 0, 0.984807968, -0.173647001, 1, 0, 0),})
SSExit = New("Part",Shotii,"SSExit",{Transparency = 1,Transparency = 1,Size = v3(0.299999952, 0.299999923, 0.299999803),CFrame = cfn(83.0000076, 9.67517471, -46.1282616, 0, 0, 1, -0.173647001, 0.984807968, 0, -0.984807968, -0.173647001, 0),CanCollide = false,BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,})
Weld = New("ManualWeld",SSExit,"Weld",{Part0 = SSExit,Part1 = SHandaru,C0 = cfn(0, 0, 0, 0, -0.173647001, -0.984807968, 0, 0.984807968, -0.173647001, 1, 0, 0),C1 = cfn(-2.69996262, 0.799999237, 0.299995422, 0, -0.173647001, -0.984807968, 0, 0.984807968, -0.173647001, 1, 0, 0),})

Pistoru = New("Model",chara,"Pistoru",{})
PHandaru = New("Part",Pistoru,"PHandaru",{Transparency = 1,Transparency = 1,Size = v3(0.299999952, 0.299999923, 0.299999803),CFrame = cfn(90.3498764, 9.52873039, -33.8800735, -0.984808445, -0.171009943, 0.0301536396, -0.173648074, 0.969846964, -0.171010002, -2.58755817e-09, -0.173648193, -0.984807789),CanCollide = false,BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,})
Mesh = New("SpecialMesh",PHandaru,"Mesh",{Scale = v3(0.00400000019, 0.00400000019, 0.00400000019),MeshId = "rbxassetid://437242703",TextureId = "rbxassetid://437242708",MeshType = Enum.MeshType.FileMesh,})
Weld = New("ManualWeld",PHandaru,"Weld",{Part0 = PHandaru,Part1 = RightArm,C0 = cfn(0, 0, 0, -0.984808445, -0.173648074, -2.58755817e-09, -0.171009943, 0.969846964, -0.173648193, 0.0301536396, -0.171010002, -0.984807789),C1 = cfn(-0.450126648, -4.80198288, -0.307024956, 1, 0, 0, 0, 0.173647985, 0.984807849, 0, -0.984807849, 0.173647985),})
PBExit = New("Part",Pistoru,"PBExit",{Transparency = 1,Transparency = 1,Size = v3(0.299999952, 0.299999923, 0.299999803),CFrame = cfn(90.1265717, 10.7951508, -33.49757, -0.984809041, -0.171010062, 0.0301536396, -0.173648193, 0.96984756, -0.171010002, 0, -0.173648298, -0.984807789),CanCollide = false,BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,})
Weld = New("ManualWeld",PBExit,"Weld",{Part0 = PBExit,Part1 = PHandaru,C0 = cfn(0, 0, 0, -0.984807849, -0.173647985, 0, -0.173647985, 0.984807849, 0, 0, 0, -1),C1 = cfn(0, 1.19999886, -0.599994659, -0.984808326, -0.173648059, 0, -0.173648059, 0.984808326, 0, 0, 0, -1),})
PShot = New("Part",Pistoru,"PShot",{Transparency = 1,Transparency = 1,Size = v3(0.299999952, 0.299999923, 0.299999803),CFrame = cfn(90.2109985, 10.3163252, -36.2550163, -0.984808803, -0.171010002, 0.0301536396, -0.173648134, 0.969847322, -0.171010002, -2.58755906e-09, -0.173648253, -0.984807789),CanCollide = false,BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,})
Weld = New("ManualWeld",PShot,"Weld",{Part0 = PShot,Part1 = PHandaru,C0 = cfn(0, 0, 0, -0.984807968, -0.173648, 0, -0.173648, 0.984807968, 0, 0, 0, -1),C1 = cfn(0, 1.19999886, 2.19998932, -0.984807968, -0.173648, 0, -0.173648, 0.984807968, 0, 0, 0, -1),})

HolShot = New("Part",chara,"HolShot",{Size = v3(0.299999952, 0.299999923, 0.299999803),CFrame = cfn(52.4309196, 10.2762518, -23.0499916, -0.499998987, -0.866025984, 0, -0.866025984, 0.499998987, 0, 0, 0, -1),CanCollide = false,BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,})
Mesh = New("SpecialMesh",HolShot,"Mesh",{Scale = v3(0.00400000019, 0.00400000019, 0.00400000019),MeshId = "rbxassetid://450250994",TextureId = "rbxassetid://450251128",MeshType = Enum.MeshType.FileMesh,})
Weld = New("ManualWeld",HolShot,"Weld",{Part0 = HolShot,Part1 = Torso,C0 = cfn(0, 0, 0, -0.499998987, -0.866025984, 0, -0.866025984, 0.499998987, 0, 0, 0, -1),C1 = cfn(1.33091354, 1.2762394, 1.65000534, 1, 0, 0, 0, 1, 0, 0, 0, 1),})

HolPist = New("Part",chara,"HolPist",{Size = v3(0.299999952, 0.299999923, 0.299999803),CFrame = cfn(70.7500153, 5.34207106, -26.6475906, -1, 0, 0, 0, 0.642789185, -0.766043186, 0, -0.766043186, -0.642789185),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,})
Mesh = New("SpecialMesh",HolPist,"Mesh",{Scale = v3(0.00400000019, 0.00400000019, 0.00400000019),MeshId = "rbxassetid://437242703",TextureId = "rbxassetid://437242708",MeshType = Enum.MeshType.FileMesh,})
Weld = New("ManualWeld",HolPist,"Weld",{Part0 = HolPist,Part1 = Torso,C0 = cfn(0, 0, 0, -1, 0, 0, 0, 0.642789185, -0.766043186, 0, -0.766043186, -0.642789185),C1 = cfn(2.45001984, -3.72772598, 0.233430862, 1, 0, 0, 0, 0.984807849, -0.173647985, 0, 0.173647985, 0.984807849),})

Instance.new("BoolValue",chara).Name = "HolyMode"
local hedcol = FakeHead.BrickColor
local bcols = Instance.new("BodyColors",chara)
bcols.Name = "NeoCols"
bcols.HeadColor = hedcol
bcols.LeftArmColor = hedcol
bcols.RightArmColor = hedcol
bcols.TorsoColor = hedcol
bcols.LeftLegColor = hedcol
bcols.RightLegColor = hedcol

for i, v in pairs(chara:children()) do
	if v:IsA("Shirt") or v:IsA("Pants") then
		v:Destroy()
	end
end
local sh = Instance.new("Shirt",chara)
local pn = Instance.new("Pants",chara)
sh.ShirtTemplate = "rbxassetid://676428254"
pn.PantsTemplate = "rbxassetid://676428351"
if chara:FindFirstChild("FaysG") then chara:FindFirstChild("FaysG"):Destroy() end
---------------------------

function rayCast(Position, Direction, Range, Ignore)
	return game:service("Workspace"):FindPartOnRay(Ray.new(Position, Direction.unit * (Range or 999.999)), Ignore) 
end 

function FindNearestTorso(Position, Distance, SinglePlayer)
	if SinglePlayer then
		return (SinglePlayer.Head.CFrame.p - Position).magnitude < Distance
	end
	local List = {}
	for i, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Model") then
			if v:findFirstChild("Head") then
				if v ~= chara then
					if (v.Head.Position - Position).magnitude <= Distance then
						tinsert(List, v)
					end 
				end 
			end 
		end 
	end
	return List
end

EffectModel = Create("Model"){
	Parent = chara,
	Name = "Effects",
}

--Effect Functions--
Effects = {

	Block = function(cf,partsize,meshstart,meshadd,matr,colour,spin,inverse,factor)
		local p = Instance.new("Part",EffectModel)
		p.BrickColor = bkc(colour)
		p.Size = partsize
		p.Anchored = true
		p.CanCollide = false
		p.Material = matr
		p.CFrame = cf
		if inverse == true then
			p.Transparency = 1
		else
			p.Transparency = 0
		end
		local m = Instance.new("BlockMesh",p)
		m.Scale = meshstart
		coroutine.wrap(function()
			for i=0,1,factor do
				swait()
				if inverse == true then
					p.Transparency = 1-i
				else
					p.Transparency = i
				end
				m.Scale = m.Scale + meshadd
				if spin == true then
					p.CFrame = p.CFrame * CFrame.Angles(math.random(-50,50),math.random(-50,50),math.random(-50,50))
				end
			end
			p:Destroy()
		end)()
		return p
	end,

	Sphere = function(cf,partsize,meshstart,meshadd,matr,colour,inverse,factor)
		local p = Instance.new("Part",EffectModel)
		p.BrickColor = bkc(colour)
		p.Size = partsize
		p.Anchored = true
		p.CanCollide = false
		p.Material = matr
		p.CFrame = cf
		if inverse == true then
			p.Transparency = 1
		else
			p.Transparency = 0
		end
		local m = Instance.new("SpecialMesh",p)
		m.MeshType = "Sphere"
		m.Scale = meshstart
		coroutine.wrap(function()
			for i=0,1,factor do
				swait()
				if inverse == true then
					p.Transparency = 1-i
				else
					p.Transparency = i
				end
				m.Scale = m.Scale + meshadd
			end
			p:Destroy()
		end)()
		return p
	end,

	Cylinder = function(cf,partsize,meshstart,meshadd,matr,colour,inverse,factor)
		local p = Instance.new("Part",EffectModel)
		p.BrickColor = bkc(colour)
		p.Size = partsize
		p.Anchored = true
		p.CanCollide = false
		p.Material = matr
		p.CFrame = cf
		if inverse == true then
			p.Transparency = 1
		else
			p.Transparency = 0
		end
		local m = Instance.new("CylinderMesh",p)
		m.Scale = meshstart
		coroutine.wrap(function()
			for i=0,1,factor do
				swait()
				if inverse == true then
					p.Transparency = 1-i
				else
					p.Transparency = i
				end
				m.Scale = m.Scale + meshadd
			end
			p:Destroy()
		end)()
		return p
	end,

	Wave = function(cf,meshstart,meshadd,colour,spin,inverse,factor)
		local p = Instance.new("Part",EffectModel)
		p.BrickColor = bkc(colour)
		p.Size = v3()
		p.Anchored = true
		p.CanCollide = false
		p.CFrame = cf
		if inverse == true then
			p.Transparency = 1
		else
			p.Transparency = 0
		end
		local m = Instance.new("SpecialMesh",p)
		m.MeshId = "rbxassetid://20329976"
		m.Scale = meshstart
		coroutine.wrap(function()
			for i=0,1,factor do
				swait()
				if inverse == true then
					p.Transparency = 1-i
				else
					p.Transparency = i
				end
				m.Scale = m.Scale + meshadd
				p.CFrame = p.CFrame * CFrame.Angles(0,math.rad(spin),0)
			end
			p:Destroy()
		end)()
		return p
	end,

	Ring = function(cf,meshstart,meshadd,colour,inverse,factor)
		local p = Instance.new("Part",EffectModel)
		p.BrickColor = bkc(colour)
		p.Size = v3()
		p.Anchored = true
		p.CanCollide = false
		p.CFrame = cf
		if inverse == true then
			p.Transparency = 1
		else
			p.Transparency = 0
		end
		local m = Instance.new("SpecialMesh",p)
		m.MeshId = "rbxassetid://3270017"
		m.Scale = meshstart
		coroutine.wrap(function()
			for i=0,1,factor do
				swait()
				if inverse == true then
					p.Transparency = 1-i
				else
					p.Transparency = i
				end
				m.Scale = m.Scale + meshadd
			end
			p:Destroy()
		end)()
		return p
	end,

	Meshed = function(cf,meshstart,meshadd,colour,meshid,textid,spin,inverse,factor)
		local p = Instance.new("Part",EffectModel)
		p.BrickColor = bkc(colour)
		p.Size = v3()
		p.Anchored = true
		p.CanCollide = false
		p.CFrame = cf
		if inverse == true then
			p.Transparency = 1
		else
			p.Transparency = 0
		end
		local m = Instance.new("SpecialMesh",p)
		m.MeshId = meshid
		m.TextureId = textid
		m.Scale = meshstart
		coroutine.wrap(function()
			for i=0,1,factor do
				swait()
				if inverse == true then
					p.Transparency = 1-i
				else
					p.Transparency = i
				end
				m.Scale = m.Scale + meshadd
				p.CFrame = p.CFrame * CFrame.Angles(0,math.rad(spin),0)
			end
			p:Destroy()
		end)()
		return p
	end,

	Explode = function(cf,partsize,meshstart,meshadd,matr,colour,move,inverse,factor)
		local p = Instance.new("Part",EffectModel)
		p.BrickColor = bkc(colour)
		p.Size = partsize
		p.Anchored = true
		p.CanCollide = false
		p.Material = matr
		p.CFrame = cf * CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
		if inverse == true then
			p.Transparency = 1
		else
			p.Transparency = 0
		end
		local m = Instance.new("SpecialMesh",p)
		m.MeshType = "Sphere"
		m.Scale = meshstart
		coroutine.wrap(function()
			for i=0,1,factor do
				swait()
				if inverse == true then
					p.Transparency = 1-i
				else
					p.Transparency = i
				end
				m.Scale = m.Scale + meshadd
				p.CFrame = p.CFrame * cfn(0,move,0)
			end
			p:Destroy()
		end)()
		return p
	end,

}

function chatfunc(text)
	coroutine.wrap(function()
		if chara:FindFirstChild("TalkingBillBoard")~= nil then
			chara:FindFirstChild("TalkingBillBoard"):destroy()
		end
		local naeeym2 = Instance.new("BillboardGui",chara)
		naeeym2.Size = UDim2.new(0,100,0,40)
		naeeym2.StudsOffset = v3(0,3,0)
		naeeym2.Adornee = chara.Head
		naeeym2.Name = "BLABLABLA"
		local tecks2 = Instance.new("TextLabel",naeeym2)
		tecks2.BackgroundTransparency = 1
		tecks2.BorderSizePixel = 0
		tecks2.Text = ""
		tecks2.Font = "Antique"
		tecks2.FontSize = "Size24"
		tecks2.TextStrokeTransparency = 0
		tecks2.TextColor3 = c3(0,0,0)
		tecks2.TextStrokeColor3 = c3(1,0,0)
		tecks2.Size = UDim2.new(1,0,0.5,0)coroutine.wrap(function()
			while tecks2 ~= nil do
				swait()
				tecks2.Position = UDim2.new(0,math.random(-3,3),0,math.random(-3,3))
			end
		end)()
		for i = 1,string.len(text),1 do
			tecks2.Text = string.sub(text,1,i)
			swait()
		end
		swait(30)
		for i = 1, 5 do
			swait()
			tecks2.Position = tecks2.Position - UDim2.new(0,0,.05,0)
			tecks2.TextStrokeTransparency = tecks2.TextStrokeTransparency +.2
			tecks2.TextTransparency = tecks2.TextTransparency + .2
		end
		naeeym2:Destroy()
	end)()
end

function GetDudesTorso(c)
	local torsy = (c:findFirstChild("Torso") or c:findFirstChild("UpperTorso"))
	if torsy ~= nil then
		return torsy
	end
end

function BodyVel(part,faws)
	local bodyvel = Instance.new("BodyVelocity",part)
	local pep = 10000000
	bodyvel.P = pep
	bodyvel.MaxForce = v3(pep,pep,pep)
	bodyvel.Velocity = faws
	debby:AddItem(bodyvel,.2)
end

function Dmg(dude,dmg,env,faws,trip,efftyp,toim)
	if dude and dude ~= chara then
		if dude:FindFirstChild("HITO") then return end
		local debounce = Instance.new("BoolValue",dude)
		debounce.Name = "HITO"
		debby:AddItem(debounce,toim)
		local hum = dude:FindFirstChildOfClass("Humanoid")
		local dam = dmg+math.random(-env,env)
		local teksu = "-"..dam
		if hum then
			local finhel = hum.Health - dam
			if finhel <= 0 and dude:FindFirstChild("DEATHED")==nil then
				Instance.new("BoolValue",dude).Name = "DEATHED"
				local soaa = Instance.new("Sound",dude.Head)
				local cho = math.random(1,5)
				if cho == 1 then
					soaa.SoundId = "rbxassetid://111896685"
				elseif cho == 2 then
					soaa.SoundId = "rbxassetid://535528169"
				elseif cho == 3 then
					soaa.SoundId = "rbxassetid://1080363252"
				elseif cho == 4 then
					soaa.SoundId = "rbxassetid://147758746"
				elseif cho == 5 then
					soaa.SoundId = "rbxassetid://626777433"
					soaa.Volume = .2
					soaa.TimePosition = 1
				end
				game:service'Debris':AddItem(soaa,6)
				soaa:Play()
			end
			if hum.Health > 1000 then
				teksu = "DEATH"
				dodmg(dude,1000)
			else
				dodmg(dude,dam)
			end
		end
		coroutine.wrap(function()
			local naeeym2 = Instance.new("BillboardGui",dude)
			naeeym2.Size = UDim2.new(0,100,0,40)
			naeeym2.StudsOffset = v3(0,3,0)
			naeeym2.Adornee = dude:FindFirstChild("Head")
			naeeym2.Name = "TalkingBillBoard"
			local tecks2 = Instance.new("TextLabel",naeeym2)
			tecks2.BackgroundTransparency = 1
			tecks2.BorderSizePixel = 0
			tecks2.Text = teksu
			tecks2.Font = "Antique"
			tecks2.TextSize = 24
			tecks2.TextStrokeTransparency = 0
			tecks2.TextColor3 = c3(0,0,0)
			tecks2.TextStrokeColor3 = c3(1,0,0)
			tecks2.Size = UDim2.new(1,0,0.5,0)
			swait(10)
			for i = 0,1,.05 do
				swait()
				tecks2.Position = tecks2.Position - UDim2.new(0,0,.005,0)
				tecks2.TextStrokeTransparency = i
				tecks2.TextTransparency = i
			end
			naeeym2:Destroy()
		end)()
		local torsy = GetDudesTorso(dude)
		if torsy then
			for i=1,dam/5 do
				local blp = Instance.new("Part",EffectModel)
				blp.Size = v3(.3,.3,.3)
				blp.BrickColor = bkc("Crimson")
				blp.CFrame = torsy.CFrame*CFrame.Angles(math.random(-50,50),math.random(-50,50),math.random(-50,50))
				blp.Velocity = torsy.CFrame.lookVector*math.random(-8,-8) + torsy.CFrame.rightVector*math.random(-8,8) + v3(0,math.random(0,5),0)
				blp.RotVelocity = v3(math.random(-15,15),math.random(-15,15),math.random(-15,15))
				--local blm = Instance.new("SpecialMesh",blp)
				--blm.MeshType = "Sphere"
				coroutine.wrap(function()
					swait(10)
					blp.Orientation = v3(0,blp.Orientation.y,0)
					for i=0,1,.1  do
						swait()
						blp.Transparency = i
						blp.Size = blp.Size + v3(.05,-.05,.05)
					end
					blp:Destroy()
				end)()
			end
			if efftyp == "Blunt" then
				puncheff(torsy)
			elseif efftyp == "Sharp" then
				slasheff(torsy)
			elseif efftyp == "Shot" then
				so(144884872,torsy,.9,1)
			end
			if faws ~= 0 then
				BodyVel(torsy,faws)
			end
			if trip == true then
				torsy.CFrame = torsy.CFrame * CFrame.Angles(math.rad(-90),0,0)
				torsy.RotVelocity = v3(math.random(-50,50),math.random(-50,50),math.random(-50,50))
			end
		end
	end
end

function MagnitudeDmg(par,magni,dmg,env,faws,trip,efftyp,toim)
	for _, c in pairs(workspace:GetPartBoundsInRadius(par.Position,magni)) do
		local hum = c.Parent:FindFirstChildOfClass("Humanoid")
		if hum ~= nil and c.Parent:FindFirstChild("IsTeamMateOfCK")==nil then
			local head = GetDudesTorso(c.Parent)
			if head ~= nil then
				local targ = head.Position - par.Position
				local mag = targ.magnitude
				if magni >= mag and c.Parent ~= chara then
					Dmg(c.Parent,dmg,env,faws,trip,efftyp,toim)
				end
			end
		end
	end
end

function CamShake(par,magni,env,dur)
	coroutine.wrap(function()
		for i=0,dur*60 do
			swait()
			Humanoid.CameraOffset = v3(math.random(-(env*10),(env*10))/10,3+math.random(-(env*10),(env*10))/10,math.random(-(env*10),(env*10))/10)
		end
		Humanoid.CameraOffset = v3(0,3,0)
	end)()
end

function puncheff(par)
	if par.Parent:FindFirstChild("DebounceHit")==nil then
		so(386946017,par,math.random(6,8)/10,1)
		local bla = Effects.Sphere(par.CFrame,v3(1,1,1),v3(1,1,1),v3(1,1,1),"Neon","White",false,.1)
		CamShake(bla,10,.5,.5)
	end
end

function slasheff(par)
	if par.Parent:FindFirstChild("DebounceHit")==nil then
		local cho = math.random(1,3)
		if cho == 1 then
			so(444667824,par,1,1)
		elseif cho == 2 then
			so(444667844,par,1,1)
		elseif cho == 3 then
			so(444667859,par,1,1)
		end
		--function(cf,partsize,meshstart,meshadd,matr,colour,factor)
		Effects.Sphere(par.CFrame*CFrame.Angles(math.random(0,360),math.random(0,360),math.random(0,360)),v3(.5,.5,.5),v3(1,0,1),v3(0,5,0),"Neon","Really red",false,.1)
	end
end

local mus = Instance.new("Sound",chara)
mus.Name = "mus"
mus.SoundId = "rbxasset://songs/mnlibs/In the Final.ogg"--"rbxassetid://335204822"
mus.Looped = true
mus.Volume = .3
mus:Play()

Humanoid.MaxHealth = 1000
Humanoid.Health = 1000

------------------Intro-----------------------
intro = true
local IntroDone = false
if intro == true then
	coroutine.wrap(function()
		attack = true
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		PlayAnimationFromTable({		
			cfn(0, 233.999924, -1.90734863e-06, 1, 0, 0, 0, -1, 0, 0, 0, -1),
			cfn(0, 3.6000421, 1.07246542, 1, 0, 0, 0, 0.76604414, -0.642788053, 0, 0.642788053, 0.76604414),
			cfn(3.6967864, -0.452571809, 0, 0.939692736, 0.342019886, 0, -0.342019916, 0.939692736, 0, 0, 0, 1),
			cfn(-3.60279894, -0.418379426, 0, 0.939692736, -0.342019886, 0, 0.342019916, 0.939692736, 0, 0, 0, 1),
			cfn(1.50001526, -4, -1.3000021, 1, 0, 0, 0, 1, 0, 0, 0, 1),
			cfn(-1.50001526, -6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		}, 1, false)
		swait(120)
		for i=0,1,.1 do
			swait()
			PlayAnimationFromTable({		
				cfn(0, -1.00005245, -1.90734863e-06, 1, 0, 0, 0, -1, 0, 0, 0, -1),
				cfn(0, 3.60004878, 1.07246184, 1, 0, 0, 0, 0.76604414, -0.642788053, 0, 0.642788053, 0.76604414),
				cfn(3.69677114, -0.452568352, 0, 0.939692736, 0.342019886, 0, -0.342019916, 0.939692736, 0, 0, 0, 1),
				cfn(-3.60280585, -0.418371797, 0, 0.939692736, -0.342019886, 0, 0.342019916, 0.939692736, 0, 0, 0, 1),
				cfn(1.50001526, -3.99999714, -1.3000021, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				cfn(-1.50001526, -6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
			}, .4, false)
		end
		so(133680244,Torso,1,3)
		CamShake(Torso,20,.8,.6)
		MagnitudeDmg(Torso,15,30,3,v3(0,20,0)+RootPart.CFrame.lookVector*60,true,"Blunt",.5)
		Effects.Wave(RootPart.CFrame*cfn(0,-5,0),v3(),v3(2,1,2),"",10,false,.02)
		Effects.Wave(RootPart.CFrame*cfn(0,-5,0),v3(),v3(1.5,2.5,1.5),"",-10,false,.02)
		local hit,hitpos = rayCast(RootPart.Position,v3(0,-1,0),15,chara)
		for i = 1,12 do
			local size = math.random(7,10)
			local p = Instance.new("Part",EffectModel)
			p.BrickColor = hit.BrickColor
			p.Material = hit.Material
			p.Size = v3(size,size,size)
			p.CFrame = cfn(hitpos) * CFrame.fromEulerAnglesXYZ(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360)))
			p.CanCollide = false
			p.Velocity = v3(math.random(-70,70),170,math.random(-70,70))
			p.RotVelocity = v3(math.random(-60,60),math.random(-60,60),math.random(-60,60))
			coroutine.wrap(function()
				swait(20)
				p.CanCollide = true
				swait(120)
				for i=0,1,.05 do
					swait()
					p.Transparency = i
				end
				p:Destroy()
			end)()
		end
		mus.Volume = 1
		mus:Play()
		RootPart.Anchored = true
		for i=0,6,.1 do
			swait()
			PlayAnimationFromTable({		
				cfn(0, -2.53941131, -0.348767281, 1, 0, 0, 0, 0.76604414, 0.642788053, 0, -0.642788053, 0.76604414),
				cfn(0, 4.57664824, -0.666416466, 1, 0, 0, 0, 0.939692438, 0.34202075, 0, -0.34202075, 0.939692438),
				cfn(4.5000205, 1.20001018, 2.22187964e-06, 0.866024792, -0.500001192, 8.88577006e-07, 0.500001252, 0.866024733, -1.28149986e-06, -1.49011612e-07, 1.54972076e-06, 1),
				cfn(-4.5000205, 1.20001018, 2.22187964e-06, 0.866024792, 0.500001192, -8.88577006e-07, -0.500001252, 0.866024733, -1.28149986e-06, 1.49011612e-07, 1.54972076e-06, 1),
				cfn(1.50001526, -3.52529287, -3.56594658, 1, 0, 0, 0, 0.76604414, -0.642788053, 0, 0.642788053, 0.76604414),
				cfn(-1.50001526, -5.99999619, 6.67572112e-06, 1, 0, 0, 0, 1.00000012, 0, 0, 0, 1.00000012),
			}, .4, false)
		end
		RootPart.Anchored = false
		for i=0,2,.1 do
			swait()
			PlayAnimationFromTable({		
				cfn(0, -1.99700248, -0.27749458, 1, 0, 0, 0, 0.984807849, 0.173647985, 0, -0.173647985, 0.984807849),
				cfn(0, 4.55108547, -0.444281816, 1, 0, 0, 0, 0.939692676, 0.342020601, 0, -0.342020601, 0.939692676),
				cfn(3.77304196, -0.53539288, 0.273614407, 0.939692736, 0.321393579, 0.116977744, -0.342019945, 0.883022368, 0.321393698, -8.56816769e-08, -0.342020065, 0.939692795),
				cfn(-4.64490843, 0.330175281, -1.53582289e-06, 0.984807849, 0.173648134, -3.13053391e-07, -0.173648164, 0.984807909, 2.68220901e-07, 3.50177288e-07, -1.78813934e-07, 1.00000012),
				cfn(1.50001884, -5.99037027, -0.421832889, 0.984807849, 0, -0.173647985, -0.0301536229, 0.984807849, -0.171009898, 0.171009898, 0.173647985, 0.969846487),
				cfn(-1.50002635, -5.99037027, -0.421831638, 0.984807849, 0, 0.173647985, 0.0301536229, 0.984807849, -0.171009898, -0.171009898, 0.173647985, 0.969846487),
			}, .15, false)
		end
		local FShedo = New("Part",chara,"FShedo",{FormFactor = Enum.FormFactor.Symmetric,Size = v3(1, 1, 1),CFrame = cfn(63.4999924, 14.1999693, -2.70000529, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,})
		local FMesh = New("SpecialMesh",FShedo,"Mesh",{Scale = v3(3, 3, 3),VertexColor = v3(1, 0, 0),MeshId = "http://www.roblox.com/asset/?id=18755442",TextureId = "http://www.roblox.com/asset/?id=65032890",MeshType = Enum.MeshType.FileMesh,})
		local FWeld = New("ManualWeld",FShedo,"FWeld",{Part0 = FShedo,Part1 = RightArm,C1 = cfn(-1.46309662, -4.28805161, -0.213977814, 0.478137165, 0.217331067, -0.850971282, 0.74204433, -0.618283033, 0.259029716, -0.469845891, -0.755310178, -0.456893384),})
		local ls = tick()
		for i=0,4,.1 do
			swait()
			if tick()-ls > .09 then
				ls = tick()
				renderModels.FShedo(FShedo.CFrame)
			end
			PlayAnimationFromTable({		
				cfn(0, -2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				cfn(0, 4.49995232, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				cfn(3.7809577, 2.70507407, -0.632092118, 0.478137165, 0.74204433, -0.469845891, 0.217331067, -0.618283033, -0.755310178, -0.850971282, 0.259029716, -0.456893384),
				cfn(-4.89282131, 0.675060272, 0, 0.939692736, 0.342019886, 0, -0.342019916, 0.939692736, 0, 0, 0, 1),
				cfn(1.50001168, -6, -1.01327896e-06, 0.939692736, 0, -0.342019886, 0, 1, 0, 0.342019916, 0, 0.939692736),
				cfn(-1.50001526, -6, 2.98023224e-07, 0.939692736, 0, 0.342019886, 0, 1, 0, -0.342019916, 0, 0.939692736),
			}, .15, false)
		end
		Fays.Texture = "rbxassetid://58425273"
		FShedo:Destroy()
		Shedo.Transparency = 0
		Humanoid.WalkSpeed = 8
		Humanoid.JumpPower = 70
		attack = false
		IntroDone = true
	end)()
end
--------------------------------------------------

function smek()
	attack = true
	Humanoid.WalkSpeed = 2
	Humanoid.JumpPower = 0
	for i=0,1,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(0, -1.73551273, -0.521830797, 1, 0, 0, 0, 0.939692736, 0.342019886, 0, -0.342019916, 0.939692736),
			cfn(0, 4.41427088, -0.820159078, 1, 0, 0, 0, 0.939692438, 0.342020929, 0, -0.342020959, 0.939692438),
			cfn(4.73044586, 0.828796685, -7.02275031e-07, 0.939692616, -0.342020273, 4.69496833e-08, 0.342020273, 0.939692736, 5.36441803e-07, -2.38418579e-07, -5.06639481e-07, 1),
			cfn(-4.85861921, 0.769028664, -6.75452611e-07, 0.939692616, 0.342020273, -4.69496833e-08, -0.342020273, 0.939692736, 5.36441803e-07, 2.38418579e-07, -5.06639481e-07, 1),
			cfn(1.50001335, -5.50980282, 1.44903219, 1, 0, 0, 0, 0.866024911, 0.500000954, 0, -0.500000954, 0.866024852),
			cfn(-1.50001526, -6.18578386, -0.968178153, 1, 0, 0, 0, 0.939692736, -0.342019916, 0, 0.342019886, 0.939692736),
		}, .2, false)
	end
	so(536642316,RightLeg,.7,3)
	for i=0,1,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(3.32593254e-06, -2.006042, 0.596467078, 1.0000006, -1.04904484e-06, 1.25335964e-06, -1.25487554e-06, 0.939695835, -0.342022181, 7.73278657e-07, 0.342019588, 0.939695656),
			cfn(-7.62939453e-06, 4.41428709, -0.820158899, 1, 0, 0, 0, 0.939692736, 0.342019916, 0, -0.342019886, 0.939692736),
			cfn(4.73044682, 0.788231254, 0.4500646, 0.939692736, -0.342019916, -1.53461215e-07, 0.29619807, 0.813797891, 0.499999791, -0.171009749, -0.469846129, 0.866025567),
			cfn(-4.82442522, 0.817862749, 0.432947218, 0.939691901, 0.342022151, -3.89083397e-07, -0.296199679, 0.813797176, 0.500000119, 0.171011403, -0.469845951, 0.866025388),
			cfn(1.50002289, -5.89457655, -2.13732576, 1, 0, 0, 0, 0.766043544, -0.642788708, 0, 0.642788708, 0.766043544),
			cfn(-1.49999833, -5.95715237, 0.805552125, 1.0000006, -1.25487554e-06, 7.73278657e-07, -1.04904484e-06, 0.939695835, 0.342019588, 1.25335964e-06, -0.342022181, 0.939695656),
		}, .4, false)
		MagnitudeDmg(RightLeg,4,60,3,RootPart.CFrame.lookVector*50,true,"Blunt",.5)
	end
	swait(20)
	Humanoid.WalkSpeed = 8
	Humanoid.JumpPower = 70
	attack = false
end

xhold = false
function thesurou()
	attack = true
	Humanoid.WalkSpeed = 2
	local grab = nil
	local torsy = nil
	local hum = nil
	for i, v in pairs(FindNearestTorso((RootPart.Position-v3(0,5,0)), 6)) do
		if v:FindFirstChild('Head') and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 1 then
			hum = v:FindFirstChildOfClass("Humanoid")
			torsy = v:FindFirstChild("UpperTorso") or v:FindFirstChild("Torso")
			grab = v
		end
	end
	if grab ~= nil and torsy ~= nil then
		so(200632136,RootPart,.8,1)
		for i = 0,1.5,.1 do
			swait()
			PlayAnimationFromTable({
				cfn(0, -3.15879345, -2.53031492, 1, 0, 0, 0, 0.500002086, 0.866031468, 0, -0.866031468, 0.500002086),
				cfn(0, 4.57667542, -0.666417062, 1, 0, 0, 0, 0.939692676, 0.342020601, 0, -0.342020601, 0.939692676),
				cfn(2.90267015, 1.56676149, -2.30737209, 0.793417096, 0.357805073, 0.492407322, 0.357833058, 0.380227387, -0.852867484, -0.492387056, 0.852879107, 0.173644423),
				cfn(-4.50001335, 1.20001578, 1.39186909e-07, 0.866023839, 0.500002861, -8.08226048e-07, -0.500002921, 0.866023898, -2.38418579e-06, -4.76837158e-07, 2.44379044e-06, 1.00000012),
				cfn(1.50001526, -3.79331636, -2.24549532, 1, 0, 0, 0, 0.500002086, -0.866031468, 0, 0.866031468, 0.500002086),
				cfn(-1.50001526, -6.19285679, -1.2660259, 1, 0, 0, 0, 0.866025031, -0.500000834, 0, 0.500000834, 0.866025031),
			}, .3, false)
		end
		so(240429615,torsy,1,1)
		local ref = Instance.new("Part",Camera)
		ref.Size = v3(0,0,0)
		ref.Anchored = true
		ref.CanCollide = false
		ref.Transparency = .5
		ref.BrickColor = BrickColor.Red()
		ref.Material = "Neon"
		local refm = Instance.new("SpecialMesh",ref)
		refm.MeshType = "Sphere"
		refm.Scale = v3(20,20,20)
		repeat
			swait()
			ref.CFrame = Mouse.Hit
			PlayAnimationFromTable({
				cfn(0, -2, 0, 0.64278698, 0, -0.766044974, 0, 1, 0, 0.766044974, 0, 0.64278698),
				cfn(-0.150877535, 4.46522665, -0.12660107, 0.64278698, -0.133022159, 0.754407108, 0, 0.984807849, 0.173647985, -0.766044974, -0.11161866, 0.633021653),
				cfn(4.82286024, 2.39900613, 0.0232518315, 0.939692676, -0.296197921, 0.171010524, -0.171010047, -0.839912355, -0.515075624, 0.296198219, 0.4547683, -0.839912176),
				cfn(-5.15264273, 1.06961691, 7.03156638e-06, 0.866025448, 0.500000119, -3.87430191e-07, -0.500000119, 0.866025388, -1.43057798e-06, -3.57627869e-07, 1.44541264e-06, 1),
				cfn(1.50001907, -6.00000048, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				cfn(-1.50001311, -6.00000048, 4.58955765e-06, 0.64278698, 0, 0.766044974, 0, 1, 0, -0.766044974, 0, 0.64278698),
			}, .3, false)
			torsy.CFrame = RightArm.CFrame*cfn(0,-3.5,0)*CFrame.Angles(math.rad(-90),0,0)
			hum.PlatformStand = true
			torsy.Velocity = v3()
			--end
		until xhold == false
		ref:Destroy()
		so(200632136,RootPart,.9,1)
		local pato = Instance.new("Part",torsy)
		pato.CFrame = torsy.CFrame
		pato.Size = v3(4.1,6.1,1.1)
		pato.Transparency = 1
		pato.CanCollide = false
		pato.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
		local werudo = Instance.new("Weld",pato)
		werudo.Part0 = pato
		werudo.Part1 = torsy
		torsy.Velocity = (ref.Position-torsy.Position).unit*200+v3(0,30,0)
		torsy.RotVelocity = v3(10,10,10)
		coroutine.wrap(function()
			while true do
				swait()
				hum.PlatformStand = true
			end
		end)
		pato.Touched:connect(function(hit)
			if hit:IsDescendantOf(chara)==false then
				pato:Destroy()
				Dmg(grab,150,0,v3(0,20,0)+RootPart.CFrame.lookVector*50,true,"Blunt",.3)
				so(260430079,torsy,1,5)
				MagnitudeDmg(torsy,6,50,3,v3(0,5,0)+RootPart.CFrame.lookVector*20,true,"Blunt",.2)
			end	
		end)
		for i = 0,1,.1 do
			swait()
			PlayAnimationFromTable({
				cfn(0, -2, 0, 0.499998987, 0, 0.866025984, 0, 1, 0, -0.866025984, 0, 0.499998987),
				cfn(0.142921209, 4.43258858, -0.122617245, 0.906121016, 0.296197981, -0.302012295, -0.219846055, 0.939692795, 0.262002379, 0.361403257, -0.17100969, 0.916593432),
				cfn(2.78872228, 0.109098256, -2.12347674, 0.642787337, 0.719846368, 0.262003452, -0.262002051, 0.527982056, -0.807830453, -0.719846845, 0.450617731, 0.5279814),
				cfn(-4.79283857, 1.09281766, -1.4803014e-05, 0.866025329, 0.500000238, -1.49011612e-07, -0.500000179, 0.866025388, 6.10661004e-07, 4.47034836e-07, -4.47034836e-07, 1),
				cfn(1.50002027, -6, -1.07288361e-06, 0.499998987, 0, -0.866025984, 0, 1, 0, 0.866025984, 0, 0.499998987),
				cfn(-1.50001907, -6, -3.81469727e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),
			}, .3, false)
		end
	end
	attack = false
	Humanoid.WalkSpeed = 8
end

function slam()
	attack = true
	Humanoid.WalkSpeed = 2
	Humanoid.JumpPower = 0
	for i=0,2,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(0, -1.93353117, 0.461958885, 1, 0, 0, 0, 0.939692736, -0.342019886, 0, 0.342019916, 0.939692736),
			cfn(0, 4.36522532, -0.370157003, 1, 0, 0, 0, 0.866025686, 0.499999642, 0, -0.499999642, 0.866025686),
			cfn(2.71519423, 4.60478783, -1.48087042e-06, 0.766044319, 0.642787933, 2.9919768e-08, 0.642787993, -0.766044319, -3.87430191e-07, -1.93715096e-07, 2.83122063e-07, -1),
			cfn(-2.70285583, 4.46389866, 6.19620914e-06, 0.766044319, -0.642787933, -2.9919768e-08, -0.642787993, -0.766044319, -3.87430191e-07, 1.93715096e-07, 2.83122063e-07, -1),
			cfn(1.50001526, -5.97923088, 0.956724763, 1, 0, 0, 0, 0.939692736, 0.342019916, 0, -0.342019886, 0.939692736),
			cfn(-1.50001526, -3.92088175, -1.2822783, 1, 0, 0, 0, 0.939692736, 0.342019916, 0, -0.342019886, 0.939692736),
		}, .2, false)
	end
	so(536642316,RightLeg,.7,3)
	Humanoid.WalkSpeed = 0
	for i=0,1,.2 do
		swait()
		PlayAnimationFromTable({		
			cfn(0, -5.00873852, -6.03775024, 1, 0, 0, 0, 0.342019022, 0.939693093, 0, -0.939693093, 0.342018992),
			cfn(0, 4.36520767, -0.370157599, 1, 0, 0, 0, 0.866026223, 0.499998808, 0, -0.499998808, 0.866026223),
			cfn(2.71519065, 1.07650685, -2.54415894, 0.766043842, 0.642788351, 6.46188241e-08, -0.11161828, 0.133021355, -0.984808087, -0.633023024, 0.754406214, 0.173647106),
			cfn(-2.70285606, 1.10098004, -2.40540719, 0.766043842, -0.642788351, -6.46188241e-08, 0.11161828, 0.133021355, -0.984808087, 0.633023024, 0.754406214, 0.173647106),
			cfn(1.50001526, -5.95997667, -0.00628298474, 1, 0, 0, 0, 1.00000012, 2.98023224e-08, 0, 2.98023224e-08, 1.00000012),
			cfn(-1.50001621, -2.56001854, -1.60915279, 1, 0, 0, 0, 0.984807789, -0.173648238, 0, 0.173648268, 0.98480773),
		}, .4, false)
	end
	so(133680244,Torso,1,3)
	CamShake(RightArm,10,.5,.5)
	MagnitudeDmg(RightArm,10,40,3,RootPart.CFrame.lookVector*30,true,"Blunt",.5)
	MagnitudeDmg(LeftArm,10,40,3,RootPart.CFrame.lookVector*30,true,"Blunt",.5)
	Effects.Wave(RootPart.CFrame*cfn(0,-5,-10),v3(),v3(1,1,1),"",10,false,.05)
	Effects.Wave(RootPart.CFrame*cfn(0,-5,-10),v3(),v3(.5,2,.5),"",-10,false,.05)
	swait(50)
	Humanoid.WalkSpeed = 8
	Humanoid.JumpPower = 70
	attack = false
end

chold = false
function headrip()
	attack = true
	Humanoid.WalkSpeed = 2
	local grab = nil
	local torsy = nil
	local hum = nil
	for i, v in pairs(FindNearestTorso((RootPart.Position-v3(0,5,0)), 6)) do
		if v:FindFirstChild('Head') and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 1 then
			hum = v:FindFirstChildOfClass("Humanoid")
			torsy = v:FindFirstChild("UpperTorso") or v:FindFirstChild("Torso")
			grab = v
		end
	end
	if grab ~= nil and torsy ~= nil then
		so(200632136,RootPart,.8,1)
		for i = 0,1.5,.1 do
			swait()
			PlayAnimationFromTable({
				cfn(0, -3.15884066, -2.53038549, 1, 0, 0, 0, 0.500003159, 0.866033316, 0, -0.866033316, 0.500003159),
				cfn(0, 4.57682848, -0.666438639, 1, 0, 0, 0, 0.939708173, 0.342026293, 0, -0.342026293, 0.939708173),
				cfn(4.681849, 1.59641457, -0.711094618, 0.624222994, -0.751194239, 0.214599475, 0.684884727, 0.658341169, 0.31230849, -0.375883996, -0.0479742885, 0.925433218),
				cfn(-2.69011021, 1.89638007, -2.91367531, 0.754421711, -0.633005977, -0.173641309, -0.133027852, 0.111603782, -0.984817266, 0.642774224, 0.76606667, -1.10864639e-05),
				cfn(1.50001526, -3.79332972, -2.24550533, 1, 0, 0, 0, 0.500003159, -0.866033316, 0, 0.866033316, 0.500003159),
				cfn(-1.50001526, -6.19305992, -1.26607037, 1, 0, 0, 0, 0.866039395, -0.500009179, 0, 0.500009179, 0.866039395),
			}, .3, false)
		end
		so(240429615,torsy,1,1)
		for i = 0,1.5,.1 do
			swait()
			PlayAnimationFromTable({
				cfn(0, -2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				cfn(0, 4.48268127, -0.632217944, 1, 0, 0, 0, 0.939692736, 0.342019886, 0, -0.342019916, 0.939692736),
				cfn(3.1680572, 1.46073127, -2.0815649, 0.866025388, 0.500000119, 5.45067223e-07, -0.0868230462, 0.150382936, -0.984807968, -0.492404222, 0.852868676, 0.173646957),
				cfn(-2.51076937, 2.25588131, -2.26415157, 0.103214003, -0.44736287, -0.888376772, -0.960965991, 0.185646102, -0.205133989, 0.256693006, 0.874872625, -0.410739183),
				cfn(1.50001526, -6, 2.98023224e-07, 0.939692736, 0, -0.342019886, 0, 1, 0, 0.342019916, 0, 0.939692736),
				cfn(-1.50001431, -6, 3.12924385e-06, 0.984807849, 0, 0.173647985, 0, 1, 0, -0.173647985, 0, 0.984807849),
			}, .3, false)
			torsy.CFrame = LeftArm.CFrame*cfn(0,-3.5,0)*CFrame.Angles(math.rad(-90),0,0)
			hum.PlatformStand = true
			torsy.Velocity = v3()
		end
		local armmod = Instance.new("Model",chara)
		armmod.Name = grab.Name
		Instance.new("Humanoid",armmod).Health = 0
		for i, v in pairs(grab:GetChildren()) do
			if v:IsA("Accoutrement") then
				v.Parent = armmod
				if v:FindFirstChild("Handle"):FindFirstChild("AccessoryWeld") then
					v.Handle.AccessoryWeld.Part1 = nil
				end
			end
		end
		local armp = grab:FindFirstChild("Head")
		Instance.new("BoolValue",grab).Name = "DEATHED"
		grab:BreakJoints()
		armp.Parent = armmod
		for i, v in pairs(armmod:GetChildren()) do
			if v:IsA("Accoutrement") then
				if v:FindFirstChild("Handle"):FindFirstChild("AccessoryWeld") then
					v.Handle.AccessoryWeld.Part1 = armp
					v.Parent = armmod
				end
			end
		end
		so(206082327,armp,1,5)
		local bledp = Instance.new("Part",grab)
		bledp.Size = v3(0,0,0)
		bledp.Transparency = 1
		bledp.CanCollide = false
		local blpemit = Instance.new("ParticleEmitter")
		blpemit.Color = ColorSequence.new(c3(.5,0,0))
		blpemit.Texture = "rbxassetid://233069772"
		blpemit.Transparency = NumberSequence.new(0,1)
		blpemit.Lifetime = NumberRange.new(1,3)
		blpemit.Acceleration = v3(0,-10,0)
		blpemit.Enabled = true
		blpemit.EmissionDirection = "Front"
		blpemit.Speed = NumberRange.new(1,3)
		blpemit.Size = NumberSequence.new(.5)
		blpemit.Rate = 1000
		blpemit.RotSpeed = NumberRange.new(50)
		blpemit.Rotation = NumberRange.new(0,360)
		local blpe = blpemit:Clone()
		blpe.Parent = bledp
		blpe.EmissionDirection = "Top"
		blpe.VelocitySpread = 20
		local wel = Instance.new("Weld",armp)
		wel.Part0 = RightArm
		wel.Part1 = armp
		wel.C0 = cfn(0,-3.5,0) * CFrame.Angles(math.rad(-90),0,0)
		local blape = bledp:Clone()
		blape.Parent = armmod
		blape.ParticleEmitter.EmissionDirection = "Bottom"
		local bledw = Instance.new("Weld",bledp)
		bledw.Part0 = torsy
		bledw.Part1 = bledp
		bledw.C0 = cfn(0,1,0)
		local bledw2 = Instance.new("Weld",blape)
		bledw2.Part0 = armp
		bledw2.Part1 = blape
		bledw2.C0 = cfn(0,-.5,0)
		for i = 0,2,.1 do
			swait()
			PlayAnimationFromTable({
				cfn(3.48687149e-06, -2.00000668, 8.1956324e-07, 0.999997258, -1.74343575e-06, -2.29477928e-06, -1.74343575e-06, 1.00000334, -4.0978162e-07, -2.29477928e-06, -4.0978162e-07, 1.00000334),
				cfn(-1.77990187e-05, 4.48271227, -0.632223666, 0.999997258, -8.47689194e-07, -2.76961782e-06, -1.74343575e-06, 0.939696074, 0.34202069, -2.29477928e-06, -0.342021465, 0.939695656),
				cfn(5.08315945, 1.73977804, -0.499025792, 0.766043842, -0.642786205, -9.90775334e-07, 0.111617334, 0.133024782, -0.984809279, 0.633021057, 0.754409432, 0.173649535),
				cfn(-3.94786024, 2.2021482, -1.88751972, 0.103215352, 0.54567498, -0.831614494, -0.960967898, 0.270473748, 0.0582071356, 0.256692559, 0.793146551, 0.552295864),
				cfn(1.50003362, -6.00004482, -2.68220901e-07, 0.939689338, -1.74343575e-06, -0.342021078, -1.76123024e-06, 1.00000334, 2.14558611e-07, 0.342018902, -4.0978162e-07, 0.939696491),
				cfn(-1.49998772, -6.00003576, 1.09374523e-05, 0.984805524, -1.74343575e-06, 0.173645243, -1.66984103e-06, 1.00000334, -7.16618331e-07, -0.173650891, -4.0978162e-07, 0.98481071),
			}, .3, false)
			torsy.CFrame = LeftArm.CFrame*cfn(0,-3.5,0)*CFrame.Angles(math.rad(-90),0,0)
			hum.PlatformStand = true
			torsy.Velocity = v3()
		end
		local ref = Instance.new("Part",Camera)
		ref.Size = v3(0,0,0)
		ref.Anchored = true
		ref.CanCollide = false
		ref.Transparency = .5
		ref.BrickColor = BrickColor.Red()
		ref.Material = "Neon"
		local refm = Instance.new("SpecialMesh",ref)
		refm.MeshType = "Sphere"
		refm.Scale = v3(20,20,20)
		repeat
			swait()
			ref.CFrame = Mouse.Hit
			PlayAnimationFromTable({
				cfn(0, -2, 0, 0.64278698, 0, -0.766044974, 0, 1, 0, 0.766044974, 0, 0.64278698),
				cfn(-0.150877535, 4.46522665, -0.12660107, 0.64278698, -0.133022159, 0.754407108, 0, 0.984807849, 0.173647985, -0.766044974, -0.11161866, 0.633021653),
				cfn(4.82286024, 2.39900613, 0.0232518315, 0.939692676, -0.296197921, 0.171010524, -0.171010047, -0.839912355, -0.515075624, 0.296198219, 0.4547683, -0.839912176),
				cfn(-5.15264273, 1.06961691, 7.03156638e-06, 0.866025448, 0.500000119, -3.87430191e-07, -0.500000119, 0.866025388, -1.43057798e-06, -3.57627869e-07, 1.44541264e-06, 1),
				cfn(1.50001907, -6.00000048, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				cfn(-1.50001311, -6.00000048, 4.58955765e-06, 0.64278698, 0, 0.766044974, 0, 1, 0, -0.766044974, 0, 0.64278698),
			}, .3, false)
			torsy.CFrame = LeftArm.CFrame*cfn(0,-3.5,0)*CFrame.Angles(math.rad(-90),0,0)
			hum.PlatformStand = true
			torsy.Velocity = v3()
			--end
		until chold == false
		ref:Destroy()
		so(200632136,RootPart,.9,1)
		wel:Destroy()
		armp.Velocity = (ref.Position-armp.Position).unit*200+v3(0,30,0)
		armp.RotVelocity = v3(10,10,10)
		armp.Touched:connect(function(hit)
			if hit:IsDescendantOf(chara)==false and hit.Parent:FindFirstChildOfClass("Humanoid") and armp:FindFirstChild("HITA")==nil then
				Instance.new("BoolValue",armp).Name = "HITA"
				MagnitudeDmg(armp,6,120,0,v3(0,5,0)+RootPart.CFrame.lookVector*20,true,"Blunt",.2)
				so(386946017,armp,.95,5)
				swait(120)
				for i=0,1,.05 do
					armp.Transparency = i
					swait()
				end
				armp.Parent:Destroy()
			end	
		end)
		for i = 0,1,.1 do
			swait()
			PlayAnimationFromTable({
				cfn(0, -2, 0, 0.499998987, 0, 0.866025984, 0, 1, 0, -0.866025984, 0, 0.499998987),
				cfn(0.142921209, 4.43258858, -0.122617245, 0.906121016, 0.296197981, -0.302012295, -0.219846055, 0.939692795, 0.262002379, 0.361403257, -0.17100969, 0.916593432),
				cfn(2.78872228, 0.109098256, -2.12347674, 0.642787337, 0.719846368, 0.262003452, -0.262002051, 0.527982056, -0.807830453, -0.719846845, 0.450617731, 0.5279814),
				cfn(-4.79283857, 1.09281766, -1.4803014e-05, 0.866025329, 0.500000238, -1.49011612e-07, -0.500000179, 0.866025388, 6.10661004e-07, 4.47034836e-07, -4.47034836e-07, 1),
				cfn(1.50002027, -6, -1.07288361e-06, 0.499998987, 0, -0.866025984, 0, 1, 0, 0.866025984, 0, 0.499998987),
				cfn(-1.50001907, -6, -3.81469727e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),
			}, .3, false)
			torsy.CFrame = LeftArm.CFrame*cfn(0,-3.5,0)*CFrame.Angles(math.rad(-90),0,0)
			hum.PlatformStand = true
			torsy.Velocity = v3()
		end
	end
	attack = false
	Humanoid.WalkSpeed = 8
end

function stomp()
	attack = true
	Humanoid.WalkSpeed = 2
	Humanoid.JumpPower = 0
	for i=0,2,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(0, -2, 0.499992371, 1, 0, 0, 0, 1, 0, 0, 0, 1),
			cfn(0, 4.42290688, -0.504058063, 1, 0, 0, 0, 0.939692736, 0.342019886, 0, -0.342019916, 0.939692736),
			cfn(4.92942858, 1.05621195, 0, 0.866025388, -0.500000238, 0, 0.500000238, 0.866025388, 0, 0, 0, 1),
			cfn(-4.79283428, 1.09282625, 0, 0.866025388, 0.500000238, 0, -0.500000238, 0.866025388, 0, 0, 0, 1),
			cfn(1.2052269, -2.30000162, -2.06380463, 1, 0, 0, 0, 1, 0, 0, 0, 1),
			cfn(-1.50001597, -6, -0.499997646, 0.984807849, 0, 0.173647985, 0, 1, 0, -0.173647985, 0, 0.984807849),
		}, .2, false)
	end
	so(536642316,RightLeg,.7,3)
	Humanoid.WalkSpeed = 0
	for i=0,1,.2 do
		swait()
		PlayAnimationFromTable({		
			cfn(0, -1.82004941, -0.371783257, 1, 0, 0, 0, 0.939692736, 0.342019886, 0, -0.342019916, 0.939692736),
			cfn(0, 4.42290878, -0.504067779, 1, 0, 0, 0, 0.939692438, 0.342020929, 0, -0.342020959, 0.939692438),
			cfn(4.92943096, 1.05621648, -6.17108253e-06, 0.86602509, -0.500000656, -3.33671437e-07, 0.500000715, 0.86602509, 2.08616257e-07, 1.78813934e-07, -3.87430191e-07, 1),
			cfn(-4.79283619, 1.09282386, -6.2277054e-06, 0.86602509, 0.500000656, 3.33671437e-07, -0.500000715, 0.86602509, 2.08616257e-07, -1.78813934e-07, -3.87430191e-07, 1),
			cfn(1.2052269, -5.38336658, -2.92564583, 1, 0, 0, 0, 0.939692736, -0.342019916, 0, 0.342019886, 0.939692736),
			cfn(-1.50000978, -6.05502558, -1.08027697, 0.984807849, 0, 0.173647985, 0.0593910702, 0.939692736, -0.33682391, -0.163175747, 0.342019886, 0.925416768),
		}, .4, false)
	end
	so(133680244,Torso,1,3)
	CamShake(Torso,10,.5,.5)
	Effects.Wave(RootPart.CFrame*cfn(1,-7,-2),v3(),v3(1,.2,1),"",10,false,.05)
	for _, c in pairs(workspace:GetDescendants()) do
		local hum = c:FindFirstChildOfClass("Humanoid")
		if hum ~= nil and c:FindFirstChild("IsTeamMateOfCK")==nil then
			local head = GetDudesTorso(c)
			if head ~= nil then
				local targ = head.Position - RightLeg.Position
				local mag = targ.magnitude
				if 4 >= mag and c ~= chara then
					MagnitudeDmg(head,6,120,0,v3(0,5,0)+RootPart.CFrame.lookVector*20,true,"Blunt",.2)
				end
			end
		end
	end
	swait(50)
	Humanoid.WalkSpeed = 8
	Humanoid.JumpPower = 70
	attack = false
end

function pshoot()
	attack = true
	local ref = Instance.new("Part",Camera)
	ref.Size = v3(0,0,0)
	ref.Anchored = true
	ref.CanCollide = false
	ref.Transparency = 1
	so(2920959,PHandaru,.8,3)
	ref.CFrame = Mouse.Hit
	MagnitudeDmg(ref,3,40,2,RootPart.CFrame.lookVector*20,true,"Shot",.1)
	local hitpt = Instance.new("Part",EffectModel)
	hitpt.Size = v3(.3,.3,1)
	hitpt.CFrame = PBExit.CFrame * CFrame.Angles(math.rad(180),0,0)
	hitpt.Velocity = RootPart.CFrame.rightVector*30+v3(0,20,0)
	local hitm = Instance.new("SpecialMesh",hitpt)
	hitm.MeshId = "rbxassetid://94295100"
	hitm.TextureId = "rbxassetid://94287792"
	hitm.Scale = v3(7,7,7)
	coroutine.wrap(function()
		swait(30)
		for i = 0,1,.1 do
			swait()
			hitpt.Transparency = i
		end
		hitpt:Destroy()
	end)()
	CamShake(PShot,10,.3,.2)
	CamShake(ref,10,.3,.2)
	Effects.Block(PShot.CFrame,v3(1,1,1),v3(1,1,1),v3(.2,.2,.2),"Neon","Bright yellow",true,false,.1)
	Effects.Block(ref.CFrame,v3(1,1,1),v3(1,1,1),v3(.2,.2,.2),"Neon","Bright yellow",true,false,.1)
	Effects.Block(cfn((PShot.Position + ref.Position)/2,ref.Position),v3(1,1,(PShot.Position - ref.Position).magnitude),v3(1,1,1),v3(.1,.1,0),"Neon","Bright yellow",false,false,.1)
	ref:Destroy()
	for i=0,1,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(0, -2.03907418, 0.246627718, 1, 0, 0, 0, 0.984807849, -0.173647985, 0, 0.173647985, 0.984807849),
			cfn(0, 4.27438593, -0.749499321, 1, 0, 0, 0, 0.866025686, 0.499999642, 0, -0.499999642, 0.866025686),
			cfn(4.50001526, 2.12096167, -0.0117100477, 1, 0, 0, 0, -0.500000715, -0.86602509, 0, 0.86602509, -0.500000715),
			cfn(-3.79128671, -0.462022513, -0.54968375, 0.939692497, -0.336824238, -0.0593918264, 0.321393669, 0.928998291, -0.183489919, 0.11697875, 0.153335959, 0.981225848),
			cfn(1.50001526, -5.94357777, 0.444926023, 1, 0, 0, 0, 0.984807849, 0.173647985, 0, -0.173647985, 0.984807849),
			cfn(-1.50001526, -5.94357777, 0.444926023, 1, 0, 0, 0, 0.984807849, 0.173647985, 0, -0.173647985, 0.984807849),
		}, .3, false)
	end
	for i=0,2,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(0, -2.03907442, 0.0466268957, 1, 0, 0, 0, 0.984807849, -0.173647985, 0, 0.173647985, 0.984807849),
			cfn(0, 4.27438593, -0.749499321, 1, 0, 0, 0, 0.866025686, 0.499999642, 0, -0.499999642, 0.866025686),
			cfn(4.50001526, 0.888218164, -1.46819997, 1, 0, 0, 0, 0.342019796, -0.939692855, 0, 0.939692855, 0.342019796),
			cfn(-3.79128027, -0.462018341, -0.549682617, 0.939692497, -0.336824238, -0.0593918264, 0.321393669, 0.928998291, -0.183489919, 0.11697875, 0.153335959, 0.981225848),
			cfn(1.50001526, -5.94357777, 0.444926023, 1, 0, 0, 0, 0.984807849, 0.173647985, 0, -0.173647985, 0.984807849),
			cfn(-1.50001526, -5.94357777, 0.444926023, 1, 0, 0, 0, 0.984807849, 0.173647985, 0, -0.173647985, 0.984807849),
		}, .15, false)
	end
	attack = false
end

function sshoot()
	attack = true
	so(138083993,SHandaru,.8,3)
	CamShake(SHandaru,10,.5,.3)
	Effects.Block(SShot.CFrame,v3(1,1,1),v3(1,1,1),v3(.25,.25,.25),"Neon","Bright yellow",true,false,.1)
	for a=1,6 do
		local ref = Instance.new("Part",Camera)
		ref.Size = v3(0,0,0)
		ref.Anchored = true
		ref.CanCollide = false
		ref.Transparency = 1
		ref.CFrame = Mouse.Hit*cfn(math.random(-5,5),math.random(-5,5),math.random(-5,5))
		MagnitudeDmg(ref,7,50,2,RootPart.CFrame.lookVector*20,true,"Shot",0)
		CamShake(ref,10,.4,.3)
		Effects.Block(ref.CFrame,v3(1,1,1),v3(1,1,1),v3(.2,.2,.2),"Neon","Bright yellow",true,false,.1)
		Effects.Block(cfn((SShot.Position + ref.Position)/2,ref.Position),v3(1,1,(SShot.Position - ref.Position).magnitude),v3(1,1,1),v3(.1,.1,0),"Neon","Bright yellow",false,false,.1)
		ref:Destroy()
	end
	for i=0,2,.1 do
		swait()
		PlayAnimationFromTable({
			cfn(1.44002445e-06, -1.99998927, 1.07288088e-05, 0.500000179, -7.20012224e-07, -0.866025269, -5.03950741e-06, 0.999994636, -2.05067545e-06, 0.866026759, -5.36440439e-06, 0.499997884),
			cfn(-0.547573745, 4.48264122, -0.316118479, 0.500000179, -0.296203166, 0.813797355, -7.20012224e-07, 0.939689577, 0.342012942, -0.866025269, -0.17101118, 0.469843715),
			cfn(1.79884899, 0.344976842, -2.36338496, 0.362167031, 0.825433791, -0.433008999, 0.086823605, -0.492405862, -0.866018176, -0.928060055, 0.276049763, -0.249996945),
			cfn(-4.43855, 2.71461391, -2.15137076, 0.558953762, 0.0775076449, 0.825570107, 0.722433925, -0.534201145, -0.438984573, 0.406993419, 0.841796517, -0.354588091),
			cfn(1.26245594, -5.99997377, 0.147344589, 1.00000072, -2.5366503e-06, -2.98023224e-07, -2.50286234e-06, 0.999997318, -1.02932597e-06, -2.68220901e-07, -1.02135346e-06, 0.999999464),
			cfn(-1.16597474, -5.99992371, 0.0196756423, 0.500000179, -5.03950741e-06, 0.866026759, -7.20012224e-07, 0.999994636, -5.36440439e-06, -0.866025269, -2.05067545e-06, 0.499997884),
		}, .3, false)
	end
	so(2697295,SHandaru,.4,3)
	for i=0,1,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(-1.44382084e-05, -2, -3.52843199e-05, 0.500002384, 7.21910419e-06, -0.866024017, -1.88881022e-05, 1, -2.56920703e-06, 0.866024017, 1.76421599e-05, 0.500002384),
			cfn(-0.547627807, 4.48263931, -0.316102535, 0.500002384, -0.296216011, 0.813789785, 7.21910419e-06, 0.939686358, 0.34203741, -0.866024017, -0.171013653, 0.46984759),
			cfn(1.81868255, -0.103687182, -2.3519392, 0.377200723, 0.740163803, -0.556666017, 0.111620866, -0.633017302, -0.766048193, -0.919380486, 0.226818368, -0.321392298),
			cfn(-3.0397644, 2.26208973, -1.6833154, 0.658552945, -0.00924476981, 0.752477705, 0.592071891, -0.610833943, -0.525673687, 0.46449858, 0.791704834, -0.396792918),
			cfn(1.76254702, -5.99993086, -0.252668977, 0.500002384, -1.88881022e-05, 0.866024017, 7.21910419e-06, 1, 1.76421599e-05, -0.866024017, -2.56920703e-06, 0.500002384),
			cfn(-1.16592002, -5.99993467, 0.0196563601, 0.500002384, -1.88881022e-05, 0.866024017, 7.21910419e-06, 1, 1.76421599e-05, -0.866024017, -2.56920703e-06, 0.500002384),
		}, .2, false)
	end
	local hitpt = Instance.new("Part",EffectModel)
	hitpt.Size = v3(.7,.6,2.1)
	hitpt.CFrame = SSExit.CFrame * CFrame.Angles(0,math.rad(90),0)
	hitpt.Velocity = RootPart.CFrame.rightVector*30+v3(0,20,0)
	hitpt.BrickColor = BrickColor.Red()
	local hitm = Instance.new("SpecialMesh",hitpt)
	hitm.MeshId = "rbxassetid://94248124"
	hitm.Scale = v3(4,4,4)
	coroutine.wrap(function()
		swait(30)
		for i = 0,1,.1 do
			swait()
			hitpt.Transparency = i
		end
		hitpt:Destroy()
	end)()
	swait(15)
	so(2697295,SHandaru,.5,3)
	for i=0,2,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(1.44002445e-06, -1.99998927, 1.07288088e-05, 0.500000179, -7.20012224e-07, -0.866025269, -5.03950741e-06, 0.999994636, -2.05067545e-06, 0.866026759, -5.36440439e-06, 0.499997884),
			cfn(-0.547573745, 4.48264122, -0.316118479, 0.500000179, -0.296203166, 0.813797355, -7.20012224e-07, 0.939689577, 0.342012942, -0.866025269, -0.17101118, 0.469843715),
			cfn(1.79884899, 0.344976842, -2.36338496, 0.362167031, 0.825433791, -0.433008999, 0.086823605, -0.492405862, -0.866018176, -0.928060055, 0.276049763, -0.249996945),
			cfn(-4.43855, 2.71461391, -2.15137076, 0.558953762, 0.0775076449, 0.825570107, 0.722433925, -0.534201145, -0.438984573, 0.406993419, 0.841796517, -0.354588091),
			cfn(1.26245594, -5.99997377, 0.147344589, 1.00000072, -2.5366503e-06, -2.98023224e-07, -2.50286234e-06, 0.999997318, -1.02932597e-06, -2.68220901e-07, -1.02135346e-06, 0.999999464),
			cfn(-1.16597474, -5.99992371, 0.0196756423, 0.500000179, -5.03950741e-06, 0.866026759, -7.20012224e-07, 0.999994636, -5.36440439e-06, -0.866025269, -2.05067545e-06, 0.499997884),
		}, .15, false)
	end
	attack = false
end

slugged = false
function slugload()
	attack = true
	for i=0,1.5,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(-7.16520026e-06, -2, -1.7398881e-05, 0.500000775, 3.58260013e-06, -0.866025031, -9.32523108e-06, 1, -1.24710277e-06, 0.866025031, 8.69944051e-06, 0.500000834),
			cfn(-0.547560275, 4.48266172, -0.316098541, 0.500000775, -0.296206981, 0.813794136, 3.58260013e-06, 0.939689577, 0.342028588, -0.866025031, -0.171011642, 0.469846636),
			cfn(1.79885161, 0.344982982, -2.3633914, 0.362167209, 0.825436056, -0.433004498, 0.0868273452, -0.492402256, -0.866019845, -0.928059697, 0.276049197, -0.249998987),
			cfn(-2.88378954, -0.377780259, 1.65731072, 0.242966965, -0.26283136, 0.933748841, 0.258929163, 0.945239484, 0.198690876, -0.934838533, 0.193499491, 0.297716707),
			cfn(1.26252019, -5.99994278, 0.147333026, 1.00000072, -7.54235225e-06, -9.83476639e-07, 2.53665348e-06, 0.999997318, -3.08799281e-06, 3.27825546e-07, 1.02932972e-06, 0.999999464),
			cfn(-1.1659708, -5.99996805, 0.0196544528, 0.500000775, -9.32523108e-06, 0.866025031, 3.58260013e-06, 1, 8.69944051e-06, -0.866025031, -1.24710277e-06, 0.500000834),
		}, .15, false)
	end
	local hitpt0 = Instance.new("Part",EffectModel)
	hitpt0.Size = v3(.7,.6,2.1)
	hitpt0.CFrame = SSExit.CFrame * CFrame.Angles(0,math.rad(90),0)
	hitpt0.Velocity = RootPart.CFrame.rightVector*30+v3(0,20,0)
	local hitm0 = Instance.new("SpecialMesh",hitpt0)
	hitm0.MeshId = "rbxassetid://94248124"
	hitm0.TextureId = "rbxassetid://94219470"
	hitm0.Scale = v3(4,4,4)
	local hw = Instance.new("Weld",hitpt0)
	hw.Part0 = hitpt0
	hw.Part1 = LeftArm
	hw.C0 = cfn(-1,2.5,0)
	for i=0,1,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(-1.44382084e-05, -2, -3.52843199e-05, 0.500002384, 7.21910419e-06, -0.866024017, -1.88881022e-05, 1, -2.56920703e-06, 0.866024017, 1.76421599e-05, 0.500002384),
			cfn(-0.547627807, 4.48263931, -0.316102535, 0.500002384, -0.296216011, 0.813789785, 7.21910419e-06, 0.939686358, 0.34203741, -0.866024017, -0.171013653, 0.46984759),
			cfn(1.81868255, -0.103687182, -2.3519392, 0.377200723, 0.740163803, -0.556666017, 0.111620866, -0.633017302, -0.766048193, -0.919380486, 0.226818368, -0.321392298),
			cfn(-3.0397644, 2.26208973, -1.6833154, 0.658552945, -0.00924476981, 0.752477705, 0.592071891, -0.610833943, -0.525673687, 0.46449858, 0.791704834, -0.396792918),
			cfn(1.26245594, -5.99997377, 0.147344589, 1.00000072, -2.5366503e-06, -2.98023224e-07, -2.50286234e-06, 0.999997318, -1.02932597e-06, -2.68220901e-07, -1.02135346e-06, 0.999999464),
			cfn(-1.16597474, -5.99992371, 0.0196756423, 0.500000179, -5.03950741e-06, 0.866026759, -7.20012224e-07, 0.999994636, -5.36440439e-06, -0.866025269, -2.05067545e-06, 0.499997884),
		}, .2, false)
	end
	hitpt0:Destroy()
	so(2697295,SHandaru,.7,3)
	swait(15)
	for i=0,1,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(1.44002445e-06, -1.99998927, 1.07288088e-05, 0.500000179, -7.20012224e-07, -0.866025269, -5.03950741e-06, 0.999994636, -2.05067545e-06, 0.866026759, -5.36440439e-06, 0.499997884),
			cfn(-0.547573745, 4.48264122, -0.316118479, 0.500000179, -0.296203166, 0.813797355, -7.20012224e-07, 0.939689577, 0.342012942, -0.866025269, -0.17101118, 0.469843715),
			cfn(1.79884899, 0.344976842, -2.36338496, 0.362167031, 0.825433791, -0.433008999, 0.086823605, -0.492405862, -0.866018176, -0.928060055, 0.276049763, -0.249996945),
			cfn(-4.43855, 2.71461391, -2.15137076, 0.558953762, 0.0775076449, 0.825570107, 0.722433925, -0.534201145, -0.438984573, 0.406993419, 0.841796517, -0.354588091),
			cfn(1.26245594, -5.99997377, 0.147344589, 1.00000072, -2.5366503e-06, -2.98023224e-07, -2.50286234e-06, 0.999997318, -1.02932597e-06, -2.68220901e-07, -1.02135346e-06, 0.999999464),
			cfn(-1.16597474, -5.99992371, 0.0196756423, 0.500000179, -5.03950741e-06, 0.866026759, -7.20012224e-07, 0.999994636, -5.36440439e-06, -0.866025269, -2.05067545e-06, 0.499997884),
		}, .2, false)
	end
	for i=0,1.5,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(-1.44382084e-05, -2, -3.52843199e-05, 0.500002384, 7.21910419e-06, -0.866024017, -1.88881022e-05, 1, -2.56920703e-06, 0.866024017, 1.76421599e-05, 0.500002384),
			cfn(-0.547627807, 4.48263931, -0.316102535, 0.500002384, -0.296216011, 0.813789785, 7.21910419e-06, 0.939686358, 0.34203741, -0.866024017, -0.171013653, 0.46984759),
			cfn(1.81868255, -0.103687182, -2.3519392, 0.377200723, 0.740163803, -0.556666017, 0.111620866, -0.633017302, -0.766048193, -0.919380486, 0.226818368, -0.321392298),
			cfn(-3.0397644, 2.26208973, -1.6833154, 0.658552945, -0.00924476981, 0.752477705, 0.592071891, -0.610833943, -0.525673687, 0.46449858, 0.791704834, -0.396792918),
			cfn(1.26245594, -5.99997377, 0.147344589, 1.00000072, -2.5366503e-06, -2.98023224e-07, -2.50286234e-06, 0.999997318, -1.02932597e-06, -2.68220901e-07, -1.02135346e-06, 0.999999464),
			cfn(-1.16597474, -5.99992371, 0.0196756423, 0.500000179, -5.03950741e-06, 0.866026759, -7.20012224e-07, 0.999994636, -5.36440439e-06, -0.866025269, -2.05067545e-06, 0.499997884),
		}, .15, false)
	end
	local hitpt = Instance.new("Part",EffectModel)
	hitpt.Size = v3(.7,.6,2.1)
	hitpt.CFrame = SSExit.CFrame * CFrame.Angles(0,math.rad(90),0)
	hitpt.Velocity = RootPart.CFrame.rightVector*30+v3(0,20,0)
	hitpt.BrickColor = BrickColor.Red()
	local hitm = Instance.new("SpecialMesh",hitpt)
	hitm.MeshId = "rbxassetid://94248124"
	hitm.Scale = v3(4,4,4)
	coroutine.wrap(function()
		swait(30)
		for i = 0,1,.1 do
			swait()
			hitpt.Transparency = i
		end
		hitpt:Destroy()
	end)()
	swait(15)
	so(2697295,SHandaru,.5,3)
	for i=0,2,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(1.44002445e-06, -1.99998927, 1.07288088e-05, 0.500000179, -7.20012224e-07, -0.866025269, -5.03950741e-06, 0.999994636, -2.05067545e-06, 0.866026759, -5.36440439e-06, 0.499997884),
			cfn(-0.547573745, 4.48264122, -0.316118479, 0.500000179, -0.296203166, 0.813797355, -7.20012224e-07, 0.939689577, 0.342012942, -0.866025269, -0.17101118, 0.469843715),
			cfn(1.79884899, 0.344976842, -2.36338496, 0.362167031, 0.825433791, -0.433008999, 0.086823605, -0.492405862, -0.866018176, -0.928060055, 0.276049763, -0.249996945),
			cfn(-4.43855, 2.71461391, -2.15137076, 0.558953762, 0.0775076449, 0.825570107, 0.722433925, -0.534201145, -0.438984573, 0.406993419, 0.841796517, -0.354588091),
			cfn(1.26245594, -5.99997377, 0.147344589, 1.00000072, -2.5366503e-06, -2.98023224e-07, -2.50286234e-06, 0.999997318, -1.02932597e-06, -2.68220901e-07, -1.02135346e-06, 0.999999464),
			cfn(-1.16597474, -5.99992371, 0.0196756423, 0.500000179, -5.03950741e-06, 0.866026759, -7.20012224e-07, 0.999994636, -5.36440439e-06, -0.866025269, -2.05067545e-06, 0.499997884),
		}, .15, false)
	end
	slugged = true
	attack = false
end

function slugshoot()
	attack = true
	so(138083993,SHandaru,.8,3)
	CamShake(SHandaru,10,.5,.3)
	Effects.Block(SShot.CFrame,v3(1,1,1),v3(1,1,1),v3(.25,.25,.25),"Neon","Bright yellow",true,false,.1)
	local ref = Instance.new("Part",Camera)
	ref.Size = v3(0,0,0)
	ref.Anchored = true
	ref.CanCollide = false
	ref.Transparency = 1
	ref.CFrame = Mouse.Hit
	MagnitudeDmg(ref,3,120,0,RootPart.CFrame.lookVector*70,true,"Shot",0)
	CamShake(ref,10,.4,.3)
	Effects.Block(ref.CFrame,v3(1,1,1),v3(1,1,1),v3(.2,.2,.2),"Neon","Bright yellow",true,false,.1)
	Effects.Block(cfn((SShot.Position + ref.Position)/2,ref.Position),v3(1,1,(SShot.Position - ref.Position).magnitude),v3(1,1,1),v3(.1,.1,0),"Neon","Bright yellow",false,false,.1)
	ref:Destroy()
	for i=0,2,.1 do
		swait()
		PlayAnimationFromTable({
			cfn(1.44002445e-06, -1.99998927, 1.07288088e-05, 0.500000179, -7.20012224e-07, -0.866025269, -5.03950741e-06, 0.999994636, -2.05067545e-06, 0.866026759, -5.36440439e-06, 0.499997884),
			cfn(-0.547573745, 4.48264122, -0.316118479, 0.500000179, -0.296203166, 0.813797355, -7.20012224e-07, 0.939689577, 0.342012942, -0.866025269, -0.17101118, 0.469843715),
			cfn(1.79884899, 0.344976842, -2.36338496, 0.362167031, 0.825433791, -0.433008999, 0.086823605, -0.492405862, -0.866018176, -0.928060055, 0.276049763, -0.249996945),
			cfn(-4.43855, 2.71461391, -2.15137076, 0.558953762, 0.0775076449, 0.825570107, 0.722433925, -0.534201145, -0.438984573, 0.406993419, 0.841796517, -0.354588091),
			cfn(1.26245594, -5.99997377, 0.147344589, 1.00000072, -2.5366503e-06, -2.98023224e-07, -2.50286234e-06, 0.999997318, -1.02932597e-06, -2.68220901e-07, -1.02135346e-06, 0.999999464),
			cfn(-1.16597474, -5.99992371, 0.0196756423, 0.500000179, -5.03950741e-06, 0.866026759, -7.20012224e-07, 0.999994636, -5.36440439e-06, -0.866025269, -2.05067545e-06, 0.499997884),
		}, .3, false)
	end
	so(2697295,SHandaru,.4,3)
	for i=0,1,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(-1.44382084e-05, -2, -3.52843199e-05, 0.500002384, 7.21910419e-06, -0.866024017, -1.88881022e-05, 1, -2.56920703e-06, 0.866024017, 1.76421599e-05, 0.500002384),
			cfn(-0.547627807, 4.48263931, -0.316102535, 0.500002384, -0.296216011, 0.813789785, 7.21910419e-06, 0.939686358, 0.34203741, -0.866024017, -0.171013653, 0.46984759),
			cfn(1.81868255, -0.103687182, -2.3519392, 0.377200723, 0.740163803, -0.556666017, 0.111620866, -0.633017302, -0.766048193, -0.919380486, 0.226818368, -0.321392298),
			cfn(-3.0397644, 2.26208973, -1.6833154, 0.658552945, -0.00924476981, 0.752477705, 0.592071891, -0.610833943, -0.525673687, 0.46449858, 0.791704834, -0.396792918),
			cfn(1.76254702, -5.99993086, -0.252668977, 0.500002384, -1.88881022e-05, 0.866024017, 7.21910419e-06, 1, 1.76421599e-05, -0.866024017, -2.56920703e-06, 0.500002384),
			cfn(-1.16592002, -5.99993467, 0.0196563601, 0.500002384, -1.88881022e-05, 0.866024017, 7.21910419e-06, 1, 1.76421599e-05, -0.866024017, -2.56920703e-06, 0.500002384),
		}, .2, false)
	end
	local hitpt = Instance.new("Part",EffectModel)
	hitpt.Size = v3(.7,.6,2.1)
	hitpt.CFrame = SSExit.CFrame * CFrame.Angles(0,math.rad(90),0)
	hitpt.Velocity = RootPart.CFrame.rightVector*30+v3(0,20,0)
	local hitm = Instance.new("SpecialMesh",hitpt)
	hitm.MeshId = "rbxassetid://94248124"
	hitm.TextureId = "rbxassetid://94219470"
	hitm.Scale = v3(4,4,4)
	coroutine.wrap(function()
		swait(30)
		for i = 0,1,.1 do
			swait()
			hitpt.Transparency = i
		end
		hitpt:Destroy()
	end)()
	swait(15)
	so(2697295,SHandaru,.5,3)
	for i=0,2,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(1.44002445e-06, -1.99998927, 1.07288088e-05, 0.500000179, -7.20012224e-07, -0.866025269, -5.03950741e-06, 0.999994636, -2.05067545e-06, 0.866026759, -5.36440439e-06, 0.499997884),
			cfn(-0.547573745, 4.48264122, -0.316118479, 0.500000179, -0.296203166, 0.813797355, -7.20012224e-07, 0.939689577, 0.342012942, -0.866025269, -0.17101118, 0.469843715),
			cfn(1.79884899, 0.344976842, -2.36338496, 0.362167031, 0.825433791, -0.433008999, 0.086823605, -0.492405862, -0.866018176, -0.928060055, 0.276049763, -0.249996945),
			cfn(-4.43855, 2.71461391, -2.15137076, 0.558953762, 0.0775076449, 0.825570107, 0.722433925, -0.534201145, -0.438984573, 0.406993419, 0.841796517, -0.354588091),
			cfn(1.26245594, -5.99997377, 0.147344589, 1.00000072, -2.5366503e-06, -2.98023224e-07, -2.50286234e-06, 0.999997318, -1.02932597e-06, -2.68220901e-07, -1.02135346e-06, 0.999999464),
			cfn(-1.16597474, -5.99992371, 0.0196756423, 0.500000179, -5.03950741e-06, 0.866026759, -7.20012224e-07, 0.999994636, -5.36440439e-06, -0.866025269, -2.05067545e-06, 0.499997884),
		}, .15, false)
	end
	slugged = false
	attack = false
end

function equippist()
	attack = true
	Humanoid.WalkSpeed = 2
	Humanoid.JumpPower = 0
	if CurrentWep == "Shotgun" then
		for i=0,2,.1 do
			swait()
			PlayAnimationFromTable({		
				cfn(0, -2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				cfn(-0.102602988, 4.45099878, 0.277624637, 0.939692736, -7.70138158e-08, -0.342019916, -0.0593909845, 0.984807849, -0.163175747, 0.33682391, 0.173647955, 0.925416648),
				cfn(4.50001526, 2.68827057, 0.743782997, 1, 0, 0, 0, -0.866025388, 0.500000238, 0, -0.500000238, -0.866025388),
				cfn(-4.79884863, 0.640861034, 0, 0.939692736, 0.342019886, 0, -0.342019916, 0.939692736, 0, 0, 0, 1),
				cfn(1.50001431, -6.00000048, 3.12924385e-06, 0.984807849, 0, -0.173647985, 0, 1, 0, 0.173647985, 0, 0.984807849),
				cfn(-1.5000186, -6.00000048, 9.83476639e-07, 0.984807849, 0, 0.173647985, 0, 1, 0, -0.173647985, 0, 0.984807849),
			}, .15, false)
		end
		SHandaru.Transparency = 1
		HolShot.Transparency = 0
		for i=0,1,.1 do
			swait()
			PlayAnimationFromTable({		
				cfn(0, -2, 0, 0.866025388, 0, 0.500000238, 0, 1, 0, -0.500000238, 0, 0.866025388) * cfn(0,.1 * math.cos((sine)/10), 0),
				cfn(0.147721067, 4.44785833, -0.255860269, 0.866025388, 0.0868240371, -0.492404163, 0, 0.984807849, 0.173647985, 0.500000238, -0.150383562, 0.852868617),
				cfn(4.80713892, 0.709604442, -2.81296843e-06, 0.939692855, -0.342019916, 2.08616257e-07, 0.342019856, 0.939692736, 1.5155652e-07, -2.08616257e-07, -8.94069672e-08, 1.00000024),
				cfn(-4.50001621, 0.190193266, -0.9294222, 1.00000024, 0, -2.98023224e-08, 0, 0.86602515, -0.500000358, 0, 0.500000417, 0.866025329),
				cfn(1.50001502, -5.99999952, 5.36441803e-07, 0.766044557, 0, -0.642787695, 0, 1, 0, 0.642787695, 0, 0.766044557) * cfn(0,-.1 * math.cos((sine)/10), 0),
				cfn(-1.50001943, -5.99999952, 0, 1.00000024, 0, 0, 0, 1, 0, 0, 0, 1.00000024) * cfn(0,-.1 * math.cos((sine)/10), 0),
			}, .3, false)
		end
	end
	for i=0,2,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(0, -1.99700248, -0.27749458, 1, 0, 0, 0, 0.984807849, 0.173647985, 0, -0.173647985, 0.984807849),
			cfn(0, 4.55108547, -0.444281816, 1, 0, 0, 0, 0.939692676, 0.342020601, 0, -0.342020601, 0.939692676),
			cfn(3.77304196, -0.53539288, 0.273614407, 0.939692736, 0.321393579, 0.116977744, -0.342019945, 0.883022368, 0.321393698, -8.56816769e-08, -0.342020065, 0.939692795),
			cfn(-4.64490843, 0.330175281, -1.53582289e-06, 0.984807849, 0.173648134, -3.13053391e-07, -0.173648164, 0.984807909, 2.68220901e-07, 3.50177288e-07, -1.78813934e-07, 1.00000012),
			cfn(1.50001884, -5.99037027, -0.421832889, 0.984807849, 0, -0.173647985, -0.0301536229, 0.984807849, -0.171009898, 0.171009898, 0.173647985, 0.969846487),
			cfn(-1.50002635, -5.99037027, -0.421831638, 0.984807849, 0, 0.173647985, 0.0301536229, 0.984807849, -0.171009898, -0.171009898, 0.173647985, 0.969846487),
		}, .15, false)
	end
	CurrentWep = "Pistol"
	PHandaru.Transparency = 0
	HolPist.Transparency = 1
	Humanoid.WalkSpeed = 8
	Humanoid.JumpPower = 70
	attack = false
end

function equipshot()
	attack = true
	Humanoid.WalkSpeed = 2
	Humanoid.JumpPower = 0
	if CurrentWep == "Pistol" then
		for i=0,2,.1 do
			swait()
			PlayAnimationFromTable({		
				cfn(0, -1.99700248, -0.27749458, 1, 0, 0, 0, 0.984807849, 0.173647985, 0, -0.173647985, 0.984807849),
				cfn(0, 4.55108547, -0.444281816, 1, 0, 0, 0, 0.939692676, 0.342020601, 0, -0.342020601, 0.939692676),
				cfn(3.77304196, -0.53539288, 0.273614407, 0.939692736, 0.321393579, 0.116977744, -0.342019945, 0.883022368, 0.321393698, -8.56816769e-08, -0.342020065, 0.939692795),
				cfn(-4.64490843, 0.330175281, -1.53582289e-06, 0.984807849, 0.173648134, -3.13053391e-07, -0.173648164, 0.984807909, 2.68220901e-07, 3.50177288e-07, -1.78813934e-07, 1.00000012),
				cfn(1.50001884, -5.99037027, -0.421832889, 0.984807849, 0, -0.173647985, -0.0301536229, 0.984807849, -0.171009898, 0.171009898, 0.173647985, 0.969846487),
				cfn(-1.50002635, -5.99037027, -0.421831638, 0.984807849, 0, 0.173647985, 0.0301536229, 0.984807849, -0.171009898, -0.171009898, 0.173647985, 0.969846487),
			}, .15, false)
		end
		PHandaru.Transparency = 1
		HolPist.Transparency = 0
		for i=0,1,.1 do
			swait()
			PlayAnimationFromTable({		
				cfn(0, -2, 0, 0.866025388, 0, 0.500000238, 0, 1, 0, -0.500000238, 0, 0.866025388) * cfn(0,.1 * math.cos((sine)/10), 0),
				cfn(0.147721067, 4.44785833, -0.255860269, 0.866025388, 0.0868240371, -0.492404163, 0, 0.984807849, 0.173647985, 0.500000238, -0.150383562, 0.852868617),
				cfn(4.80713892, 0.709604442, -2.81296843e-06, 0.939692855, -0.342019916, 2.08616257e-07, 0.342019856, 0.939692736, 1.5155652e-07, -2.08616257e-07, -8.94069672e-08, 1.00000024),
				cfn(-4.50001621, 0.190193266, -0.9294222, 1.00000024, 0, -2.98023224e-08, 0, 0.86602515, -0.500000358, 0, 0.500000417, 0.866025329),
				cfn(1.50001502, -5.99999952, 5.36441803e-07, 0.766044557, 0, -0.642787695, 0, 1, 0, 0.642787695, 0, 0.766044557) * cfn(0,-.1 * math.cos((sine)/10), 0),
				cfn(-1.50001943, -5.99999952, 0, 1.00000024, 0, 0, 0, 1, 0, 0, 0, 1.00000024) * cfn(0,-.1 * math.cos((sine)/10), 0),
			}, .3, false)
		end
	end
	for i=0,2,.1 do
		swait()
		PlayAnimationFromTable({		
			cfn(0, -2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
			cfn(-0.102602988, 4.45099878, 0.277624637, 0.939692736, -7.70138158e-08, -0.342019916, -0.0593909845, 0.984807849, -0.163175747, 0.33682391, 0.173647955, 0.925416648),
			cfn(4.50001526, 2.68827057, 0.743782997, 1, 0, 0, 0, -0.866025388, 0.500000238, 0, -0.500000238, -0.866025388),
			cfn(-4.79884863, 0.640861034, 0, 0.939692736, 0.342019886, 0, -0.342019916, 0.939692736, 0, 0, 0, 1),
			cfn(1.50001431, -6.00000048, 3.12924385e-06, 0.984807849, 0, -0.173647985, 0, 1, 0, 0.173647985, 0, 0.984807849),
			cfn(-1.5000186, -6.00000048, 9.83476639e-07, 0.984807849, 0, 0.173647985, 0, 1, 0, -0.173647985, 0, 0.984807849),
		}, .15, false)
	end
	CurrentWep = "Shotgun"
	SHandaru.Transparency = 0
	HolShot.Transparency = 1
	Humanoid.WalkSpeed = 8
	Humanoid.JumpPower = 70
	attack = false
end

function unequip()
	attack = true
	Humanoid.WalkSpeed = 2
	Humanoid.JumpPower = 0
	if CurrentWep == "Pistol" then
		for i=0,2,.1 do
			swait()
			PlayAnimationFromTable({		
				cfn(0, -1.99700248, -0.27749458, 1, 0, 0, 0, 0.984807849, 0.173647985, 0, -0.173647985, 0.984807849),
				cfn(0, 4.55108547, -0.444281816, 1, 0, 0, 0, 0.939692676, 0.342020601, 0, -0.342020601, 0.939692676),
				cfn(3.77304196, -0.53539288, 0.273614407, 0.939692736, 0.321393579, 0.116977744, -0.342019945, 0.883022368, 0.321393698, -8.56816769e-08, -0.342020065, 0.939692795),
				cfn(-4.64490843, 0.330175281, -1.53582289e-06, 0.984807849, 0.173648134, -3.13053391e-07, -0.173648164, 0.984807909, 2.68220901e-07, 3.50177288e-07, -1.78813934e-07, 1.00000012),
				cfn(1.50001884, -5.99037027, -0.421832889, 0.984807849, 0, -0.173647985, -0.0301536229, 0.984807849, -0.171009898, 0.171009898, 0.173647985, 0.969846487),
				cfn(-1.50002635, -5.99037027, -0.421831638, 0.984807849, 0, 0.173647985, 0.0301536229, 0.984807849, -0.171009898, -0.171009898, 0.173647985, 0.969846487),
			}, .15, false)
		end
		PHandaru.Transparency = 1
		HolPist.Transparency = 0
	elseif CurrentWep == "Shotgun" then
		for i=0,2,.1 do
			swait()
			PlayAnimationFromTable({		
				cfn(0, -2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				cfn(-0.102602988, 4.45099878, 0.277624637, 0.939692736, -7.70138158e-08, -0.342019916, -0.0593909845, 0.984807849, -0.163175747, 0.33682391, 0.173647955, 0.925416648),
				cfn(4.50001526, 2.68827057, 0.743782997, 1, 0, 0, 0, -0.866025388, 0.500000238, 0, -0.500000238, -0.866025388),
				cfn(-4.79884863, 0.640861034, 0, 0.939692736, 0.342019886, 0, -0.342019916, 0.939692736, 0, 0, 0, 1),
				cfn(1.50001431, -6.00000048, 3.12924385e-06, 0.984807849, 0, -0.173647985, 0, 1, 0, 0.173647985, 0, 0.984807849),
				cfn(-1.5000186, -6.00000048, 9.83476639e-07, 0.984807849, 0, 0.173647985, 0, 1, 0, -0.173647985, 0, 0.984807849),
			}, .15, false)
		end
		SHandaru.Transparency = 1
		HolShot.Transparency = 0
	end
	CurrentWep = "CQC"
	Humanoid.WalkSpeed = 8
	Humanoid.JumpPower = 70
	attack = false
end

Mouse.Button1Down:connect(function()
	if attack == false then
		if CurrentWep == "Pistol" then
			pshoot()
		elseif CurrentWep == "Shotgun" then
			if slugged == true then
				slugshoot()
			else
				sshoot()
			end
		else
			smek()
		end
	end
end)

local sprintt = 0
Mouse.KeyDown:connect(function(k)
	k = k:lower()
	if k=='m' then
		if mus.IsPlaying == true then
			mus:Stop()
		elseif mus.IsPaused == true then
			mus:Play()
		end
	end
	if attack == false then
		if k == 'z' then
			if CurrentWep == "Shotgun" and slugged == false then
				slugload()
			elseif CurrentWep == "CQC" then
				slam()
			end
		elseif k == 'f' then
			smek()
		elseif k == 'x' then
			xhold = true
			if CurrentWep == "CQC" then
				thesurou()
			end	
		elseif k == 'c' then
			chold = true
			if CurrentWep == "CQC" then
				headrip()
			end
		elseif k == 'v' then
			stomp()
		elseif k == 't' then
			if CurrentWep ~= "Pistol" then
				equippist()
			else
				unequip()
			end
		elseif k == 'y' then
			if CurrentWep ~= "Shotgun" then
				equipshot()
			else
				unequip()
			end
		end
	end
end)

Mouse.KeyUp:connect(function(k)
	if k == 'x' then
		xhold = false
	elseif k == 'c' then
		chold = false
	end
end)

coroutine.wrap(function()
	game:GetService("RunService").RenderStepped:connect(function()
		for i,v in pairs(chara:GetDescendants()) do
			if v:IsA("BasePart") and v.Parent.Name ~= "FakeHeadM" and v.Name ~= "Head" and v.Parent:IsA("Accessory") == false then
				v.LocalTransparencyModifier = 0
			end
		end
	end)
end)()

coroutine.wrap(function()
	while 1 do
		swait()
		if doe <= 360 then
			doe = doe + 2
		else
			doe = 0
		end
	end
end)()
local lt = tick()
local pistolsize = v3(1, 3, 5)
local sgsize = v3(12, 3, 2)
it = true
while true do
	swait()
	Head.Transparency = 1
	if Head:FindFirstChild("face") then
		Head:FindFirstChild("face").Transparency = 1
	end
	if chara:FindFirstChild("mus")==nil then
		mus = Instance.new("Sound",chara)
		mus.Name = "mus"
		mus.SoundId = "rbxasset://songs/mnlibs/In the Final.ogg"--"rbxassetid://335204822"
		mus.Looped = true
		mus.Volume = 1
		mus:Play()
	end
	if sprintt >= 1 then
		sprintt = sprintt - 1
	end
	Torsovelocity = (RootPart.Velocity * v3(1, 0, 1)).magnitude
	velocity = RootPart.Velocity.y
	sine = sine + change
	local hit, pos = rayCast(RootPart.Position, (cfn(RootPart.Position, RootPart.Position - v3(0, 1, 0))).lookVector, 12, chara)
	if RootPart.Velocity.y > 1 and hit == nil then 
		Anim = "Jump"
		if attack == false then
			PlayAnimationFromTable({
				cfn(0, 0.0294559821, -0.246550545, 1, 0, 0, 0, 0.939692736, 0.342019886, 0, -0.342019916, 0.939692736),
				cfn(0, 4.29474068, 0.563813269, 1, 0, 0, 0, 0.939692736, -0.342019916, 0, 0.342019886, 0.939692736),
				cfn(3.55814481, -0.469561696, -5.11224357e-07, 0.939692616, 0.342020273, -4.69496833e-08, -0.342020273, 0.939692736, 5.36441803e-07, 2.38418579e-07, -5.06639481e-07, 1),
				cfn(-3.56861424, -0.512341022, -1.44051228e-06, 0.939692616, -0.342020273, 4.69496833e-08, 0.342020273, 0.939692736, 5.36441803e-07, -2.38418579e-07, -5.06639481e-07, 1),
				cfn(1.50001526, -3.80000091, -1.39999759, 1, 0, 0, 0, 1, -2.98023224e-08, 0, -2.98023224e-08, 1),
				cfn(-1.50001621, -5.99999809, 1.13248825e-06, 1, 0, 0, 0, 1, -2.98023224e-08, 0, -2.98023224e-08, 1),
			}, .1, false)
		end
	elseif RootPart.Velocity.y < -1 and hit == nil then 
		Anim = "Fall"
		if attack == false then
			PlayAnimationFromTable({
				cfn(-1.05621432e-07, -2.434778869, -0.0625008196, 1.00000024, 4.33864784e-08, -9.66617677e-07, 6.05497235e-07, 0.939693511, -0.342021585, 3.16162158e-07, 0.34202069, 0.939693451),
				cfn(1.90734863e-06, 4.4037199, -0.67802453, 1, 0, 0, 0, 0.866025686, 0.499999642, 0, -0.499999642, 0.866025686),
				cfn(4.85359192, 1.0866574, -1.10285725e-06, 0.866025507, -0.49999994, -1.54857389e-07, 0.5, 0.866025507, -1.1920929e-07, 1.78813934e-07, 2.98023224e-08, 1),
				cfn(-4.92668247, 0.72687763, 4.47010007e-06, 0.939692616, 0.342020273, 4.69496833e-08, -0.342020273, 0.939692736, -5.36441803e-07, -2.38418579e-07, 5.06639481e-07, 1),
				cfn(1.50001335, -3.80000305, -1.39999592, 1, 0, 0, 0, 1, 2.98023224e-08, 0, 2.98023224e-08, 1),
				cfn(-1.50002098, -6.00000477, 1.72853458e-06, 1, 0, 0, 0, 1, 2.98023224e-08, 0, 2.98023224e-08, 1),
			}, .1, false)
		end
	elseif Torsovelocity < 1 and hit ~= nil then
		Anim = "Idle"
		if attack == false then
			change = 1
			if CurrentWep == "CQC" then
				PlayAnimationFromTable({
					cfn(0, -2, 0, 0.866025388, 0, 0.500000238, 0, 1, 0, -0.500000238, 0, 0.866025388) * cfn(0,.1 * math.cos((sine)/10), 0),
					cfn(0.147721067, 4.44785833, -0.255860269, 0.866025388, 0.0868240371, -0.492404163, 0, 0.984807849, 0.173647985, 0.500000238, -0.150383562, 0.852868617),
					cfn(4.80713892, 0.709604442, -2.81296843e-06, 0.939692855, -0.342019916, 2.08616257e-07, 0.342019856, 0.939692736, 1.5155652e-07, -2.08616257e-07, -8.94069672e-08, 1.00000024),
					cfn(-4.50001621, 0.190193266, -0.9294222, 1.00000024, 0, -2.98023224e-08, 0, 0.86602515, -0.500000358, 0, 0.500000417, 0.866025329),
					cfn(1.50001502, -5.99999952, 5.36441803e-07, 0.766044557, 0, -0.642787695, 0, 1, 0, 0.642787695, 0, 0.766044557) * cfn(0,-.1 * math.cos((sine)/10), 0),
					cfn(-1.50001943, -5.99999952, 0, 1.00000024, 0, 0, 0, 1, 0, 0, 0, 1.00000024) * cfn(0,-.1 * math.cos((sine)/10), 0),
				}, .3, false)
			elseif CurrentWep == "Shotgun" then
				PlayAnimationFromTable({
					cfn(0, -2, 0, 0.499998987, 0, -0.866025984, 0, 1, 0, 0.866025984, 0, 0.499998987) * cfn(0,.1 * math.cos((sine)/10), 0),
					cfn(-0.547520339, 4.48267984, -0.316110164, 0.499998987, -0.29619813, 0.813798308, 0, 0.939692736, 0.342019886, -0.866025984, -0.171009615, 0.469845414),
					cfn(3.21991515, 0.397024989, -1.54293764, 0.344303846, 0.926736116, 0.150382981, -0.030152997, 0.17100893, -0.984807968, -0.938374043, 0.334538639, 0.0868228972),
					cfn(-3.26355648, -1.19176984, -1.47300911, 0.0174857043, 0.276001155, 0.960998297, 0.995382905, -0.0955301225, 0.00932515692, 0.0943780318, 0.956398189, -0.276397288),
					cfn(1.26245594, -5.99997377, 0.147344589, 1.00000072, -2.5366503e-06, -2.98023224e-07, -2.50286234e-06, 0.999997318, -1.02932597e-06, -2.68220901e-07, -1.02135346e-06, 0.999999464) * cfn(0,-.1 * math.cos((sine)/10), 0),
					cfn(-1.16597474, -5.99992371, 0.0196756423, 0.500000179, -5.03950741e-06, 0.866026759, -7.20012224e-07, 0.999994636, -5.36440439e-06, -0.866025269, -2.05067545e-06, 0.499997884) * cfn(0,-.1 * math.cos((sine)/10), 0),
				}, .3, false)
			elseif CurrentWep == "Pistol" then
				PlayAnimationFromTable({
					cfn(0, -2.03907442, 0.0466268957, 1, 0, 0, 0, 0.984807849, -0.173647985, 0, 0.173647985, 0.984807849) * cfn(0,.1 * math.cos((sine)/10), 0),
					cfn(0, 4.27439117, -0.749502182, 1, 0, 0, 0, 0.866025686, 0.499999642, 0, -0.499999642, 0.866025686),
					cfn(4.50001526, 0.888218164, -1.46819997, 1, 0, 0, 0, 0.342019796, -0.939692855, 0, 0.939692855, 0.342019796),
					cfn(-3.79128027, -0.462018341, -0.549682617, 0.939692497, -0.336824238, -0.0593918264, 0.321393669, 0.928998291, -0.183489919, 0.11697875, 0.153335959, 0.981225848),
					cfn(1.50001526, -5.90884781, 0.64188838, 1, 0, 0, 0, 0.984807849, 0.173647985, 0, -0.173647985, 0.984807849) * cfn(0,-.1 * math.cos((sine)/10), 0),
					cfn(-1.50001526, -5.90884781, 0.64188838, 1, 0, 0, 0, 0.984807849, 0.173647985, 0, -0.173647985, 0.984807849) * cfn(0,-.1 * math.cos((sine)/10), 0),
				}, .3, false)
			end
		end
	elseif Torsovelocity > 2 and hit ~= nil then
		Anim = "Walk"
		if attack == false then
			Humanoid.WalkSpeed = 8
			Humanoid.JumpPower = 70
			if CurrentWep == "CQC" then
				PlayAnimationFromTable({
					cfn(0, -2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) * cfn(0, 0- .08 * math.cos((sine) / 5), 0) * CFrame.Angles(0, math.rad(0 + -5 * math.cos((sine) / 10)), 0),
					cfn(0, 4.41427088, -0.820159078, 1, 0, 0, 0, 0.939692438, 0.342020929, 0, -0.342020959, 0.939692438) * CFrame.Angles(0, math.rad(0 + 5 * math.cos((sine) / 10)), 0),
					cfn(4.50001478, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) * cfn(0, 0, 0- 1.5 * math.cos((sine) / 10)) * CFrame.Angles(math.rad(0 + 30 * math.cos((sine) / 10)), 0, 0),
					cfn(-4.50001478, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) * cfn(0, 0, 0+ 1.5 * math.cos((sine) / 10)) * CFrame.Angles(math.rad(0 - 30 * math.cos((sine) / 10)), 0, 0),
					cfn(1.50001502, -6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) * cfn(0, 0, 0+ 1.5 * math.cos((sine) / 10)) * CFrame.Angles(math.rad(0 - 30 * math.cos((sine) / 10)), 0, 0),
					cfn(-1.50001502, -6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) * cfn(0, 0, 0- 1.5 * math.cos((sine) / 10)) * CFrame.Angles(math.rad(0 + 30 * math.cos((sine) / 10)), 0, 0),
				}, .3, false)
			elseif CurrentWep == "Shotgun" then
				PlayAnimationFromTable({
					cfn(0, -2, 0, 0.499998987, 0, -0.866025984, 0, 1, 0, 0.866025984, 0, 0.499998987) * cfn(0, 0- .08 * math.cos((sine) / 5), 0) * CFrame.Angles(0, 0, 0),
					cfn(-0.547520339, 4.48267984, -0.316110164, 0.499998987, -0.29619813, 0.813798308, 0, 0.939692736, 0.342019886, -0.866025984, -0.171009615, 0.469845414),
					cfn(3.21991515, 0.397024989, -1.54293764, 0.344303846, 0.926736116, 0.150382981, -0.030152997, 0.17100893, -0.984807968, -0.938374043, 0.334538639, 0.0868228972),
					cfn(-3.26355648, -1.19176984, -1.47300911, 0.0174857043, 0.276001155, 0.960998297, 0.995382905, -0.0955301225, 0.00932515692, 0.0943780318, 0.956398189, -0.276397288),
					cfn(1.76242733, -6, -0.252659202, 0.499998987, 0, 0.866025984, 0, 1, 0, -0.866025984, 0, 0.499998987) * cfn(0, 0, 0+ 1.5 * math.cos((sine) / 10)) * CFrame.Angles(math.rad(0 - 30 * math.cos((sine) / 10)), 0, 0),
					cfn(-1.16602993, -6, 0.0196474195, 0.499998987, 0, 0.866025984, 0, 1, 0, -0.866025984, 0, 0.499998987) * cfn(0, 0, 0- 1.5 * math.cos((sine) / 10)) * CFrame.Angles(math.rad(0 + 30 * math.cos((sine) / 10)), 0, 0),
				}, .3, false)
			elseif CurrentWep == "Pistol" then
				PlayAnimationFromTable({
					cfn(0, -2.03907442, 0.0466268957, 1, 0, 0, 0, 0.984807849, -0.173647985, 0, 0.173647985, 0.984807849) * cfn(0, 0- .08 * math.cos((sine) / 5), 0) * CFrame.Angles(0, 0, 0),
					cfn(0, 4.27439117, -0.749502182, 1, 0, 0, 0, 0.866025686, 0.499999642, 0, -0.499999642, 0.866025686),
					cfn(4.50001526, 0.888218164, -1.46819997, 1, 0, 0, 0, 0.342019796, -0.939692855, 0, 0.939692855, 0.342019796),
					cfn(-3.79128027, -0.462018341, -0.549682617, 0.939692497, -0.336824238, -0.0593918264, 0.321393669, 0.928998291, -0.183489919, 0.11697875, 0.153335959, 0.981225848),
					cfn(1.50001526, -5.90884781, 0.64188838, 1, 0, 0, 0, 0.984807849, 0.173647985, 0, -0.173647985, 0.984807849) * cfn(0, 0, 0+ 1.5 * math.cos((sine) / 10)) * CFrame.Angles(math.rad(0 - 30 * math.cos((sine) / 10)), 0, 0),
					cfn(-1.50001526, -5.90884781, 0.64188838, 1, 0, 0, 0, 0.984807849, 0.173647985, 0, -0.173647985, 0.984807849) * cfn(0, 0, 0- 1.5 * math.cos((sine) / 10)) * CFrame.Angles(math.rad(0 + 30 * math.cos((sine) / 10)), 0, 0),
				}, .3, false)
			end
		end
	end
	if tick()-lt > .1 then
		lt = tick()
		if IntroDone then
			renderModels.Shedo(FakeHead.CFrame)

		end
		if CurrentWep == "Shotgun" then
			getgenv().FEEffects.Part({
				size = sgsize,
				startpos = SHandaru.CFrame,
				trans = SHandaru.Transparency,
				Color = SHandaru.Color,
				material = SHandaru.Material,
			})
			getgenv().FEEffects.Part({
				size = pistolsize,
				startpos = HolPist.CFrame,
				trans = HolPist.Transparency,
				Color = HolPist.Color,
				material = HolPist.Material,
			})
		elseif CurrentWep == "Pistol" then
			getgenv().FEEffects.Part({
				size = pistolsize,
				startpos = PHandaru.CFrame,
				trans = PHandaru.Transparency,
				Color = PHandaru.Color,
				material = PHandaru.Material,
			})
			getgenv().FEEffects.Part({
				size = sgsize,
				startpos = HolShot.CFrame,
				trans = HolShot.Transparency,
				Color = HolShot.Color,
				material = HolShot.Material,
			})
		else
			getgenv().FEEffects.Part({
				size = pistolsize,
				startpos = HolPist.CFrame,
				trans = HolPist.Transparency,
				Color = HolPist.Color,
				material = HolPist.Material,
			})
			getgenv().FEEffects.Part({
				size = sgsize,
				startpos = HolShot.CFrame,
				trans = HolShot.Transparency,
				Color = HolShot.Color,
				material = HolShot.Material,
			})
		end
	end
end
