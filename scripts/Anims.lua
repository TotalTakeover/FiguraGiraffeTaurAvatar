-- Required scripts
require("lib.GSAnimBlend")
require("lib.Molang")
local parts  = require("lib.PartsAPI")
local ground = require("lib.GroundCheck")
local pose   = require("scripts.Posing")

-- Animations setup
local anims = animations.Giraffe

-- Variables
local canAct  = false
local canSit  = false

-- Parrot pivots
local parrots = {
	
	parts.group.LeftParrotPivot,
	parts.group.RightParrotPivot
	
}

-- Calculate parent's rotations
local function calculateParentRot(m)
	
	local parent = m:getParent()
	if not parent then
		return m:getTrueRot()
	end
	return calculateParentRot(parent) + m:getTrueRot()
	
end

function events.TICK()
	
	-- Variables
	local vel       = player:getVelocity()
	local sprinting = player:isSprinting()
	
	-- Animation states
	local isAct = anims.sit:isPlaying()
	
	-- Animation actions
	canAct = pose.stand and not(vel:length() ~= 0 or player:getVehicle())
	canSit = canAct and (not isAct or anims.sit:isPlaying())
	
	-- Stop Sit animation
	if not canSit then
		anims.sit:stop()
	end
	
end

function events.RENDER(delta, context)
	
	-- Parrot rot offset
	for _, parrot in pairs(parrots) do
		parrot:rot(-calculateParentRot(parrot:getParent()) - vanilla_model.BODY:getOriginRot())
	end
	
end

-- GS Blending Setup
local blendAnims = {
	{ anim = anims.sit,    ticks = {14,7}  },
	{ anim = anims.crouch, ticks = {20,20} }
}

-- Apply GS Blending
for _, blend in ipairs(blendAnims) do
	blend.anim:blendTime(table.unpack(blend.ticks)):onBlend("easeOutQuad")
end

-- Play sit anim
function pings.setAnimToggleSit(boolean)
	
	anims.sit:playing(canSit and boolean)
	
end

-- Host only instructions
if not host:isHost() then return end

-- Required scripts
local itemCheck = require("lib.ItemCheck")
local s, color = pcall(require, "scripts.ColorProperties")
if not s then color = {} end

-- Sit keybind
local sitBind   = config:load("AnimSitKeybind") or "key.keyboard.keypad.1"
local setSitKey = keybinds:newKeybind("Sit Animation"):onPress(function() pings.setAnimToggleSit(not anims.sit:isPlaying()) end):key(sitBind)

-- Keybind updaters
function events.TICK()
	
	local sitKey = setSitKey:getKey()
	if sitKey ~= sitBind then
		sitBind = sitKey
		config:save("AnimSitKeybind", sitKey)
	end
	
end

-- Table setup
local t = {}

-- Action
t.sitAct = action_wheel:newAction()
	:item(itemCheck("scaffolding"))
	:toggleItem(itemCheck("saddle"))
	:onToggle(pings.setAnimToggleSit)

-- Update action
function events.RENDER(delta, context)
	
	if action_wheel:isEnabled() then
		t.sitAct
			:title(toJson
				{text = "Play Sit animation", bold = true, color = color.primary}
			)
			:toggled(anims.sit:isPlaying())
		
		for _, page in pairs(t) do
			page:hoverColor(color.hover):toggleColor(color.active)
		end
		
	end
	
end

-- Returns action
return t