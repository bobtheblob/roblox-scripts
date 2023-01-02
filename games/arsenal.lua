
getgenv().boxes = {}
local LPlayer = game:GetService("Players").LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LPlayer:GetMouse()
local Closestplayer
local Settings = {
	ESPEnabled = true,
	AimbotEnabled = false,
	SmoothAimbot = false,
	AimbotSmoothness = .4,
	Prediction = false,
	PredictionStrength = 2,
	AimbotFOV = 120,
	FOVEnabled = true,
	SilentAim = false,
	AutoFire = false
}
function httprequire(link)
	return loadstring(game:HttpGet(link))()
end
local HealthLib = {}
function HealthLib.IsDead(player)
	local nrpbs = player:FindFirstChild("NRPBS")
	if not nrpbs then return true end
	local health = nrpbs:FindFirstChild("Health")
	return health.Value <= 0
end
function HealthLib.GetHealth(player)
	local nrpbs = player:FindFirstChild("NRPBS")
	if not nrpbs then return true end
	local health = nrpbs:FindFirstChild("Health")
	return health.Value
end
function HealthLib.GetMaxHealth(player)
	local nrpbs = player:FindFirstChild("NRPBS")
	if not nrpbs then return true end
	local health = nrpbs:FindFirstChild("MaxHealth")
	return health.Value
end
local ESPLib = {}
ESPLib.__index = ESPLib
function ESPLib.new()
	return setmetatable({
		boxes = {}
	},ESPLib)
end
function ESPLib:addPlayer(player)
	if player ~= LPlayer then
		local s,f= pcall(function()
			local box = Drawing.new("Square")
			box.Visible = true
			box.Transparency = 2
			box.Color = Color3.fromRGB(255,255,255)
			box.Thickness = 1
			box.Size = Vector2.new(200,400)
			box.Position = Vector2.new(850,300)
			box.Filled = false
			box.ZIndex = 2
			local obox = Drawing.new("Square")
			obox.Visible = true
			obox.Transparency = 1
			obox.Color = Color3.fromRGB()
			obox.Thickness = 5
			obox.Size = Vector2.new(200,400)
			obox.Position = Vector2.new(850,300)
			obox.Filled = false
			table.insert(getgenv().boxes,{
				player,
				box,
				obox
			})
		end)
		if f then
			warn(f)
		end
	end
end
function ESPLib:removePlayer(player)
	local s,f= pcall(function()
		for i,v in pairs(getgenv().boxes) do
			if v[1] == player then
				getgenv().boxes[i][2]:Destroy()
				getgenv().boxes[i][3]:Destroy()
				getgenv().boxes[i] = nil
			end
		end
	end)
	if f then
		warn(f)
	end
end
function ESPLib:update()
	for i,v in pairs(getgenv().boxes) do
		local char = v[1].Character
		if char and Settings.ESPEnabled then
			local root = char:FindFirstChild("HumanoidRootPart")
			local head = char:FindFirstChild("Head")
			if root and head and HealthLib.IsDead(v[1]) == false then
				local rootPos, onScreen = Camera:WorldToViewportPoint(root.Position)
				local headPos = Camera:WorldToViewportPoint(head.Position+Vector3.new(0,.5,0))
				local legPos = Camera:WorldToViewportPoint(root.Position-Vector3.new(0,3,0))
				v[2].Visible = onScreen
				v[3].Visible = onScreen
				if onScreen then
					local hp = HealthLib.GetHealth(v[1])
					local mhp = HealthLib.GetMaxHealth(v[1])
					local value = math.clamp(hp/mhp,0,1)
					--Color3.fromHSV(value/3,1,1)
					local bgcol = Color3.fromHSV(value/3,1,1)
					if v[1].Team then
						bgcol = v[1].Team.TeamColor.Color
					end
					v[2].Color = bgcol
					v[2].Size = Vector2.new(1000 / rootPos.Z, (headPos.Y - legPos.Y))
					v[2].Position = Vector2.new(rootPos.X - v[2].Size.X / 2, rootPos.Y - v[2].Size.Y / 2)

					v[3].Size = Vector2.new(1000 / rootPos.Z, (headPos.Y - legPos.Y))
					v[3].Position = Vector2.new(rootPos.X - v[2].Size.X / 2, rootPos.Y - v[2].Size.Y / 2)
				end
			else
				v[2].Visible = false
				v[3].Visible = false
			end
		else
			v[2].Visible = false
			v[3].Visible = false
		end
	end
