-- Required scripts
require("lib.GSAnimBlend")
local giraffeParts = require("lib.GroupIndex")(models.models.Giraffe)
local ground       = require("lib.GroundCheck")
local pose         = require("scripts.Posing")

-- Animations setup
local anims = animations["models.Giraffe"]

-- GS Blending Setup
local blendAnims = {
	{ anim = anims.crouch, ticks = {20,20} }
}

-- Apply GS Blending
for _, blend in ipairs(blendAnims) do
	blend.anim:blendTime(table.unpack(blend.ticks)):onBlend("easeOutQuad")
end