-- Required scripts
require("lib.GSAnimBlend")
require("lib.Molang")
local parts  = require("lib.PartsAPI")
local ground = require("lib.GroundCheck")
local pose   = require("scripts.Posing")

-- Animations setup
local anims = animations.Giraffe

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
	
	
	
end

function events.RENDER(delta, context)
	
	-- Parrot rot offset
	for _, parrot in pairs(parrots) do
		parrot:rot(-calculateParentRot(parrot:getParent()) - vanilla_model.BODY:getOriginRot())
	end
	
end

-- GS Blending Setup
local blendAnims = {
	{ anim = anims.crouch, ticks = {20,20} }
}

-- Apply GS Blending
for _, blend in ipairs(blendAnims) do
	blend.anim:blendTime(table.unpack(blend.ticks)):onBlend("easeOutQuad")
end