end
--
local ClosestLib = {}
function ClosestLib.GetClosestPlayer(behindWallCheck,teamCheck)
	local Closest = {math.huge, nil}
	local MousePos = Vector2.new(Mouse.X, Mouse.Y)
	for _, Player in pairs(game:GetService("Players"):GetPlayers()) do
		if Player == LPlayer then continue end
		local Character = Player.Character
		if Character then
			local HumanoidRootPart = Character:FindFirstChild("Head") or Character:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart then
				local vector, onScreen = Camera:WorldToViewportPoint(HumanoidRootPart.Position)
				local notBehind = true
				local notOurTeam = true
				if teamCheck then
					notOurTeam = LPlayer.Team ~= Player.Team
				end
				if behindWallCheck then
					local mag = (HumanoidRootPart.Position-Camera.CFrame.Position).Magnitude
					local cf = CFrame.new(Camera.CFrame.Position,HumanoidRootPart.Position)
					local ray = Ray.new(cf.p,cf.LookVector * mag)
					local hit,pos = workspace:FindPartOnRayWithWhitelist(ray,{workspace:WaitForChild("Ray_Ignore"),workspace:WaitForChild("Map")},true)
					if hit then
						notBehind = false
					end
				end
				if onScreen and notBehind and notOurTeam and HealthLib.IsDead(Player) == false then
					local Distance = (MousePos - Vector2.new(vector.X, vector.Y)).Magnitude
					if  Distance < Closest[1] and Distance < Settings.AimbotFOV then
						Closest = {Distance, Player}
					end
				end
			end
		end
	end
	return Closest
