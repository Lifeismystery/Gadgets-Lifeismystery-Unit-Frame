local toc, data = ...
local AddonId = toc.identifier

-- Frame Configuration Options --------------------------------------------------
local LifeismysteryRaidFrame = WT.UnitFrame:Template("LifeismysteryRaidFrame")
LifeismysteryRaidFrame.Configuration.Name = "Lifeismystery Raid Frame"
LifeismysteryRaidFrame.Configuration.RaidSuitable = true
LifeismysteryRaidFrame.Configuration.FrameType = "Frame"
LifeismysteryRaidFrame.Configuration.Width = 50
LifeismysteryRaidFrame.Configuration.Height = 20
LifeismysteryRaidFrame.Configuration.Resizable = { 55, 40, 500, 70 }
LifeismysteryRaidFrame.Configuration.SupportsHoTPanel = true
LifeismysteryRaidFrame.Configuration.SupportsDebuffPanel = true

--------------------------------------------------------------
function LifeismysteryRaidFrame:Construct(options)
	local template =
	{
		elements = 
		{
			{
				-- Generic Element Configuration
				id="frameBackdrop", type="Frame", parent="frame", layer=1, --alpha=1,
				attach = 
				{ 
					{ point="TOPLEFT", element="frame", targetPoint="TOPLEFT", offsetX=1, offsetY=-1, },
					{ point="BOTTOMRIGHT", element="frame", targetPoint="BOTTOMRIGHT", offsetX=-1, offsetY=1, } 
				},            				
				visibilityBinding="id", 
				color={r=0,g=0,b=0,a=0},
				FrameAlpha = 1,
				FrameAlphaBinding="FrameAlpha",
				BorderColorBinding="BorderColor", border=true, BorderColor = {r=0,g=0,b=0,a=1},
			}, 
			{
				-- Generic Element Configuration
				id="barHealth", type="BarHealth", parent="frameBackdrop", layer=10,
				attach = {
					{ point="TOPLEFT", element="frame", targetPoint="TOPLEFT", offsetX=2, offsetY=2 },
					{ point="BOTTOMRIGHT", element="frame", targetPoint="BOTTOMRIGHT", offsetX=-2, offsetY=-2 },
				},
				growthDirection="left",
				binding="healthPercent",
				backgroundColor={r=0.07, g=0.07, b=0.07, a=0.9},
                backgroundColorBinding="backgroundColor",				
				raidHealthColor2={r=0.5,g=0,b=0, a=0.8},
				colorBinding="raidHealthColor2",				
			--	border=true, BorderColorBinding="BorderColor2", BorderColor2 = {r=0,g=0,b=0,a=1},
			},
			{
				id="healthCap", type="HealthCap", parent="barHealth", layer=15,
				attach = {
					{ point="TOPLEFT", element="barHealth", targetPoint="TOPLEFT" },
					{ point="BOTTOMRIGHT", element="barHealth", targetPoint="BOTTOMRIGHT" },
				},
				growthDirection="left",
				visibilityBinding="healthCap",
				binding="healthCapPercent",
				color={r=0.5, g=0, b=0, a=0.8},
				media="wtGlaze",
				},			
				{
				-- Generic Element Configuration
				id="border", type="BarHealth", parent="frameBackdrop", layer=10, alpha=1,
				attach = {
					{ point="TOPLEFT", element="frame", targetPoint="TOPLEFT", offsetX=2, offsetY=2 },
					{ point="BOTTOMRIGHT", element="frame", targetPoint="BOTTOMRIGHT", offsetX=-2, offsetY=-2 },
				},
				binding="width",
				backgroundColor={r=0, g=0, b=0, a=0},				
				Color={r=0,g=0,b=0, a=0},
				border=true, BorderColorBinding="BorderColor2", BorderColor2 = {r=0,g=0,b=0,a=1},
			},				
		--[[	{
				-- Generic Element Configuration
				id="barResource", type="Bar", parent="frameBackdrop", layer=11,
				attach = {
					{ point="BOTTOMLEFT", element="frame", targetPoint="BOTTOMLEFT", offsetX=2, offsetY=-2 },
					{ point="TOPRIGHT", element="frame", targetPoint="BOTTOMRIGHT", offsetX=-2, offsetY=-4 },
				},
				-- visibilityBinding="id",
				-- Type Specific Element Configuration
				binding="resourcePercent", height=raidFrameBottomBarHeight, --colorBinding="resourceColor",
			--	media="wtGlaze", 
				backgroundColor={r=0, g=0, b=0, a=0}
			},]]
			{
				id="barAbsorb", type="Bar", parent="frameBackdrop", layer=12,
				attach = {
					{ point="BOTTOMLEFT", element="frame", targetPoint="BOTTOMLEFT", offsetX=2, offsetY=-2 },
					{ point="TOPRIGHT", element="frame", targetPoint="BOTTOMRIGHT", offsetX=-2, offsetY=-4 },
				},
				media="wtGlaze", 
				growthDirection="right",
				binding="absorbPercent", color={r=0,g=1,b=1,a=0.7},
				backgroundColor={r=0, g=0, b=0, a=0},
			},
			{
				id="imgRole", type="MediaSet", parent="frameBackdrop", layer=20,
				attach = {{ point="CENTER", element="frame", targetPoint="TOPLEFT", offsetX=4, offsetY=4 }}, 
				visibilityBinding="role",
				nameBinding="role", 
				names = { ["tank"] = "octanusTank", ["heal"] = "octanusHeal", ["dps"] = "octanusDPS", ["support"] = "octanusSupport" },
			},		
			{
				-- Generic Element Configuration
				id="labelName", type="Label", parent="frameBackdrop", layer=20,
				attach = {{ point="CENTER", element="frame", targetPoint="CENTER", offsetX=0, offsetY=3 }},
				visibilityBinding="name",
				text="{nameShort}", maxLength=10, default="", outline=true,
				colorBinding="callingColor",
			},
			{
				-- Generic Element Configuration
				id="labelStatus", type="Label", parent="frameBackdrop", layer=20,
				attach = {{ point="BOTTOMCENTER", element="frame", targetPoint="BOTTOMCENTER", offsetX=0, offsetY=-4 }},
				visibilityBinding="raidStatus2",
				text=" {raidStatus2}", default="", fontSize=11, outline = true,
			},
			{
			    id="imgMark", type="MediaSet", parent="frameBackdrop", layer=30,
			    attach = {{ point="CENTER", element="frame", targetPoint="CENTER", offsetX=-0, offsetY=-10 }},
			    width = 12, height = 12,
			    nameBinding="mark",
			    names = 
			    {
			        ["1"] = "riftMark01_mini",
			        ["2"] = "riftMark02_mini",
			        ["3"] = "riftMark03_mini",
			        ["4"] = "riftMark04_mini",
			        ["5"] = "riftMark05_mini",
			        ["6"] = "riftMark06_mini",
			        ["7"] = "riftMark07_mini",
			        ["8"] = "riftMark08_mini",
			        ["9"] = "riftMark09_mini",
			        ["10"] = "riftMark10_mini",
			        ["11"] = "riftMark11_mini",
			        ["12"] = "riftMark12_mini",
			        ["13"] = "riftMark13_mini",
			        ["14"] = "riftMark14_mini",
			        ["15"] = "riftMark15_mini",
			        ["16"] = "riftMark16_mini",
			        ["17"] = "riftMark17_mini",
			    },
			    visibilityBinding="mark",alpha=1.0,
			},
			{
				-- Generic Element Configuration
				id="imgReady", type="ImageSet", parent="frameBackdrop", layer=30,
				attach = {{ point="CENTER", element="frame", targetPoint="CENTER" }}, -- visibilityBinding="id",
				-- Type Specific Element Configuration
				texAddon=AddonId, texFile="img/wtReady.png", nameBinding="readyStatus", cols=1, rows=2, 
				names = { ["ready"] = 0, ["notready"] = 1 }, defaultIndex = "hide"
			},
			{
				-- Generic Element Configuration
				id="buffPanelDebuffs", type="BuffPanel", semantic="DebuffPanel", parent="frameBackdrop", layer=30,
				attach = {{ point="BOTTOMRIGHT", element="frameBackdrop", targetPoint="BOTTOMRIGHT", offsetX=-1, offsetY=-1 }},
				--visibilityBinding="id",
				-- Type Specific Element Configuration
				rows=1, cols=6, iconSize=16, iconSpacing=1, borderThickness=1,
				auraType="debuff", 
				growthDirection = "left_up",
				--timer = true, timerSize = 14, outline=true, 
				color={r=1,g=1,b=0,a=1},
				stack = true, stackSize = 15, outline=true,
			},
			{
				id="buffPanelHoTs", type="BuffPanel", semantic="HoTPanel", parent="frameBackdrop", layer=30,
				attach = {{ point="TOPRIGHT", element="frameBackdrop", targetPoint="TOPRIGHT", offsetX=-1, offsetY=1 }},
				rows=1, cols=6, iconSize=16, iconSpacing=0, borderThickness=1,
				auraType="hot",selfCast=true, 
				timer = true, timerSize = 11, outline=true, color={r=1,g=1,b=0,a=1}, 
				stack = true, stackSize = 12, outline=true,
				growthDirection = "left_up",
			},
			
		}
	}
	
	for idx,element in ipairs(template.elements) do
		if not options.showAbsorb and element.id == "barAbsorb" then 
			-- showElement = false
		elseif element.semantic == "HoTTracker" and not options.showHoTTrackers 
		then
			showElement = false	
		elseif element.semantic == "HoTPanel" and not options.showHoTPanel then
			-- showElement = false	
		elseif element.semantic == "DebuffPanel" and not options.showDebuffPanel then
			-- showElement = false		
		else 
			self:CreateElement(element)
		end
	end

	self:EventAttach(
		Event.UI.Layout.Size,
		function(el)
			local newWidth = self:GetWidth()
			local newHeight = self:GetHeight()
			local fracWidth = newWidth / LifeismysteryRaidFrame.Configuration.Width
			local fracHeight = newHeight / LifeismysteryRaidFrame.Configuration.Height
			local fracMin = math.min(fracWidth, fracHeight)
			local fracMax = math.max(fracWidth, fracHeight)
			local labName = self.Elements.labelName
			labName:SetFontSize(14)
		end,
		"LayoutSize")
	
	self:SetSecureMode("restricted")
	self:SetMouseoverUnit(self.UnitSpec)
	self:SetMouseMasking("limited")	
	if options.clickToTarget then 
		self:EventMacroSet(Event.UI.Input.Mouse.Left.Click, "target @" .. self.UnitSpec)
	end
	if options.contextMenu then
		self.Event.RightClick = function() if self.UnitId then Command.Unit.Menu(self.UnitId) end end
	end 
	
 end  

