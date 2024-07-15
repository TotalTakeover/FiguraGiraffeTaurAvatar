-- Required scripts
local giraffeParts = require("lib.GroupIndex")(models.models.Giraffe)
local squapi       = require("lib.SquAPI")
local ground       = require("lib.GroundCheck")
local pose         = require("scripts.Posing")
local effects      = require("scripts.SyncedVariables")

-- Animation setup
local anims = animations["models.Giraffe"]

-- Calculate parent's rotations
local function calculateParentRot(m)
	
	local parent = m:getParent()
	if not parent then
		return m:getTrueRot()
	end
	return calculateParentRot(parent) + m:getTrueRot()
	
end

-- Lerp leg table
local legLerp = {
	current    = 0,
	nextTick   = 0,
	target     = 0,
	currentPos = 0
}

-- Set lerp starts on init
function events.ENTITY_INIT()
	
	local apply = ground() and 1 or 0
	for k, v in pairs(legLerp) do
		legLerp[k] = apply
	end
	
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

local headParts = {
	
	giraffeParts.UpperBody,
	giraffeParts.Neck3,
	giraffeParts.Neck2,
	giraffeParts.Neck1,
	
}

-- Squishy smooth torso
local head = squapi.smoothHead:new(
	headParts,
	1,    -- Strength (1)
	0.2,  -- Tilt (0.2)
	1,    -- Speed (1)
	false -- Keep Original Head Pos (false)
)

-- Head variable
local headStrength = head.strength[1]

-- Squishy vanilla legs
local frontLeftLeg = squapi.leg:new(
	giraffeParts.FrontLeftLeg,
	0.25,  -- Strength (0.25)
	false, -- Right Leg (false)
	false  -- Keep Position (false)
)

local frontRightLeg = squapi.leg:new(
	giraffeParts.FrontRightLeg,
	0.25, -- Strength (0.25)
	true, -- Right Leg (true)
	false -- Keep Position (false)
)

local backLeftLeg = squapi.leg:new(
	giraffeParts.BackLeftLeg,
	0.25, -- Strength (0.25)
	true, -- Right Leg (true)
	false -- Keep Position (false)
)

local backRightLeg = squapi.leg:new(
	giraffeParts.BackRightLeg,
	0.25,  -- Strength (0.25)
	false, -- Right Leg (false)
	false  -- Keep Position (false)
)

-- Leg strength variables
local frontLeftLegStrength  = frontLeftLeg.strength
local frontRightLegStrength = frontRightLeg.strength
local backLeftLegStrength   = backLeftLeg.strength
local backRightLegStrength  = backRightLeg.strength

-- Squishy taur
local taur = squapi.taur:new(
	giraffeParts.LowerBody,
	giraffeParts.FrontLegs,
	giraffeParts.BackLegs
)

-- Squishy crouch
squapi.crouch(anims.crouch)

function events.TICK()
	
	-- Variables
	local onGround = ground()
	local inWater  = player:isInWater()
	
	-- Adjust head strength
	for i in ipairs(head.strength) do
		head.strength[i] = headStrength / (pose.crouch and 2 or 1)
	end
	
	-- Control targets based on variables
	legLerp.target = (onGround or inWater or pose.elytra or effects.cF) and 1 or 0
	taur.target    = (onGround or effects.cF) and 0 or taur.target
	
	-- Tick lerp
	legLerp.current  = legLerp.nextTick
	legLerp.nextTick = math.lerp(legLerp.nextTick, legLerp.target, 0.5)
	
end

function events.RENDER(delta, context)
	
	-- Render lerp
	legLerp.currentPos = math.lerp(legLerp.current, legLerp.nextTick, delta)
	
	-- Adjust leg strengths
	frontLeftLeg.strength  = frontLeftLegStrength  * legLerp.currentPos
	frontRightLeg.strength = frontRightLegStrength * legLerp.currentPos
	backLeftLeg.strength   = backLeftLegStrength   * legLerp.currentPos
	backRightLeg.strength  = backRightLegStrength  * legLerp.currentPos
	
	giraffeParts.NeckPivot
		:offsetRot(-giraffeParts.LowerBody:getRot())
	
	-- Set upperbody to offset crouching pivot point
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