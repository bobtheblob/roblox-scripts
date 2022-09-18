--[[ Documentation

// gui
gui:newWindow(name)
	name = string
	returns window
// window

window.isremoved : bool

window:createTab(name)
	name = string
	returns tab
window:getInstance()
	returns ScreenGui
// tab
tab:createButtons()
	returns buttons
tab:createToggle(name,func,default)
	name = string
	func (optional) = function {
		returns boolean
	}
	default = boolean or false
	returns toggle
tab:createTextbox(name,func)
	name = string
	func (optional) = function {
		returns string
	}
	returns textbox
tab:createLabel(text)
	text = string
	returns label
// label
label:update(text,size,font)
	text = string
	size = number
	font = Font
label:getText()
	returns string
label:changecol(color)
	color = Color3 
// textbox
textbox:getText()
	returns string
textbox:update(txt)
	txt = string
// buttons
buttons:createButton(name,func)
	name = string
	func = function
	returns TextButton
// toggle
toggle:getToggled()
	returns boolean
	
toggle:update(boolean)
]]

--[[ Example
local window = gui:newWindow("guid")
local tab1 = window:createTab("Tab1")
local tab2 = window:createTab("Tab2")
local bts = tab1:createButtons()
local toggle = tab1:createToggle("Toggle",function(b)
	print(b)
end)
local tb = tab1:createTextbox("Textbox",function(text)
	print(text)
end)
bts:createButton("Button1",function()
	print('Hey')
end)
bts:createButton("Button2",function()
	print('Hi')
end)
bts:createButton("Button3",function()
	print('Hello')
end)
]]
--
local tabb = {}
local tb = {}
local buttons = {}
local toggle = {}
local gui = {}
tb.__index = tb
buttons.__index = buttons
toggle.__index = toggle
tabb.__index = tabb
gui.__index = gui
function fakehui()
	return game:GetService("CoreGui")
end
local hui = fakehui
function gui:newWindow(name)
	local ScreenGui = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local Categories = Instance.new("ScrollingFrame")
	local CateTemp = Instance.new("TextButton")
	local UIListLayout = Instance.new("UIListLayout")
	local Title = Instance.new("TextLabel")
	local PageHolder = Instance.new("Frame")
	local Line = Instance.new("Frame")
	local event = Instance.new("BindableEvent")
	event.Parent = ScreenGui
	local tabla = {
		ScreenGui = ScreenGui,
		Categories = Categories,
		PageHolder = PageHolder,
		Tabs = 0,
		CurrentTab = nil,
		LastTab = nil,
		onRemoved = event.Event,
		isremoved = false,
	}
	ScreenGui.Parent = hui()
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Main.Name = "Main"
	Main.Parent = ScreenGui
	Main.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0, 18, 0, 13)
	Main.Size = UDim2.new(0, 393, 0, 242)
	Main.Draggable = true
	Main.Active = true

	Categories.Name = "Categories"
	Categories.Parent = Main
	Categories.Active = true
	Categories.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Categories.BackgroundTransparency = 0.800
	Categories.BorderSizePixel = 0
	Categories.Position = UDim2.new(0, 2, 0, 30)
	Categories.Size = UDim2.new(0, 74, 0, 203)
	Categories.BottomImage = ""
	Categories.CanvasSize = UDim2.new(0, 0, 1, 0)
	Categories.ScrollBarThickness = 4
	Categories.TopImage = ""



	UIListLayout.Parent = Categories
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0.00999999978, 0)
	Categories.ChildAdded:Connect(function()
		Categories.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y+100)
	end)

	Title.Name = "Title"
	Title.Parent = Main
	Title.Text = name
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0, 6, 0, 4)
	Title.Size = UDim2.new(0, 377, 0, 17)
	Title.Font = Enum.Font.SourceSans
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextScaled = true
	Title.TextSize = 14.000
	Title.TextStrokeTransparency = 0.500
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Left

	local B = Instance.new("TextButton")
	B.Name = "Exit"
	B.Parent = Main
	B.Text = ""
	B.BackgroundColor3 = Color3.fromRGB(240, 0, 0)
	B.BackgroundTransparency = 0
	B.Position = UDim2.new(0, 393/1.05, 0, 4)
	B.Size = UDim2.new(0, 16, 0, 16)
	B.MouseButton1Down:Connect(function() event:Fire() Main:Destroy() tabla.isremoved = true end)

	PageHolder.Name = "PageHolder"
	PageHolder.Parent = Main
	PageHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PageHolder.BackgroundTransparency = 1.000
	PageHolder.Position = UDim2.new(0, 76, 0, 25)
	PageHolder.Size = UDim2.new(0, 312, 0, 217)

	Line.Name = "Line"
	Line.Parent = Main
	Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 2, 0, 23)
	Line.Size = UDim2.new(0, 385, 0, 2)
	return setmetatable(tabla,gui)