WT.Unit.CreateVirtualProperty("FrameAlpha", { "id", "blockedOrOutOfRange"},
	function(unit)
		if unit.blockedOrOutOfRange then
			return {alpha=0.4}	
		else	
			return {alpha=1}
		end
	end)
	
WT.Unit.CreateVirtualProperty("BorderColor", { "playerTarget"},
	function(unit)
		if unit.playerTarget then
			return  { r=1, g=1, b=1, a=1 }
		else
			return { r=0, g=0, b=0, a=0 }
		end
	end)
	
	
WT.Unit.CreateVirtualProperty("raidHealthColor2", { "id"},
	function(unit)
		if unit.id then
			return { r=0.5, g=0, b=0, a=0.8 }
		else	
			return {r=0,g=0,b=0, a=0}
		end
	end)

WT.Unit.CreateVirtualProperty("backgroundColor", { "id", "cleansable"},
	function(unit)
		if unit.cleansable then
			return { r=0.2, g=0.15, b=0.4, a=0.8 }
		else
			return {r=0.07,g=0.07,b=0.07, a=0.85}
		end
	end)	
	
WT.Unit.CreateVirtualProperty("BorderColor2", { "id", "aggro"},
	function(unit)
		if not unit.id then
			return { r = 0, g=0, b = 0, a=0 }
		elseif unit.aggro  then
			return { r=1, g=0, b =0, a=1 }
		elseif not unit.aggro and unit.id then
			return { r = 0, g=0, b = 0, a=1 }
		end
	end)
	
WT.Unit.CreateVirtualProperty("raidStatus2", { "offline", "afk", "health" },
	function(unit)
		if unit.offline then
			return "offline"
		elseif unit.afk then
			return "afk"
		elseif unit.health and unit.health == 0 then
			return "dead"
		else
			return ""
		end
	end)
	
	