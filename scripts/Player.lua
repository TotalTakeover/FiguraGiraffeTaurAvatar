-- Required script
local giraffeParts = require("lib.GroupIndex")(models.models.Giraffe)

-- Config setup
config:name("Centaur")
local vanillaSkin = config:load("AvatarVanillaSkin")
local slim        = config:load("AvatarSlim") or false
if vanillaSkin == nil then vanillaSkin = true end

-- Set skull and portrait groups to visible (incase disabled in blockbench)
giraffeParts.Skull   :visible(true)
giraffeParts.Portrait:visible(true)

-- Vanilla skin parts
local skin = {
	
	giraffeParts.Head.Head,
	giraffeParts.Head.Layer,
	
	giraffeParts.Body.Body,
	giraffeParts.Body.Layer,
	
	giraffeParts.leftArmDefault,
	giraffeParts.leftArmSlim,
	giraffeParts.leftArmDefaultFP,
	giraffeParts.leftArmSlimFP,
	
	giraffeParts.rightArmDefault,
	giraffeParts.rightArmSlim,
	giraffeParts.rightArmDefaultFP,
	giraffeParts.rightArmSlimFP,
	
	giraffeParts.Portrait.Head,
	giraffeParts.Portrait.Layer,
	
	giraffeParts.Skull.Head,
	giraffeParts.Skull.Layer
	
}

-- Layer parts
local layer = {
	
	HAT = {
		giraffeParts.Head.Layer
	},
	JACKET = {
		giraffeParts.Body.Layer
	},
	LEFT_SLEEVE = {
		giraffeParts.leftArmDefault.Layer,
		giraffeParts.leftArmSlim.Layer,
		giraffeParts.leftArmDefaultFP.Layer,
		giraffeParts.leftArmSlimFP.Layer
	},
	RIGHT_SLEEVE = {
		giraffeParts.rightArmDefault.Layer,
		giraffeParts.rightArmSlim.Layer,
		giraffeParts.rightArmDefaultFP.Layer,
		giraffeParts.rightArmSlimFP.Layer
	},
	LEFT_PANTS_LEG = {
		
	},
	RIGHT_PANTS_LEG = {
		
	},
	CAPE = {
		giraffeParts.Cape
	},
	LOWER_BODY = {
		
	}
	
}

-- Determine vanilla player type on init
local vanillaAvatarType
function events.ENTITY_INIT()
	
	vanillaAvatarType = player:getModelType()
	
end

-- Misc tick required events
function events.TICK()
	
	-- Model shape
	local slimShape = (vanillaSkin and vanillaAvatarType == "SLIM") or (slim and not vanillaSkin)
	
	giraffeParts.leftArmDefault:visible(not slimShape)
	giraffeParts.rightArmDefault:visible(not slimShape)
	giraffeParts.leftArmDefaultFP:visible(not slimShape)
	giraffeParts.rightArmDefaultFP:visible(not slimShape)
	
	giraffeParts.leftArmSlim:visible(slimShape)
	giraffeParts.rightArmSlim:visible(slimShape)
	giraffeParts.leftArmSlimFP:visible(slimShape)
	giraffeParts.rightArmSlimFP:visible(slimShape)
	
	-- Skin textures
	local skinType = vanillaSkin and "SKIN" or "PRIMARY"
	for _, part in ipairs(skin) do
		part:primaryTexture(skinType)
	end
	
	-- Cape textures
	giraffeParts.Cape:primaryTexture(vanillaSkin and "CAPE" or "PRIMARY")
	
	-- Layer toggling
	for layerType, parts in pairs(layer) do
		local enabled = enabled
		if layerType == "LOWER_BODY" then
			enabled = player:isSkinLayerVisible("RIGHT_PANTS_LEG") or player:isSkinLayerVisible("LEFT_PANTS_LEG")
		else
			enabled = player:isSkinLayerVisible(layerType)
		end
		for _, part in ipairs(parts) do
			part:visible(enabled)
		end
	end
	
end

-- Vanilla skin toggle
function pings.setAvatarVanillaSkin(boolean)
	
	vanillaSkin = boolean
	config:save("AvatarVanillaSkin", vanillaSkin)
	
end

-- Model type toggle
function pings.setAvatarModelType(boolean)
	
	slim = boolean
	config:save("AvatarSlim", slim)
	
end

-- Sync variables
function pings.syncPlayer(a, b)
	
	vanillaSkin = a
	slim = b
	
end

-- Host only instructions
if not host:isHost() then return end

-- Required scripts
local itemCheck = require("lib.ItemCheck")
local color     = require("scripts.ColorProperties")

-- Sync on tick
function events.TICK()
	
	if world.getTime() % 200 == 0 then
		pings.syncPlayer(vanillaSkin, slim)
	end
	
end

-- Table setup
local t = {}

-- Actions
t.vanillaSkinPage = action_wheel:newAction()
	:item(itemCheck("player_head{'SkullOwner':'"..avatar:getEntityName().."'}"))
	:onToggle(pings.setAvatarVanillaSkin)
	:toggled(vanillaSkin)

t.modelPage = action_wheel:newAction()
	:item(itemCheck("player_head"))
	:toggleItem(itemCheck("player_head{'SkullOwner':'MHF_Alex'}"))
	:onToggle(pings.setAvatarModelType)
	:toggled(slim)

-- Update actions
function events.TICK()
	
	if action_wheel:isEnabled() then
		t.vanillaSkinPage
			:title(toJson
				{"",
				{text = "Toggle Vanilla Texture\n\n", bold = true, color = color.primary},
				{text = "Toggles the usage of your vanilla skin.", color = color.secondary}}
			)
		
		t.modelPage
			:title(toJson
				{"",
				{text = "Toggle Model Shape\n\n", bold = true, color = color.primary},
				{text = "Adjust the model shape to use Default or Slim Proportions.\nWill be overridden by the vanilla skin toggle.", color = color.secondary}}
			)
		
		for _, page in pairs(t) do
			page:hoverColor(color.hover):toggleColor(color.active)
		end
		
	end
	
end

-- Return actions
return t