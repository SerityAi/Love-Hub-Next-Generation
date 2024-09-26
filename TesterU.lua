do
	local ui = game.CoreGui:FindFirstChild("Love Hub")
	if ui then
		ui:Destroy()
	end
end
local logo = getgenv().Logo 
if logo == nil then logo = 12194477043 end
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
		Tween:Play()
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
				input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

local library = {}

function library:AddWindow(text,logo,theme,keybind)
    local currenttab = ""
    local uihide = false
    local abc = false
    keybind = keybind or Enum.KeyCode.RightControl

    local Ka = Instance.new("ScreenGui")
    Ka.Name = "Love Hub"
    Ka.Parent = game.CoreGui
    Ka.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local ImageButton = Instance.new("ImageButton")
    ImageButton.Parent = Ka
    ImageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ImageButton.Transparency = 1
    ImageButton.BorderSizePixel = 0
    ImageButton.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
    ImageButton.Size = UDim2.new(0, 50, 0, 50)
    ImageButton.Draggable = true
    ImageButton.Image = logo
    ImageButton.MouseButton1Down:connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true,305,false,game)
        game:GetService("VirtualInputManager"):SendKeyEvent(false,305,false,game)
    end)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = ImageButton

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Name = "UIStroke"
    UIStroke.Parent = ImageButton
    UIStroke.ApplyStrokeMode = "Contextual"
    UIStroke.Color = theme
    UIStroke.LineJoinMode = "Round"
    UIStroke.Thickness = 1

    if ImageButton.Transparency == 1.000 then 
        TweenService:Create(
            ImageButton,
            TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
            {Transparency = 0.000}
        ):Play()
    end

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = Ka
    Main.AnchorPoint = Vector2.new(0.5,0.5)
    Main.ClipsDescendants = true
    Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Main.Position = UDim2.new(0.5, 0, 0.499, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)

    Main:TweenSize(UDim2.new(0, 590, 0, 400),"Out","Quad",1,true)

    local MainCorner = Instance.new("UICorner")
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main
    MainCorner.CornerRadius = UDim.new(0, 8)

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Name = "MainStroke"
    MainStroke.Parent = Main
    MainStroke.ApplyStrokeMode = "Contextual"
    MainStroke.Color = theme
    MainStroke.LineJoinMode = "Round"
    MainStroke.Thickness = 1

    local Top = Instance.new("Frame")
    Top.Name = "Top"
    Top.Parent = Main
    Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Top.BackgroundTransparency = 1.000
    Top.Size = UDim2.new(0, 590, 0, 35)
    
    local Top = Instance.new("Frame")
    Top.Name = "Top"
    Top.Parent = Main
    Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Top.BackgroundTransparency = 1.000
    Top.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Top.Position = UDim2.new(0.021956088, 0, 0, 10)
    Top.Size = UDim2.new(0, 590, 0, 39)

    local NameHub = Instance.new("TextLabel")
    NameHub.Name = "NameHub"
    NameHub.Parent = Main
    NameHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NameHub.BackgroundTransparency = 1.000
    NameHub.Position = UDim2.new(0, 45, 0, 10)
    NameHub.Size = UDim2.new(0, 483, 0, 31)
    NameHub.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    NameHub.Text = text
    NameHub.TextColor3 = Color3.fromRGB(255,255,255)
    NameHub.TextSize = 17.000
    NameHub.TextXAlignment = Enum.TextXAlignment.Left

    local Logo = Instance.new('ImageLabel')
    Logo.Name = "Logo"
    Logo.Parent = Main
    Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Logo.BackgroundTransparency = 1.000
    Logo.Position = UDim2.new(0, 10, 0, 10)
    Logo.Rotation = 0
    Logo.Size = UDim2.new(0, 30, 0, 30)
    Logo.Image = logo

    local LogoBig = Instance.new('ImageLabel')
    LogoBig.Name = "Logo"
    LogoBig.Parent = Main
    LogoBig.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LogoBig.BackgroundTransparency = 1.000
    LogoBig.ImageTransparency = 0.300
    LogoBig.Position = UDim2.new(0.291944712, 0, 0.209999993, 0)
    LogoBig.Rotation = 0
    LogoBig.Size = UDim2.new(0, 305, 0, 305)
    LogoBig.Image = logo

    local Tab = Instance.new("Frame")
    Tab.Name = "Tab"
    Tab.Parent = Top
    Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tab.BackgroundTransparency = 1.000
    Tab.Position = UDim2.new(0, 0, 0, 35)
    Tab.Size = UDim2.new(0, 395, 0, 38)

    local TabCorner = Instance.new("UICorner")
    TabCorner.Name = "TabCorner"
    TabCorner.Parent = Tab
    TabCorner.CornerRadius = UDim.new(0, 8)
    
    local ScrollTab = Instance.new("ScrollingFrame")
    ScrollTab.Name = "ScrollTab"
    ScrollTab.Parent = Tab
    ScrollTab.Active = true
    ScrollTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScrollTab.BackgroundTransparency = 1.000
    ScrollTab.BorderSizePixel = 0
    ScrollTab.Size = UDim2.new(0, 560, 0, 38)
    ScrollTab.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollTab.ScrollBarThickness = 1
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = ScrollTab
    UIPadding.PaddingLeft = UDim.new(0, 10)

    local TabList = Instance.new("UIListLayout")
    TabList.Name = "TabList"
    TabList.Parent = ScrollTab
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 9)

    MakeDraggable(Top,Main)

	UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.RightControl then
			if uihide == false then
				uihide = true
				Main:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",1,true)
                TweenService:Create(
                    MainStroke,
                    TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                    {Transparency = 1}
                ):Play()
			else
				uihide = false
				Main:TweenSize(UDim2.new(0, 590, 0, 400),"Out","Quad",1,true)
                TweenService:Create(
                    MainStroke,
                    TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                    {Transparency = 0}
                ):Play()
			end
		end
	end)

    local Page = Instance.new("Frame")
    Page.Name = "Page"
    Page.Parent = Main
    Page.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Page.BackgroundTransparency = 1.000
    Page.Position = UDim2.new(0.0170000009, 0, 0.215000004, 0)
    Page.Size = UDim2.new(0, 570, 0, 305)

    local PageCorner = Instance.new("UICorner")
    PageCorner.Name = "PageCorner"
    PageCorner.Parent = Page

    local PageFolder = Instance.new("Folder")
    PageFolder.Name = "PageFolder"
    PageFolder.Parent = Page

    local UIPageLayout = Instance.new("UIPageLayout")

    UIPageLayout.Parent = PageFolder
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
    UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
    UIPageLayout.Padding = UDim.new(0, 10)
    UIPageLayout.TweenTime = 0.400
    UIPageLayout.GamepadInputEnabled = false
    UIPageLayout.ScrollWheelInputEnabled = false
    UIPageLayout.TouchInputEnabled = false


    local Ui = {}
    function Ui:AddTab(text)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton"
        TabButton.Parent = ScrollTab
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundTransparency = 1.000
        TabButton.Size = UDim2.new(0, 80, 0, 20)
        TabButton.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        TabButton.TextColor3 = Color3.fromRGB(225, 225, 225)
        TabButton.TextSize = 12.000
        TabButton.Text = ""

        local TabName = Instance.new("TextLabel")
        TabName.Name = "TextLabel"
        TabName.Parent = TabButton
        TabName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabName.BackgroundTransparency = 1.000
        TabName.Position = UDim2.new(0, 0, 0, 0)
        TabName.Size = UDim2.new(0, 80, 0, 30)
        TabName.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        TabName.Text = text
        TabName.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabName.TextSize = 12.000

        local MainPage = Instance.new("Frame")
        MainPage.Name = "MainPage"
        MainPage.Parent = PageFolder
        MainPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MainPage.BackgroundTransparency = 1.000
        MainPage.Position = UDim2.new(0.00357977885, 0, 0, 0)
        MainPage.Size = UDim2.new(0, 570, 0, 305)

        TabButton.MouseEnter:Connect(function()
            TweenService:Create(
                TabName,
                TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                {TextColor3 = Color3.fromRGB(225, 0, 0)}
            ):Play()
        end)
        TabButton.MouseLeave:Connect(function()
            TweenService:Create(
                TabName,
                TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                {TextColor3 = Color3.fromRGB(225, 225, 225)}
            ):Play()
        end)

        TabButton.MouseButton1Click:Connect(function()
            for i,v in next, ScrollTab:GetChildren() do
                if v:IsA("TextLabel") then
                    TweenService:Create(
                        v,
                        TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = theme}
                    ):Play()
                end
            end
            for i,v in next, PageFolder:GetChildren() do 
                if v.Name == "MainPage" then
                    currenttab = v.Name
                end
                UIPageLayout:JumpTo(MainPage)
            end
		end)

        

		if abc == false then
            for i,v in next, ScrollTab:GetChildren() do
                if v:IsA("TextButton") then
                    TweenService:Create(
                        v,
                        TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextTransparency = 0}
                    ):Play()
                end
                TweenService:Create(
                    TabButton,
                    TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                    {TextTransparency = 0}
                ):Play()
            end
            UIPageLayout:JumpToIndex(1)
			abc = true
		end

        local uitab = {}
        function uitab:AddPage()
            local MainFramePage = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local ScrollPage = Instance.new("ScrollingFrame")
            local PageList = Instance.new("UIListLayout")
            local UIPadding = Instance.new("UIPadding")
            local UIPadding_2 = Instance.new("UIPadding")
            local UIListLayout_2 = Instance.new("UIListLayout")
        
            MainFramePage.Name = "MainFramePage"
            MainFramePage.Parent = MainPage
            MainFramePage.BackgroundColor3 = Color3.fromRGB(10, 11, 12)
            MainFramePage.BackgroundTransparency = 0.300
            MainFramePage.Size = UDim2.new(0, 274, 0, 295)
        
            UICorner.Parent = MainFramePage
        
            ScrollPage.Name = "ScrollPage"
            ScrollPage.Parent = MainFramePage
            ScrollPage.Active = true
            ScrollPage.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
            ScrollPage.BackgroundTransparency = 0.800
            ScrollPage.BorderSizePixel = 0
            ScrollPage.Size = UDim2.new(0, 274, 0, 295)
            ScrollPage.CanvasSize = UDim2.new(0, 0, 0, 0)
            ScrollPage.ScrollBarThickness = 0
        
            PageList.Name = "PageList"
            PageList.Parent = ScrollPage
            PageList.SortOrder = Enum.SortOrder.LayoutOrder
            PageList.Padding = UDim.new(0, 5)
        
            UIPadding.Parent = MainPage
            UIPadding.PaddingLeft = UDim.new(0, 5)
            UIPadding.PaddingTop = UDim.new(0, 10)
        
            UIListLayout_2.Parent = MainPage
            UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
            UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_2.Padding = UDim.new(0, 13)

            game:GetService("RunService").Stepped:Connect(function()
                pcall(function()
                    ScrollPage.CanvasSize = UDim2.new(0,0,0,PageList.AbsoluteContentSize.Y + 26)
                    ScrollTab.CanvasSize = UDim2.new(0,TabList.AbsoluteContentSize.X + 10,0,0)
                end)
            end)

            local main = {}
            function main:AddSeperator(text)
                local SepText = {}
                local Seperator = Instance.new("Frame")
                local Sep1 = Instance.new("Frame")
                local Sep2 = Instance.new("TextLabel")
                local Sep3 = Instance.new("Frame")
                
                Seperator.Name = "Seperator"
                Seperator.Parent = ScrollPage
                Seperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Seperator.BackgroundTransparency = 1.000
                Seperator.Size = UDim2.new(0, 274, 0, 22)
                
                Sep1.Name = "Sep1"
                Sep1.Parent = Seperator
                Sep1.BackgroundColor3 = Color3.fromRGB(255,255,255)
                Sep1.BorderSizePixel = 0
                Sep1.Position = UDim2.new(0, 0, 0, 10)
                Sep1.Size = UDim2.new(0, 50, 0, 1)
                
                Sep2.Name = "Sep2"
                Sep2.Parent = Seperator
                Sep2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sep2.BackgroundTransparency = 1.000
                Sep2.Position = UDim2.new(0, 87, 0, 0)
                Sep2.Size = UDim2.new(0, 100, 0, 22)
                Sep2.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                Sep2.Text = text
                Sep2.TextColor3 = Color3.fromRGB(255, 255, 255)
                Sep2.TextSize = 12.000
                
                Sep3.Name = "Sep3"
                Sep3.Parent = Seperator
                Sep3.BackgroundColor3 = Color3.fromRGB(255,255,255)
                Sep3.BorderSizePixel = 0
                Sep3.Position = UDim2.new(0, 225, 0, 10)
                Sep3.Size = UDim2.new(0, 50, 0, 1)

                Seperator.MouseEnter:Connect(function()
                    TweenService:Create(
                        Sep1,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = theme}
                    ):Play()
                    TweenService:Create(
                        Sep2,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = theme}
                    ):Play()
                    TweenService:Create(
                        Sep3,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = theme}
                    ):Play()
                end)
                Seperator.MouseLeave:Connect(function()
                    TweenService:Create(
                        Sep1,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(255,255,255)}
                    ):Play()
                    TweenService:Create(
                        Sep2,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(255,255,255)}
                    ):Play()
                    TweenService:Create(
                        Sep3,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(255,255,255)}
                    ):Play()
                end)

                function SepText:RefreshSeperator(l)
                    Sep2.Text = l
                end
                return SepText
            end

            function main:AddLine()
                local Linee = Instance.new("Frame")
                local Line = Instance.new("Frame")
                
                Linee.Name = "Linee"
                Linee.Parent = ScrollPage
                Linee.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Linee.BackgroundTransparency = 1.000
                Linee.Position = UDim2.new(0, 0, 0.119999997, 0)
                Linee.Size = UDim2.new(0, 274, 0, 22)
                
                Line.Name = "Line"
                Line.Parent = Linee
                Line.BackgroundColor3 = Color3.fromRGB(255,255,255)
                Line.BorderSizePixel = 0
                Line.Position = UDim2.new(0, 0, 0, 10)
                Line.Size = UDim2.new(0, 274, 0, 1)
                
                Line.MouseEnter:Connect(function()
                    TweenService:Create(
                        Line,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = theme}
                    ):Play()
                end)
                Line.MouseLeave:Connect(function()
                    TweenService:Create(
                        Line,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(255,255,255)}
                    ):Play()
                end)
            end

            function main:AddButton(text,callback)
                local Button = Instance.new("Frame")
                local ButtonCorner = Instance.new("UICorner")
                local Btn = Instance.new("TextButton")
                local BtnCorner = Instance.new("UICorner")
                
                Button.Name = "Button"
                Button.Parent = ScrollPage
                Button.BackgroundColor3 = theme
                Button.BackgroundTransparency = 1.000
                Button.Size = UDim2.new(0, 274, 0, 39)
                
                ButtonCorner.CornerRadius = UDim.new(0, 8)
                ButtonCorner.Name = "ButtonCorner"
                ButtonCorner.Parent = Button
                
                Btn.Name = "Btn"
                Btn.Parent = Button
                Btn.AutoButtonColor = false
                Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                Btn.Position = UDim2.new(0, 1, 0, 1)
                Btn.Size = UDim2.new(0, 272, 0, 37)
                Btn.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                Btn.TextColor3 = Color3.fromRGB(225, 225, 225)
                Btn.TextSize = 12.000
                Btn.Text = text
                Btn.TextXAlignment = Enum.TextXAlignment.Center
                
                BtnCorner.CornerRadius = UDim.new(0, 8)
                BtnCorner.Name = "BtnCorner"
                BtnCorner.Parent = Btn

                Btn.MouseEnter:Connect(function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0}
                    ):Play()
                    TweenService:Create(
                        Btn,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(225, 0, 0)}
                    ):Play()
                end)

                Btn.MouseLeave:Connect(function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                    ):Play()
                    TweenService:Create(
                        Btn,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(225, 255, 255)}
                    ):Play()
                end)

                Btn.MouseButton1Click:Connect(function()
                    callback()
                    TweenService:Create(
                        Btn,
                        TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {TextSize = 1.000}
                    ):Play()
                    wait()
                    TweenService:Create(
                        Btn,
                        TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {TextSize = 12.000}
                    ):Play()
                end)
            end 

            function main:AddDropdown(text,option,callback)
                local Dropdown = Instance.new("Frame")
                local dropcorner = Instance.new("UICorner")
                local Dropdownn = Instance.new("Frame")
                local droppcorner = Instance.new("UICorner")
                local DropBtn = Instance.new("TextButton")
                local DropLabel = Instance.new("TextLabel")
                local DropScroll = Instance.new("ScrollingFrame")
                local dpd = Instance.new("UIPadding")
                local dll = Instance.new("UIListLayout")
                local DropImage = Instance.new("ImageLabel")
                local isdropping = false

                Dropdown.Name = "Dropdown"
                Dropdown.Parent = ScrollPage
                Dropdown.BackgroundColor3 = theme
                Dropdown.Size = UDim2.new(0, 274, 0, 39) -- 114
                Dropdown.BackgroundTransparency = 1
                
                dropcorner.CornerRadius = UDim.new(0, 8)
                dropcorner.Name = "dropcorner"
                dropcorner.Parent = Dropdown
                
                Dropdownn.Name = "Dropdownn"
                Dropdownn.Parent = Dropdown
                Dropdownn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                Dropdownn.ClipsDescendants = true
                Dropdownn.Position = UDim2.new(0, 1, 0, 1)
                Dropdownn.Size = UDim2.new(0, 272, 0, 37) -- 112
                
                droppcorner.CornerRadius = UDim.new(0, 8)
                droppcorner.Name = "droppcorner"
                droppcorner.Parent = Dropdownn
                
                DropBtn.Name = "DropBtn"
                DropBtn.Parent = Dropdownn
                DropBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                DropBtn.BackgroundTransparency = 1.000255
                DropBtn.Size = UDim2.new(0, 272, 0, 37)
                DropBtn.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                DropBtn.Text = ""
                DropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropBtn.TextSize = 12.000
                
                DropLabel.Name = "DropLabel"
                DropLabel.Parent = Dropdownn
                DropLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropLabel.BackgroundTransparency = 1.000
                DropLabel.Position = UDim2.new(0, 12, 0, 13)
                DropLabel.Size = UDim2.new(0, 100, 0, 12)
                DropLabel.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                DropLabel.Text = text
                DropLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
                DropLabel.TextSize = 12.000
                DropLabel.TextXAlignment = Enum.TextXAlignment.Left

                local UICorner = Instance.new("UICorner")
                DropImage.Name = "DropImage"
                DropImage.Parent = Dropdownn
                DropImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropImage.BackgroundTransparency = 1.000
                DropImage.Position = UDim2.new(0, 232, 0, 10)
                DropImage.Rotation = 0
                DropImage.Size = UDim2.new(0, 20, 0, 20)
                DropImage.Image = "http://www.roblox.com/asset/?id=6282522798"
                DropImage.ImageColor3 = Color3.fromRGB(255, 255, 255)

                UICorner.CornerRadius = UDim.new(0, 8)
                UICorner.Parent = DropImage

                DropScroll.Name = "DropScroll"
                DropScroll.Parent = DropLabel
                DropScroll.Active = true
                DropScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropScroll.BackgroundTransparency = 1.000
                DropScroll.BorderSizePixel = 0
                DropScroll.Position = UDim2.new(0, -12, 0, 29)
                DropScroll.Size = UDim2.new(0, 272, 0, 99) -- 70
                DropScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropScroll.ScrollBarThickness = 3
                
                dpd.Name = "dpd"
                dpd.Parent = DropScroll
                dpd.PaddingLeft = UDim.new(0, 20)
                dpd.PaddingTop = UDim.new(0, 5)
                
                dll.Name = "dll"
                dll.Parent = DropScroll
                dll.SortOrder = Enum.SortOrder.LayoutOrder
                dll.Padding = UDim.new(0, 5)

                for i,v in next, option do
                    local Item = Instance.new("TextButton")
                    Item.Name = "Item"
                    Item.Parent = DropScroll
                    Item.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                    Item.Size = UDim2.new(0, 230, 0, 30)
                    Item.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                    Item.TextColor3 = Color3.fromRGB(225, 225, 225)
                    Item.TextSize = 12.000
                    Item.Text = tostring(v)

                    local Itemcorner = Instance.new("UICorner")
                    Itemcorner.CornerRadius = UDim.new(0, 8)
                    Itemcorner.Name = "Itemcorner"
                    Itemcorner.Parent = Item

                    local ItemStroke = Instance.new("UIStroke")
                    ItemStroke.Name = "ItemStroke"
                    ItemStroke.Parent = Item
                    ItemStroke.ApplyStrokeMode = "Border"
                    ItemStroke.Color = theme
                    ItemStroke.LineJoinMode = "Round"
                    ItemStroke.Thickness = 1
                    ItemStroke.Transparency = 1

                    Dropdown.MouseEnter:Connect(function()
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            DropLabel,
                            TweenInfo.new(0,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(225, 0, 0)}
                        ):Play()
                        TweenService:Create(
                            DropImage,
                            TweenInfo.new(0,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {ImageColor3 = theme}
                        ):Play()
                    end)
                    Dropdown.MouseLeave:Connect(function()
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            DropLabel,
                            TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(225, 255, 255)}
                        ):Play()
                        TweenService:Create(
                            DropImage,
                            TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {ImageColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                    end)

                    Item.MouseEnter:Connect(function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(0.1,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(225, 0, 0)}
                        ):Play()
                        TweenService:Create(
                            ItemStroke,
                            TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {Transparency = 0}
                        ):Play()
                    end)
                    Item.MouseLeave:Connect(function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(0.1,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(225, 255, 255)}
                        ):Play()
                        TweenService:Create(
                            ItemStroke,
                            TweenInfo.new(0.1,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {Transparency = 1}
                        ):Play()
                    end)

                    Item.MouseButton1Click:Connect(function()
                        isdropping = false
                        Dropdown:TweenSize(UDim2.new(0, 274, 0, 39),"Out","Quad",0.3,true)
                        Dropdownn:TweenSize(UDim2.new(0, 272, 0, 37),"Out","Quad",0.3,true)
                        TweenService:Create(
                            DropImage,
                            TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        callback(Item.Text)
                        DropLabel.Text = text.." : "..Item.Text
                        callback(v)
                    end)
                end 

                DropScroll.CanvasSize = UDim2.new(0,0,0,dll.AbsoluteContentSize.Y + 10)
                
                DropBtn.MouseButton1Click:Connect(function()
                    if isdropping == false then
                        isdropping = true
                        Dropdown:TweenSize(UDim2.new(0, 274, 0, 145),"Out","Quad",0.3,true) --114
                        Dropdownn:TweenSize(UDim2.new(0, 272, 0, 143),"Out","Quad",0.3,true)
                        DropBtn:TweenSize(UDim2.new(0, 272, 0, 143),"Out","Quad",0.3,true)
                        TweenService:Create(
                            DropImage,
                            TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Rotation = 180}
                        ):Play()
                    else
                        isdropping = false
                        Dropdown:TweenSize(UDim2.new(0, 274, 0, 39),"Out","Quad",0.3,true)
                        Dropdownn:TweenSize(UDim2.new(0, 272, 0, 37),"Out","Quad",0.3,true)
                        DropBtn:TweenSize(UDim2.new(0, 274, 0, 39),"Out","Quad",0.3,true)
                        TweenService:Create(
                            DropImage,
                            TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                    end
                end)

                local drop = {}

                function drop:Clear()
                    DropLabel.Text = tostring(text).." : "
                    isdropping = false
                    Dropdown:TweenSize(UDim2.new(0, 274, 0, 39),"Out","Quad",0.3,true)
                    Dropdownn:TweenSize(UDim2.new(0, 272, 0, 37),"Out","Quad",0.3,true)
                    TweenService:Create(
                        DropImage,
                        TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Rotation = 0}
                    ):Play()
                    for i, v in next, DropScroll:GetChildren() do
                        if v:IsA("TextButton") then
                            v:Destroy()
                        end
                    end
                end
                function drop:Add(t)
                    local Item = Instance.new("TextButton")
                    Item.Name = "Item"
                    Item.Parent = DropScroll
                    Item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Item.BackgroundTransparency = 1.000
                    Item.Size = UDim2.new(0, 248, 0, 29)
                    Item.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                    Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Item.TextSize = 12.000
                    Item.Text = tostring(t)

                    Item.MouseButton1Click:Connect(function()
                        isdropping = false
                        Dropdown:TweenSize(UDim2.new(0, 274, 0, 39),"Out","Quad",0.3,true)
                        Dropdownn:TweenSize(UDim2.new(0, 272, 0, 37),"Out","Quad",0.3,true)
                        TweenService:Create(
                            DropImage,
                            TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        callback(Item.Text)
                        DropLabel.Text = text.." : "..Item.Text
                        callback(t)
                    end)
                end
                return drop
            end

            function main:AddSlider(text,min,max,set,callback)
                local Slider = Instance.new("Frame")
                local slidercorner = Instance.new("UICorner")
                local sliderr = Instance.new("Frame")
                local sliderrcorner = Instance.new("UICorner")
                local SliderLabel = Instance.new("TextLabel")
                local HAHA = Instance.new("Frame")
                local AHEHE = Instance.new("TextButton")
                local bar = Instance.new("Frame")
                local bar1 = Instance.new("Frame")
                local bar1corner = Instance.new("UICorner")
                local barcorner = Instance.new("UICorner")
                local circlebar = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local slidervalue = Instance.new("Frame")
                local valuecorner = Instance.new("UICorner")
                local TextBox = Instance.new("TextBox")
                local UICorner_2 = Instance.new("UICorner")

                Slider.Name = "Slider"
                Slider.Parent = ScrollPage
                Slider.BackgroundColor3 = theme
                Slider.BackgroundTransparency = 1.000
                Slider.Size = UDim2.new(0, 274, 0, 39)

                slidercorner.CornerRadius = UDim.new(0, 8)
                slidercorner.Name = "slidercorner"
                slidercorner.Parent = Slider

                sliderr.Name = "sliderr"
                sliderr.Parent = Slider
                sliderr.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                sliderr.Position = UDim2.new(0, 1, 0, 1)
                sliderr.Size = UDim2.new(0, 272, 0, 37)

                sliderrcorner.CornerRadius = UDim.new(0, 8)
                sliderrcorner.Name = "sliderrcorner"
                sliderrcorner.Parent = sliderr

                SliderLabel.Name = "SliderLabel"
                SliderLabel.Parent = sliderr
                SliderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderLabel.BackgroundTransparency = 1.000
                SliderLabel.Position = UDim2.new(0, 12, 0, 6)
                SliderLabel.Size = UDim2.new(0, 100, 0, 12)
                SliderLabel.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                SliderLabel.Text = text
                SliderLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
                SliderLabel.TextSize = 12.000
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

                HAHA.Name = "HAHA"
                HAHA.Parent = sliderr
                HAHA.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                HAHA.BackgroundTransparency = 1.000
                HAHA.Size = UDim2.new(0, 272, 0, 37)

                AHEHE.Name = "AHEHE"
                AHEHE.Parent = sliderr
                AHEHE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                AHEHE.BackgroundTransparency = 1.000
                AHEHE.Position = UDim2.new(0, 12, 0, 25)
                AHEHE.Size = UDim2.new(0, 200, 0, 5)
                AHEHE.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                AHEHE.Text = ""
                AHEHE.TextColor3 = Color3.fromRGB(0, 0, 0)
                AHEHE.TextSize = 12.000

                bar.Name = "bar"
                bar.Parent = AHEHE
                bar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                bar.Size = UDim2.new(0, 200, 0, 5)

                bar1.Name = "bar1"
                bar1.Parent = bar
                bar1.BackgroundColor3 = theme
                bar1.Size = UDim2.new(set/max, 0, 0, 5)

                bar1corner.CornerRadius = UDim.new(0, 8)
                bar1corner.Name = "bar1corner"
                bar1corner.Parent = bar1

                barcorner.CornerRadius = UDim.new(0, 8)
                barcorner.Name = "barcorner"
                barcorner.Parent = bar

                circlebar.Name = "circlebar"
                circlebar.Parent = bar1
                circlebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                circlebar.Position = UDim2.new(1, -2, 0, -3)
                circlebar.Size = UDim2.new(0, 10, 0, 10)

                UICorner.CornerRadius = UDim.new(0, 8)
                UICorner.Parent = circlebar

                slidervalue.Name = "slidervalue"
                slidervalue.Parent = sliderr
                slidervalue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                slidervalue.Position = UDim2.new(0, 217, 0, 4)
                slidervalue.Size = UDim2.new(0, 50, 0, 30)

                valuecorner.CornerRadius = UDim.new(0, 8)
                valuecorner.Name = "valuecorner"
                valuecorner.Parent = slidervalue

                TextBox.Parent = slidervalue
                TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                TextBox.Position = UDim2.new(0, 1, 0, 1)
                TextBox.Size = UDim2.new(0, 48, 0, 28)
                TextBox.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.ClipsDescendants = true
                TextBox.TextSize = 12.000
                TextBox.Text = set

                UICorner_2.CornerRadius = UDim.new(0, 8)
                UICorner_2.Parent = TextBox

                HAHA.MouseEnter:Connect(function()
                    TweenService:Create(
                        Slider,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0}
                    ):Play()
                    TweenService:Create(
                        SliderLabel,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = theme}
                    ):Play()
                    TweenService:Create(
                        slidervalue,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = theme}
                    ):Play()
                    TweenService:Create(
                        SliderLabel,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = theme}
                    ):Play()
                    TweenService:Create(
                        circlebar,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(225, 0, 0)}
                    ):Play()
                    TweenService:Create(
                        TextBox,
                        TweenInfo.new(0,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(225, 0, 0)}
                    ):Play()
                end)

                HAHA.MouseLeave:Connect(function()
                    TweenService:Create(
                        Slider,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                    ):Play()
                    TweenService:Create(
                        SliderLabel,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                    TweenService:Create(
                        slidervalue,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                    TweenService:Create(
                        SliderLabel,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                    TweenService:Create(
                        circlebar,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(225, 255, 255)}
                    ):Play()
                    TweenService:Create(
                        TextBox,
                        TweenInfo.new(0.1,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(225, 255, 255)}
                    ):Play()
                end)

                local mouse = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")

                if Value == nil then
                    Value = set
                    pcall(function()
                        callback(Value)
                    end)
                end
                
                AHEHE.MouseButton1Down:Connect(function()
                    Value = math.floor((((tonumber(max) - tonumber(min)) / 200) * bar1.AbsoluteSize.X) + tonumber(min)) or 0
                    pcall(function()
                        callback(Value)
                    end)
                    bar1.Size = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X, 0, 200), 0, 5)
                    circlebar.Position = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X - 2, 0, 190), 0, -3)
                    moveconnection = mouse.Move:Connect(function()
                        TextBox.Text = Value
                        Value = math.floor((((tonumber(max) - tonumber(min)) / 200) * bar1.AbsoluteSize.X) + tonumber(min))
                        pcall(function()
                            callback(Value)
                        end)
                        bar1.Size = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X, 0, 200), 0, 5)
                        circlebar.Position = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X - 2, 0, 190), 0, -3)
                    end)
                    releaseconnection = uis.InputEnded:Connect(function(Mouse)
                        if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                            Value = math.floor((((tonumber(max) - tonumber(min)) / 200) * bar1.AbsoluteSize.X) + tonumber(min))
                            pcall(function()
                                callback(Value)
                            end)
                            bar1.Size = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X, 0, 200), 0, 5)
                            circlebar.Position = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X - 2, 0, 190), 0, -3)
                            moveconnection:Disconnect()
                            releaseconnection:Disconnect()
                        end
                    end)
                end)
                releaseconnection = uis.InputEnded:Connect(function(Mouse)
                    if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                        Value = math.floor((((tonumber(max) - tonumber(min)) / 200) * bar1.AbsoluteSize.X) + tonumber(min))
                        TextBox.Text = Value
                    end
                end)

                TextBox.FocusLost:Connect(function()
                    if tonumber(TextBox.Text) > max then
                        TextBox.Text  = max
                    end
                    bar1.Size = UDim2.new((tonumber(TextBox.Text) or 0) / max, 0, 0, 5)
                    circlebar.Position = UDim2.new(1, -2, 0, -3)
                    TextBox.Text = tostring(tonumber(TextBox.Text) and math.floor( (tonumber(TextBox.Text) / max) * (max - min) + min) )
                    pcall(callback, TextBox.Text)
                end)
            end

            function main:AddTextbox(text,disappear,callback)
                local Textbox = Instance.new("Frame")
                local TextboxCorner = Instance.new("UICorner")
                local Textboxx = Instance.new("Frame")
                local TextboxxCorner = Instance.new("UICorner")
                local TextboxLabel = Instance.new("TextLabel")
                local txtbtn = Instance.new("TextButton")
                local RealTextbox = Instance.new("TextBox")
                local UICorner = Instance.new("UICorner")
                local RealTextStroke = Instance.new("UIStroke")

                Textbox.Name = "Textbox"
                Textbox.Parent = ScrollPage
                Textbox.BackgroundColor3 = theme
                Textbox.BackgroundTransparency = 1
                Textbox.Size = UDim2.new(0, 274, 0, 60)
                Textbox.BackgroundTransparency = 1.000

                TextboxCorner.CornerRadius = UDim.new(0, 8)
                TextboxCorner.Name = "TextboxCorner"
                TextboxCorner.Parent = Textbox

                Textboxx.Name = "Textboxx"
                Textboxx.Parent = Textbox
                Textboxx.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                Textboxx.Position = UDim2.new(0, 1, 0, 1)
                Textboxx.Size = UDim2.new(0, 272, 0, 58)

                TextboxxCorner.CornerRadius = UDim.new(0, 8)
                TextboxxCorner.Name = "TextboxxCorner"
                TextboxxCorner.Parent = Textboxx

                TextboxLabel.Name = "TextboxLabel"
                TextboxLabel.Parent = Textbox
                TextboxLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxLabel.BackgroundTransparency = 1.000
                TextboxLabel.Position = UDim2.new(0, 12, 0, 6)
                TextboxLabel.Text = text
                TextboxLabel.Size = UDim2.new(0, 100, 0, 12)
                TextboxLabel.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                TextboxLabel.TextColor3 = Color3.fromRGB(255,255,255)
                TextboxLabel.TextSize = 12.000
                TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left

                txtbtn.Name = "txtbtn"
                txtbtn.Parent = Textbox
                txtbtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                txtbtn.BackgroundTransparency = 1.000
                txtbtn.Position = UDim2.new(0, 1, 0, 1)
                txtbtn.Size = UDim2.new(0, 272, 0, 58)
                txtbtn.Font = Enum.Font.SourceSans
                txtbtn.Text = ""
                txtbtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                txtbtn.TextSize = 12.000

                RealTextbox.Name = "RealTextbox"
                RealTextbox.Parent = Textbox
                RealTextbox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                RealTextbox.Position = UDim2.new(0, 6, 0, 25)
                RealTextbox.Size = UDim2.new(0, 260, 0, 30)
                RealTextbox.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                RealTextbox.Text = ""
                RealTextbox.TextColor3 = Color3.fromRGB(225, 225, 225)
                RealTextbox.TextSize = 12.000
                RealTextbox.ClipsDescendants = true

                UICorner.CornerRadius = UDim.new(0, 8)
                UICorner.Parent = RealTextbox
                
                RealTextStroke.Name = "RealTextStroke"
                RealTextStroke.Parent = RealTextbox
                RealTextStroke.ApplyStrokeMode = "Border"
                RealTextStroke.Color = Color3.fromRGB(255, 255, 255)
                RealTextStroke.LineJoinMode = "Round"
                RealTextStroke.Thickness = 1

                Textbox.MouseEnter:Connect(function()
                    TweenService:Create(
                        Textbox,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0}
                    ):Play()
                    TweenService:Create(
                        TextboxLabel,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = theme}
                    ):Play()
                    TweenService:Create(
                        RealTextbox,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(225, 0, 0)}
                    ):Play()
                    TweenService:Create(
                        RealTextStroke,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(225, 0, 0)}
                    ):Play()
                end)

                Textbox.MouseLeave:Connect(function()
                    TweenService:Create(
                        Textbox,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                    ):Play()
                    TweenService:Create(
                        TextboxLabel,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                    TweenService:Create(
                        RealTextbox,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                    TweenService:Create(
                        RealTextStroke,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(225, 255, 255)}
                    ):Play()
                end)

                RealTextbox.FocusLost:Connect(function()
                    callback(RealTextbox.Text)
                end)
            end

            function main:AddToggle(text,config,callback)
                local tglb = {}
                local Toggle = Instance.new("Frame")
                local ToggleCorner = Instance.new("UICorner")
                local Togglebtn = Instance.new("TextButton")
                local TogglebtnCorner = Instance.new("UICorner")
                local ToggleLabel = Instance.new("TextLabel")
                local ToggleImage = Instance.new('ImageLabel')
                local UICorner_3 = Instance.new("UICorner")
                local Circle = Instance.new("Frame")
                local UICorner_4 = Instance.new("UICorner")

                Toggle.Name = "Toggle"
                Toggle.Parent = ScrollPage
                Toggle.BackgroundColor3 = theme
                Toggle.BackgroundTransparency = 1.000
                Toggle.Size = UDim2.new(0, 274, 0, 39)

                ToggleCorner.CornerRadius = UDim.new(0, 8)
                ToggleCorner.Name = "ToggleCorner"
                ToggleCorner.Parent = Toggle

                Togglebtn.Name = "Togglebtn"
                Togglebtn.Parent = Toggle
                Togglebtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                Togglebtn.Position = UDim2.new(0, 1, 0, 1)
                Togglebtn.Size = UDim2.new(0, 272, 0, 37)
                Togglebtn.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                Togglebtn.Text = ""
                Togglebtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                Togglebtn.TextSize = 12.000

                TogglebtnCorner.CornerRadius = UDim.new(0, 8)
                TogglebtnCorner.Name = "ToggleCorner"
                TogglebtnCorner.Parent = Togglebtn

                Togglebtn.MouseEnter:Connect(function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0}
                    ):Play()
                end)

                Togglebtn.MouseLeave:Connect(function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                    ):Play()
                end)
                
                ToggleLabel.Name = "ToggleLabel"
                ToggleLabel.Parent = Toggle
                ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabel.BackgroundTransparency = 1.000
                ToggleLabel.Position = UDim2.new(0, 12, 0, 13)
                ToggleLabel.Size = UDim2.new(0, 100, 0, 12)
                ToggleLabel.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                ToggleLabel.Text = text
                ToggleLabel.TextColor3 = Color3.fromRGB(255,255,255)
                ToggleLabel.TextSize = 12.000
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

                ToggleImage.Name = "ToggleImage"
                ToggleImage.Parent = Toggle
                ToggleImage.AnchorPoint = Vector2.new(0.5,0.5)  
                ToggleImage.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                ToggleImage.Image = "http://www.roblox.com/asset/?id=00"
                ToggleImage.Position = UDim2.new(0, 242, 0, 19.5)
                ToggleImage.Size = UDim2.new(0, 25, 0, 25)
                ToggleImage.BorderSizePixel = 1
    
                UICorner_3.CornerRadius = UDim.new(0, 8)
                UICorner_3.Name = "ToggleCorner"
                UICorner_3.Parent = ToggleImage

                Togglebtn.MouseEnter:Connect(function()
                    ToggleImage.Name = "ToggleImage"
                    ToggleImage.Parent = Toggle
                    ToggleImage.AnchorPoint = Vector2.new(0.5,0.5)
                    ToggleImage:TweenSize(UDim2.new(0, 30, 0, 30),"Out","Quad",0.4,true)
                    ToggleImage.BorderSizePixel = 1
                    TweenService:Create(
                        ToggleLabel,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = theme}
                    ):Play()
                end)
                Togglebtn.MouseLeave:Connect(function()
                    ToggleImage.Name = "ToggleImage"
                    ToggleImage.Parent = Toggle
                    ToggleImage.AnchorPoint = Vector2.new(0.5,0.5)
                    ToggleImage:TweenSize(UDim2.new(0, 25, 0, 25),"Out","Quad",0.4,true)
                    ToggleImage.BorderSizePixel = 1
                    if ToggleImage.BackgroundColor3 == Color3.fromRGB(20, 20, 20) then
                        TweenService:Create(
                            ToggleLabel,
                            TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                    else
                        TweenService:Create(
                            ToggleLabel,
                            TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {TextColor3 = theme}
                        ):Play()
                    end
                end)
                if config == true then
                    istoggled = true
                    pcall(callback,istoggled)
                    ToggleImage.Name = "ToggleImage"
                    ToggleImage.Parent = Toggle
                    ToggleImage.AnchorPoint = Vector2.new(0.5,0.5)  
                    ToggleImage.BackgroundColor3 = theme
                    ToggleImage.Image = "http://www.roblox.com/asset/?id=6023426926"
                    ToggleImage:TweenSize(UDim2.new(0, 25, 0, 25),"Out","Quad",0.4,true)
                    ToggleImage.BorderSizePixel = 1
                    TweenService:Create(
                        ToggleLabel,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = theme}
				    ):Play()
                end

                local istoggled = config or false
                Togglebtn.MouseButton1Click:Connect(function()
                    if istoggled == false then
                        istoggled = true
                        ToggleImage.Name = "ToggleImage"
                        ToggleImage.Parent = Toggle
                        ToggleImage.AnchorPoint = Vector2.new(0.5,0.5)  
                        ToggleImage.BackgroundColor3 = theme
                        ToggleImage.Image = "http://www.roblox.com/asset/?id=6023426926"
                        ToggleImage:TweenSize(UDim2.new(0, 25, 0, 25),"Out","Quad",0.4,true)
                        ToggleImage.BorderSizePixel = 1
                        TweenService:Create(
                            ToggleLabel,
                            TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {TextColor3 = theme}
                        ):Play()
                    else
                        istoggled = false
                        ToggleImage.Name = "ToggleImage"
                        ToggleImage.Parent = Toggle
                        ToggleImage.AnchorPoint = Vector2.new(0.5,0.5)  
                        ToggleImage.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                        ToggleImage.Image = "http://www.roblox.com/asset/?id=00"
                        ToggleImage:TweenSize(UDim2.new(0, 30, 0, 30),"Out","Quad",0.4,true)
                        ToggleImage.BorderSizePixel = 1
                        TweenService:Create(
                            ToggleLabel,
                            TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                    end
                    pcall(callback,istoggled)
                end)
                    function tglb:RefeshToggle(e)
                        ToggleLabel.Text = e
                    end
                return tglb
            end

            function main:AddLabel(text)
                local Label = Instance.new("TextLabel")
                local PaddingLabel = Instance.new("UIPadding")
                local labell = {}
        
                Label.Name = "Label"
                Label.Parent = ScrollPage
                Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Label.BackgroundTransparency = 1.000
                Label.Size = UDim2.new(0, 100, 0, 22)
                Label.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                Label.TextColor3 = Color3.fromRGB(225, 225, 225)
                Label.TextSize = 12.000
                Label.Text = text
                Label.TextXAlignment = Enum.TextXAlignment.Left                
    
                PaddingLabel.PaddingLeft = UDim.new(0,5)
                PaddingLabel.Parent = Label
                PaddingLabel.Name = "PaddingLabel"

                Label.MouseEnter:Connect(function()
                    TweenService:Create(
                        Label,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = theme}
                    ):Play()
                end)
                Label.MouseLeave:Connect(function()
                    TweenService:Create(
                        Label,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(255,255,255)}
                    ):Play()
                end)
        
                function labell:Set(newtext)
                    Label.Text = newtext
                end

                function main:AddLabelCenter(text)
					local LabelCenter = Instance.new("TextLabel")
					local PaddingLabelCenter = Instance.new("UIPadding")
					local labelfuncCenter = {}
					
					LabelCenter.Name = "Label"
					LabelCenter.Parent = ScrollPage
					LabelCenter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					LabelCenter.BackgroundTransparency = 1.000
					LabelCenter.Size = UDim2.new(0, 274, 0, 22)
					LabelCenter.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
					LabelCenter.TextColor3 = Color3.fromRGB(225, 225, 225)
					LabelCenter.TextSize = 12.000
					LabelCenter.Text = text
					LabelCenter.TextXAlignment = Enum.TextXAlignment.Center
					
					PaddingLabelCenter.PaddingLeft = UDim.new(0,15)
					PaddingLabelCenter.Parent = Label
					PaddingLabelCenter.Name = "PaddingLabel"
	
					LabelCenter.MouseEnter:Connect(function()
						TweenService:Create(
							LabelCenter,
							TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{TextColor3 = theme}
						):Play()
					end)
					LabelCenter.MouseLeave:Connect(function()
						TweenService:Create(
							LabelCenter,
							TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(255,255,255)}
						):Play()
					end)
					
					function labelfuncCenter:Set(newtext)
						LabelCenter.Text = newtext
					end
					return labelfuncCenter
				end
    
                return labell
            end

            return main
        end
        return uitab
    end
    return Ui
end