end
function gui:getInstance() return self.ScreenGui end
function gui:createTab(name)
	local Page = Instance.new("Frame")
	local Title_2 = Instance.new("TextLabel")
	local List = Instance.new("ScrollingFrame")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local Tab = Instance.new("TextButton")

	if self.Tabs ~= 0 then
		Page.Visible = false
	else
		self.CurrentTab = Page
	end
	self.Tabs = self.Tabs + 1
	Page.Name = name.."Page"
	Page.Parent = self.PageHolder
	Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Page.Size = UDim2.new(0, 312, 0, 217)
	Page.BackgroundTransparency = 1

	Title_2.Name = "Title"
	Title_2.Parent = Page
	Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_2.BackgroundTransparency = 1.000
	Title_2.Position = UDim2.new(0, 5, 0, 6)
	Title_2.Size = UDim2.new(0, 306, 0, 17)
	Title_2.Font = Enum.Font.SourceSans
	Title_2.Text = name
	Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_2.TextScaled = true
	Title_2.TextSize = 14.000
	Title_2.TextStrokeTransparency = 0.500
	Title_2.TextWrapped = true
	Title_2.TextXAlignment = Enum.TextXAlignment.Left

	List.Name = "List"
	List.Parent = Page
	List.Active = true
	List.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	List.BackgroundTransparency = 1.000
	List.BorderSizePixel = 0
	List.Position = UDim2.new(0, 2, 0, 27)
	List.Size = UDim2.new(0, 305, 0, 182)
	List.BottomImage = ""
	List.CanvasSize = UDim2.new(0, 0, 0, 526)
	List.ScrollBarThickness = 4
	List.TopImage = ""

	UIListLayout_2.Parent = List
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 3)
	List.ChildAdded:Connect(function()
		List.CanvasSize = UDim2.new(0,0,0,UIListLayout_2.AbsoluteContentSize.Y+100)
	end)

	Tab.Name = name
	Tab.Text = name
	Tab.Parent = self.Categories
	Tab.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
	Tab.BorderSizePixel = 0
	Tab.Size = UDim2.new(0, 68, 0, 24)
	Tab.Font = Enum.Font.SourceSans
	Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
	Tab.TextScaled = true
	Tab.TextSize = 24.000
	Tab.TextStrokeTransparency = 0.500
	Tab.TextWrapped = true
	Tab.MouseButton1Down:Connect(function()
		if self.CurrentTab == Page then return end
		self.CurrentTab.Visible = false
		self.LastTab = self.CurrentTab
		self.CurrentTab = Page
		Page.Visible = true
	end)
	return setmetatable({
		Tab = Tab,
		List = List,
	},tabb)
end

function tabb:createButtons()
	local Buttons = Instance.new("Frame")
	local UIListLayout_3 = Instance.new("UIListLayout")
	local bt = {}

	Buttons.Name = "Buttons"
	Buttons.Parent = self.List
	Buttons.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
	Buttons.BackgroundTransparency = 1.000
	Buttons.BorderSizePixel = 0
	Buttons.Position = UDim2.new(0, 0, 0, 57)
	Buttons.Size = UDim2.new(0, 298, 0, 26)

	UIListLayout_3.Parent = Buttons
	UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_3.Padding = UDim.new(0, 5)

	return setmetatable({
		ButtonList = {},
		Buttons = Buttons
	},buttons)