end
local s,f = pcall(function()
	genv = genv or {}
	Drawing = Drawing
	cloneref = cloneref or function(c) return c end
	getgenv = getgenv or function() return genv end
	assert(Drawing,"This exploit does not support Drawing Library!")
	--
	local lib = httprequire("https://raw.githubusercontent.com/bobtheblob/roblox-scripts/main/uilib/uilibrary.lua")
	local window = lib:newWindow("arsenal")
	local AimbotTab = window:createTab("Aimbot")
	local ESPTab = window:createTab("ESP")
	local MiscTab = window:createTab("Misc")
	--
	AimbotTab:createToggle('Aimbot',function(v)
		Settings.AimbotEnabled  = v
	end)
	AimbotTab:createToggle('Silent Aim',function(v)
		Settings.SilentAim  = v
	end)
	AimbotTab:createToggle('Auto Fire',function(v)
		Settings.AutoFire  = v
	end)
	AimbotTab:createToggle('Circle Toggle',function(v)
		Settings.FOVEnabled  = v
	end,true)
	AimbotTab:createToggle('Smooth Aimbot Toggle',function(v)
		Settings.SmoothAimbot  = v
	end)
	AimbotTab:createToggle('Prediction Toggle',function(v)
		Settings.Prediction  = v
	end)
	AimbotTab:createSlider('Aimbot FOV',0,1000,120).onMove:Connect(function(v)
		Settings.AimbotFOV = v
	end)
	AimbotTab:createSlider('Aimbot Smoothness',0,1,.4).onMove:Connect(function(v)
		Settings.AimbotSmoothness = v
	end)
	AimbotTab:createSlider('Prediction Strength',0,20,3).onMove:Connect(function(v)
		Settings.PredictionStrength = v
	end)
	--
	ESPTab:createToggle('ESP Toggle',function(v)
		Settings.ESPEnabled  = v
	end,true)
	--
	local Circle = Drawing.new("Circle")
	Circle.Visible = Settings.FOVEnabled
	Circle.Radius = Settings.AimbotFOV
	Circle.Transparency = 1
	Circle.Color = Color3.fromRGB(255,255,255)
	Circle.Thickness = 1
	Circle.Filled = false
	Circle.Position = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
	--
	local esp = ESPLib.new()
	getgenv().espcons = {}
	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
		esp:addPlayer(v)
	end
	getgenv().espcons[#getgenv().espcons+1] = game:GetService("Players").PlayerAdded:Connect(function(v)
		esp:addPlayer(v)
	end)
	getgenv().espcons[#getgenv().espcons+1] = game:GetService("Players").PlayerRemoving:Connect(function(v)
		esp:removePlayer(v)
	end)
	--
	local atlast
	getgenv().scriptcons = {}
	getgenv().scriptcons[#getgenv().scriptcons+1] = game:GetService("RunService").RenderStepped:Connect(function()
		local s,f = pcall(function()
			Circle.Position = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
			Circle.Visible = Settings.FOVEnabled
			Circle.Radius = Settings.AimbotFOV
			Closestplayer = ClosestLib.GetClosestPlayer(true,true)
			task.spawn(function()
				if HealthLib.IsDead(LPlayer) == false and Settings.AimbotEnabled and LPlayer.Character then
					local playerhead = LPlayer.Character:FindFirstChild("Head")
					if Closestplayer and Closestplayer[2] then
						local char = Closestplayer[2].Character
						if char then
							atlast = char
							local aimpart = char:FindFirstChild("Head")
							local root = char:FindFirstChild("HumanoidRootPart")
							local predict = Vector3.new()
							if Settings.Prediction then
								predict = root.Velocity * (Settings.PredictionStrength/10) * (playerhead.Position - aimpart.Position).magnitude / 100
							end
							local lastCF = Camera.CFrame
							if Settings.SmoothAimbot then
								Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position,aimpart.Position+predict),Settings.AimbotSmoothness)
							else
								Camera.CFrame = CFrame.new(Camera.CFrame.Position,aimpart.Position+predict)
							end
							if Settings.AutoFire then
								game:GetService("VirtualUser"):Button1Down(Vector2.new())
							end
						else
							if atlast ~= nil then
								atlast = nil
								game:GetService("VirtualUser"):Button1Up(Vector2.new())
							end
						end
					else
						if atlast ~= nil then
							atlast = nil
							game:GetService("VirtualUser"):Button1Up(Vector2.new())
						end
					end
				end
			end)
			esp:update()
		end)
		if f then
			warn(f)
		end
	end)
	--
	local mt = getrawmetatable(game)
	setreadonly(mt, false)

	local old = mt.__namecall
	local oldG = game.GetService

	mt.__namecall = function(self, ...)
		local arguments = {...}
		local method = getnamecallmethod()
		if method == "Raycast"  and Settings.SilentAim and Closestplayer and Closestplayer[2] ~= nil and HealthLib.IsDead(Closestplayer[2]) == false then
			
		end
		return old(self, ...) 
	end
	--
	window.onRemoved:Connect(function() 
		for i,v in pairs(getgenv().scriptcons) do
			v:Disconnect()
		end
		for i,v in pairs(getgenv().espcons) do
			v:Disconnect()
		end
		getgenv().scriptcons = {}
		getgenv().espcons = {}
		for i,v in pairs(getgenv().boxes) do
			v[2]:Destroy()
			v[3]:Destroy()
		end
		getgenv().boxes = nil
		Circle:Destroy()
		mt.__namecall = old
	end)
end)
if f then
	warn("SCRIPT ERROR : "..f)
end
