-- Required scripts
local giraffeParts = require("lib.GroupIndex")(models.models.Giraffe)
local squapi       = require("lib.SquAPI")
local ground       = require("lib.GroundCheck")
local pose         = require("scripts.Posing")
--local effects      = require("scripts.SyncedVariables")

-- Animation setup
local anims = animations["models.Giraffe"]

-- Calculate parent's rotations
local function calculateParentRot(m)
	
	local parent = m:getParent()
	if not parent then
		return m:getOffsetRot()
	end
	return calculateParentRot(parent) + m:getOffsetRot()
	
end

-- Tails table
local tailParts = {
	
	giraffeParts.Tail
	
}

-- Squishy tail
local tail = squapi.tail:new(
	tailParts,
	0,    -- Intensity X (0)
	0,    -- Intensity Y (0)
	0,    -- Speed X (0)
	0,    -- Speed Y (0)
	2,    -- Bend (2)
	1,    -- Velocity Push (1)
	0,    -- Initial Offset (0)
	0,    -- Seg Offset (0)
	0.01, -- Stiffness (0.01)
	0.9,  -- Bounce (0.9)
	60,   -- Fly Offset (60)
	-90,  -- Down Limit (-15)
	25    -- Up Limit (25)
)

-- Squishy crouch
squapi.crouch(anims.crouch)

function events.TICK()
	
	
	
end

function events.RENDER(delta, context)
	
	-- Set upperbody to offset rot and crouching pivot point
	giraffeParts.UpperBody
		:offsetPivot(anims.crouch:isPlaying() and -giraffeParts.UpperBody:getAnimPos() or 0)
	
	-- Offset smooth torso in various parts
	-- Note: acts strangely with `giraffeParts.body`
	for _, group in ipairs(giraffeParts.UpperBody:getChildren()) do
		if group ~= giraffeParts.Body then
			group:rot(-calculateParentRot(group:getParent()))
		end
	end
	
end