end
function buttons:createButton(name,func)
	local ButtonTemp = Instance.new("TextButton")
	table.insert(self.ButtonList,ButtonTemp)
	if #self.ButtonList ~= 1 then
		for i,v in pairs(self.ButtonList) do
			v.Size = UDim2.new(1/#self.ButtonList,0,0,26)
		end
	end
	ButtonTemp.Name = name
	ButtonTemp.Parent = self.Buttons
	ButtonTemp.Text = name
	ButtonTemp.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
	ButtonTemp.BorderSizePixel = 0
	ButtonTemp.Size = UDim2.new(1/#self.ButtonList,0,0,26)
	ButtonTemp.Font = Enum.Font.SourceSans
	ButtonTemp.TextColor3 = Color3.fromRGB(255, 255, 255)
	ButtonTemp.TextScaled = true
	ButtonTemp.TextSize = 19.000
	ButtonTemp.TextStrokeTransparency = 0.500
	ButtonTemp.TextWrapped = true
	ButtonTemp.MouseButton1Down:Connect(func)

	return ButtonTemp
end

function tabb:createLabel(text,size)
	local ButtonTemp = Instance.new("TextLabel")
	ButtonTemp.Parent = self.List
	ButtonTemp.Text = text or "Hello world!"
	ButtonTemp.BackgroundTransparency = 1
	ButtonTemp.Font = Enum.Font.SourceSans
	ButtonTemp.TextColor3 = Color3.fromRGB(255, 255, 255)
	ButtonTemp.TextSize = size or 21
	ButtonTemp.TextStrokeTransparency = 0.500
	ButtonTemp.Size = UDim2.new(0, 305, 0, ButtonTemp.TextSize)
	ButtonTemp.RichText = true
	ButtonTemp.TextWrapped = true
	ButtonTemp.AutomaticSize = Enum.AutomaticSize.Y

	return {
		update = function(_,text,size,font)
			ButtonTemp.TextSize = size or ButtonTemp.TextSize
			ButtonTemp.Text = text or ButtonTemp.Text
			ButtonTemp.Font = font or ButtonTemp.Font
		end,getText = function() return ButtonTemp.Text end,
		changecol = function(_,col)
			ButtonTemp.TextColor3 = col or ButtonTemp.TextColor3
		end
	}
end
function tabb:createTextbox(name,func)
	local TextBox = Instance.new("Frame")
	local TextBox_2 = Instance.new("TextBox")
	local Title_4 = Instance.new("TextLabel")

	TextBox.Name = "TextBox"
	TextBox.Parent = self.List
	TextBox.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
	TextBox.BorderSizePixel = 0
	TextBox_2.ClearTextOnFocus = false
	TextBox.Size = UDim2.new(0, 305, 0, 26)

	TextBox_2.Parent = TextBox
	TextBox_2.BackgroundColor3 = Color3.fromRGB(97, 97, 97)
	TextBox_2.BorderSizePixel = 0
	TextBox_2.Position = UDim2.new(0.268303156, 0, 0.15384616, 0)
	TextBox_2.Size = UDim2.new(0, 217, 0, 18)
	TextBox_2.Font = Enum.Font.SourceSans
	TextBox_2.Text = ""
	TextBox_2.TextColor3 = Color3.fromRGB(255,255,255)
	TextBox_2.TextSize = 14.000

	Title_4.Name = "Title"
	Title_4.Parent = TextBox
	Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_4.BackgroundTransparency = 1.000
	Title_4.Position = UDim2.new(0.0103640668, 0, 0.0673288181, 0)
	Title_4.Size = UDim2.new(0, 78, 0, 22)
	Title_4.Font = Enum.Font.SourceSans
	Title_4.Text = name
	Title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_4.TextScaled = true
	Title_4.TextSize = 14.000
	Title_4.TextStrokeTransparency = 0.500
	Title_4.TextWrapped = true
	Title_4.TextXAlignment = Enum.TextXAlignment.Left

	if func then
		TextBox_2.FocusLost:Connect(function()
			func(TextBox_2.Text)
		end)
	end

	return setmetatable({
		TextBox = TextBox_2
	},tb)
end
function tb:getText()
	return self.TextBox.Text
end
function tb:update(txt)
	self.TextBox.Text = txt
end

function tabb:createToggle(name,func,default)
	local Toggle = Instance.new("Frame")
	local ToggleButton = Instance.new("TextButton")
	local UICorner = Instance.new("UICorner")
	local Title_3 = Instance.new("TextLabel")

	Toggle.Name = name
	Toggle.Parent = self.List
	Toggle.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
	Toggle.BorderSizePixel = 0
	Toggle.Position = UDim2.new(0, 0, 0, 2)
	Toggle.Size = UDim2.new(0, 305, 0, 26)

	ToggleButton.Name = "ToggleButton"
	ToggleButton.Parent = Toggle
	ToggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
	ToggleButton.BackgroundColor3 = Color3.new(1,0,0)
	ToggleButton.BorderSizePixel = 0
	ToggleButton.Position = UDim2.new(0.0425358824, 0, 0.513695002, 0)
	ToggleButton.Size = UDim2.new(0, 20, 0, 20)
	ToggleButton.Font = Enum.Font.SourceSans
	ToggleButton.Text = ""
	ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	ToggleButton.TextScaled = true
	ToggleButton.TextSize = 19.000
	ToggleButton.TextStrokeTransparency = 0.500
	ToggleButton.TextWrapped = true

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = ToggleButton

	Title_3.Name = "Title"
	Title_3.Parent = Toggle
	Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_3.BackgroundTransparency = 1.000
	Title_3.Position = UDim2.new(0.106110342, 0, 0.0673285276, 0)
	Title_3.Size = UDim2.new(0, 273, 0, 22)
	Title_3.Font = Enum.Font.SourceSans
	Title_3.Text = name
	Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_3.TextScaled = true
	Title_3.TextSize = 14.000
	Title_3.TextStrokeTransparency = 0.500
	Title_3.TextWrapped = true
	Title_3.TextXAlignment = Enum.TextXAlignment.Left

	local bool = default or false
	if bool == true then
		local tween = game:GetService("TweenService"):Create(
		ToggleButton,
		TweenInfo.new(.3),
		{BackgroundColor3 = Color3.new(0,1,0)}
		)
		tween:Play()
		task.spawn(function()
			tween.Completed:Wait()
			tween:Destroy()
		end)
	end

	if func then
		ToggleButton.MouseButton1Down:Connect(function()
			bool = not bool
			func(bool)
			if  bool then
				local tween = game:GetService("TweenService"):Create(
				ToggleButton,
				TweenInfo.new(.3),
				{BackgroundColor3 = Color3.new(0,1,0)}
				)
				tween:Play()
				task.spawn(function()
					tween.Completed:Wait()
					tween:Destroy()
				end)
			else
				local tween = game:GetService("TweenService"):Create(
				ToggleButton,
				TweenInfo.new(.3),
				{BackgroundColor3 = Color3.new(1,0,0)}
				)
				tween:Play()
				task.spawn(function()
					tween.Completed:Wait()
					tween:Destroy()
				end)
			end
		end)
	else
		ToggleButton.MouseButton1Down:Connect(function()
			bool = not bool
			if  bool then
				local tween = game:GetService("TweenService"):Create(
				ToggleButton,
				TweenInfo.new(.3),
				{BackgroundColor3 = Color3.new(0,1,0)}
				)
				tween:Play()
				task.spawn(function()
					tween.Completed:Wait()
					tween:Destroy()
				end)
			else
				local tween = game:GetService("TweenService"):Create(
				ToggleButton,
				TweenInfo.new(.3),
				{BackgroundColor3 = Color3.new(1,0,0)}
				)
				tween:Play()
				task.spawn(function()
					tween.Completed:Wait()
					tween:Destroy()
				end)
			end
		end)
	end

	return setmetatable({
		GetToggled = function()
			return bool
		end,
		update = function(self,boolean)
			bool = type(boolean) == 'boolean' and boolean or false
			func(bool)
			if bool then
				local tween = game:GetService("TweenService"):Create(
				ToggleButton,
				TweenInfo.new(.3),
				{BackgroundColor3 = Color3.new(0,1,0)}
				)
				tween:Play()
				task.spawn(function()
					tween.Completed:Wait()
					tween:Destroy()
				end)
			else
				local tween = game:GetService("TweenService"):Create(
				ToggleButton,
				TweenInfo.new(.3),
				{BackgroundColor3 = Color3.new(1,0,0)}
				)
				tween:Play()
				task.spawn(function()
					tween.Completed:Wait()
					tween:Destroy()
				end)
			end
		end,
	},toggle)
end
return gui
