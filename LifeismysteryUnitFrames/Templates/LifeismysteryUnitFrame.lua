local toc, data = ...
local AddonId = toc.identifier

local LifeismysteryUnitFrameMargin = 2
-- Frame Configuration Options --------------------------------------------------
local LifeismysteryUnitFrame = WT.UnitFrame:Template("LifeismysteryUnitFrame")
LifeismysteryUnitFrame.Configuration.Name = "Lifeismystery Unit Frame"
LifeismysteryUnitFrame.Configuration.UnitSuitable = true
LifeismysteryUnitFrame.Configuration.FrameType = "Frame"
LifeismysteryUnitFrame.Configuration.Width = 250
LifeismysteryUnitFrame.Configuration.Height = 40
LifeismysteryUnitFrame.Configuration.Resizable = { 10, 10, 500, 100 }

--------------------------------------------------------------
function LifeismysteryUnitFrame:Construct(options)
	local template =
	{
		elements = 
		{
			{
				-- Generic Element Configuration
				id="frameBackdrop", type="Frame", parent="frame", layer=1, alpha=1,
				attach = 
				{ 
					{ point="TOPLEFT", element="frame", targetPoint="TOPLEFT", offsetX=0, offsetY=0, },
					{ point="BOTTOMRIGHT", element="frame", targetPoint="BOTTOMRIGHT", offsetX=0, offsetY=0, } 
				},            				
				visibilityBinding="id",
				FrameAlphaUnit = 1,
				FrameAlphaBinding="FrameAlphaUnit",				
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
				border=true, BorderColorBinding="BorderColorUnit", BorderColorUnit = {r=0,g=0,b=0,a=1},
			},	
			{
				-- Generic Element Configuration
				id="border2", type="BarHealth", parent="frameBackdrop", layer=10, alpha=1,
				attach = {
					{ point="BOTTOMLEFT", element="border", targetPoint="BOTTOMLEFT", offsetX=0, offsetY=0 },
					{ point="BOTTOMRIGHT", element="frame", targetPoint="BOTTOMRIGHT", offsetX=-2, offsetY=15},
				},
				binding="width",
				backgroundColor={r=0, g=0, b=0, a=1},				
				Color={r=0,g=0,b=0, a=1},
				border=true, BorderColorBinding="BorderColorUnit", BorderColorUnit = {r=0,g=0,b=0,a=1},
				height=23,
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
			--	media="wtGlaze", 
				backgroundColorUnit={r=0.07, g=0.07, b=0.07, a=0.9},
                backgroundColorBinding="backgroundColorUnit",							
				UnitHealthColor2={r=0.5,g=0,b=0, a=0.8},
				colorBinding="UnitHealthColor2", 
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
				id="barResource", type="Bar", parent="frameBackdrop", layer=11, alpha=1,
				attach = {
					{ point="BOTTOMLEFT", element="frame", targetPoint="BOTTOMLEFT", offsetX=2, offsetY=-2 },
					{ point="TOPRIGHT", element="frame", targetPoint="BOTTOMRIGHT", offsetX=-2, offsetY=-8 },
				},
				-- visibilityBinding="id",
				-- Type Specific Element Configuration
				binding="resourcePercent", height=5, colorBinding="resourceColor",
				media="wtGlaze", 
				backgroundColor={r=0.1, g=0.1, b=0.1, a=0.9},
			},
			{
				id="barAbsorb", type="Bar", parent="frameBackdrop", layer=11,
				attach = {
					{ point="BOTTOMLEFT", element="frame", targetPoint="BOTTOMLEFT", offsetX=2, offsetY=-10},
					{ point="TOPRIGHT", element="barResource", targetPoint="BOTTOMRIGHT", offsetX=-2, offsetY=-12 },
				},
				media="wtGlaze", 
				growthDirection="right",
				binding="absorbPercent", color={r=0,g=1,b=1,a=0.7},
				backgroundColor={r=0, g=0, b=0, a=0},
			},
			{
				id="labelhealth", type="Label", parent="frame", layer=20,
				attach = {{ point="BOTTOMLEFT", element="border2", targetPoint="BOTTOMLEFT", offsetX=-3, offsetY=2  }},
				visibilityBinding="health",
				text=" {health} | {healthPercent}%", default="", fontSize=12, outline=true,
			},						
			{
				id="labelresource", type="Label", parent="frame", layer=20, alpha=0.8,
				attach = {{ point="BOTTOMRIGHT", element="border2", targetPoint="BOTTOMRIGHT", offsetX=-3, offsetY=2  }},
				visibilityBinding="resource",
				text=" {resource}", default="", fontSize=12, outline=true,
			},
			{
				id="imgRole", type="MediaSet", parent="frameBackdrop", layer=20,
				attach = {{ point="CENTER", element="frame", targetPoint="TOPLEFT", offsetX=2, offsetY=2 }}, 
				visibilityBinding="role",
				nameBinding="role", 
				names = { ["tank"] = "octanusTank", ["heal"] = "octanusHeal", ["dps"] = "octanusDPS", ["support"] = "octanusSupport" },
			},		
			{
				-- Generic Element Configuration
				id="labelName", type="Label", parent="frame", layer=20,
				attach = {{ point="TOPLEFT", element="border", targetPoint="TOPLEFT", offsetX=4, offsetY=-14 }},
				visibilityBinding="name",
				text="{level} {name}", default="", outline=true, fontSize=14,
				colorBinding="callingColor",
			},
			{
				-- Generic Element Configuration
				id="labelStatus", type="Label", parent="frameBackdrop", layer=20,
				attach = {{ point="BOTTOMCENTER", element="frame", targetPoint="BOTTOMCENTER", offsetX=0, offsetY=-4 }},
				visibilityBinding="UnitStatus2",
				text=" {UnitStatus2}", default="", fontSize=11, outline = true,
			},
			{
			    id="imgMark", type="MediaSet", parent="frameBackdrop", layer=30,
			    attach = {{ point="TOPRIGHT", element="frame", targetPoint="TOPRIGHT", offsetX=-3, offsetY=4 }},
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
			--[[{
				-- Generic Element Configuration
				id="buffPanelDebuffs", type="BuffPanel", parent="frameBackdrop", layer=30,
				attach = {{ point="TOPRIGHT", element="frameBackdrop", targetPoint="TOPRIGHT", offsetX=-1, offsetY=-37 }},
				--visibilityBinding="id",
				-- Type Specific Element Configuration
				rows=1, cols=6, iconSize=30, iconSpacing=1, borderThickness=1,
				auraType="debuff", 
				growthDirection = "left_up",
				timer = true, timerSize = 14, outline=true, 
				color={r=1,g=1,b=0,a=1},
				stack = true, stackSize = 15, outline=true,
			},
			{
				id="buffPanelHoTs", type="BuffPanel", parent="frameBackdrop", layer=30, --semantic="HoTPanel"
				attach = {{ point="BOTTOMLEFT", element="frameBackdrop", targetPoint="BOTTOMLEFT", offsetX=1, offsetY=25 }},
				rows=4, cols=7, iconSize=0, iconSpacing=0, borderThickness=1,
				auraType="buff",selfCast=false, 
				timer = true, timerSize = 11, outline=true, color={r=1,g=1,b=0,a=1}, 
				stack = true, stackSize = 12, outline=true,
				growthDirection = "right_down",
			},]]
			{
			id="imgInCombat", type="Image", parent="frame", layer=55,
			attach = {{ point="CENTER", element="frameBackdrop", targetPoint="TOPLEFT", offsetX=0, offsetY=20 }}, visibilityBinding="combat",
			texAddon=AddonId, 
			texFile="img/InCombat32.png",
			width=15, height=15,
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
		else 
			self:CreateElement(element)
		end
	end

	self:EventAttach(
		Event.UI.Layout.Size,
		function(el)
			local newWidth = self:GetWidth()
			local newHeight = self:GetHeight()
			local fracWidth = newWidth / LifeismysteryUnitFrame.Configuration.Width
			local fracHeight = newHeight / LifeismysteryUnitFrame.Configuration.Height
			local fracMin = math.min(fracWidth, fracHeight)
			local fracMax = math.max(fracWidth, fracHeight)
			local labName = self.Elements.labelName
			labName:SetFontSize(16)
		end,
		"LayoutSize")
	
	self:SetSecureMode("restricted")
	self:SetMouseoverUnit(self.UnitSpec)
	
	if options.clickToTarget then
		self.Event.LeftClick = "target @" .. self.UnitSpec
	end
	
	if options.contextMenu then 
		self.Event.RightClick = 
			function() 
				if self.UnitId then 
					Command.Unit.Menu(self.UnitId) 
				end 
			end 
	end
	
 end  

WT.Unit.CreateVirtualProperty("FrameAlphaUnit", { "id", "blockedOrOutOfRange"},
	function(unit)
		if unit.blockedOrOutOfRange then
			return {alpha=0.4}	
		else	
			return {alpha=1}
		end
	end) 

WT.Unit.CreateVirtualProperty("UnitHealthColor2", { "id"},
	function(unit)
		if unit.id then
			return { r=0.5, g=0, b=0, a=0.8 }
		else
			return {r=0,g=0,b=0, a=0}
		end
	end)

WT.Unit.CreateVirtualProperty("backgroundColorUnit", { "id", "cleansable"},
	function(unit)
		if unit.cleansable then
			return { r=0.2, g=0.15, b=0.4, a=0.8 }
		else
			return {r=0.07,g=0.07,b=0.07, a=0.8}
		end
	end)	
	
WT.Unit.CreateVirtualProperty("BorderColorUnit", { "id", "aggro" },
	function(unit)
		if not unit.id then
			return { r = 0, g=0, b = 0, a=0 }
		elseif unit.aggro  then
			return { r=1, g=0, b =0, a=1 }
		elseif not unit.aggro and unit.id then
			return { r = 0, g=0, b = 0, a=1 }
		end
	end)
	
WT.Unit.CreateVirtualProperty("UnitStatus2", { "offline", "afk", "health" },
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
