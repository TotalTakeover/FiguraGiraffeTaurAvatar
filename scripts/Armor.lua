-- Required scripts
local parts        = require("lib.PartsAPI")
local giraffeArmor = require("lib.KattArmor")()

-- Setting the leggings to layer 1
giraffeArmor.Armor.Leggings:setLayer(1)

-- Armor parts
giraffeArmor.Armor.Helmet
	:addParts(table.unpack(parts:createTable(function(part) return part:getName() == "Helmet" end)))
	:addTrimParts(table.unpack(parts:createTable(function(part) return part:getName() == "HelmetTrim" end)))
giraffeArmor.Armor.Chestplate
	:addParts(table.unpack(parts:createTable(function(part) return part:getName() == "Chestplate" end)))
	:addTrimParts(table.unpack(parts:createTable(function(part) return part:getName() == "ChestplateTrim" end)))
giraffeArmor.Armor.Leggings
	:addParts(table.unpack(parts:createTable(function(part) return part:getName() == "Leggings" end)))
	:addTrimParts(table.unpack(parts:createTable(function(part) return part:getName() == "LeggingsTrim" end)))
giraffeArmor.Armor.Boots
	:addParts(table.unpack(parts:createTable(function(part) return part:getName() == "Boot" end)))
	:addTrimParts(table.unpack(parts:createTable(function(part) return part:getName() == "BootTrim" end)))

-- Leather armor
giraffeArmor.Materials.leather
	:setTexture(textures["textures.armor.leatherArmor"] or textures["Giraffe.leatherArmor"])
	:addParts(giraffeArmor.Armor.Helmet,     table.unpack(parts:createTable(function(part) return part:getName() == "HelmetLeather" end)))
	:addParts(giraffeArmor.Armor.Chestplate, table.unpack(parts:createTable(function(part) return part:getName() == "ChestplateLeather" end)))
	:addParts(giraffeArmor.Armor.Leggings,   table.unpack(parts:createTable(function(part) return part:getName() == "LeggingsLeather" end)))
	:addParts(giraffeArmor.Armor.Boots,      table.unpack(parts:createTable(function(part) return part:getName() == "BootLeather" end)))

-- Chainmail armor
giraffeArmor.Materials.chainmail
	:setTexture(textures["textures.armor.chainmailArmor"] or textures["Giraffe.chainmailArmor"])

-- Iron armor
giraffeArmor.Materials.iron
	:setTexture(textures["textures.armor.ironArmor"] or textures["Giraffe.ironArmor"])

-- Golden armor
giraffeArmor.Materials.golden
	:setTexture(textures["textures.armor.goldenArmor"] or textures["Giraffe.goldenArmor"])

-- Diamond armor
giraffeArmor.Materials.diamond
	:setTexture(textures["textures.armor.diamondArmor"] or textures["Giraffe.diamondArmor"])

-- Netherite armor
giraffeArmor.Materials.netherite
	:setTexture(textures["textures.armor.netheriteArmor"] or textures["Giraffe.netheriteArmor"])

-- Turtle helmet
giraffeArmor.Materials.turtle
	:setTexture(textures["textures.armor.turtleHelmet"] or textures["Giraffe.turtleHelmet"])

-- Trims
-- Bolt
giraffeArmor.TrimPatterns.bolt
	:setTexture(textures["textures.armor.trims.boltTrim"] or textures["Giraffe.boltTrim"])

-- Coast
giraffeArmor.TrimPatterns.coast
	:setTexture(textures["textures.armor.trims.coastTrim"] or textures["Giraffe.coastTrim"])

-- Dune
giraffeArmor.TrimPatterns.dune
	:setTexture(textures["textures.armor.trims.duneTrim"] or textures["Giraffe.duneTrim"])

-- Eye
giraffeArmor.TrimPatterns.eye
	:setTexture(textures["textures.armor.trims.eyeTrim"] or textures["Giraffe.eyeTrim"])

-- Flow
giraffeArmor.TrimPatterns.flow
	:setTexture(textures["textures.armor.trims.flowTrim"] or textures["Giraffe.flowTrim"])

-- Host
giraffeArmor.TrimPatterns.host
	:setTexture(textures["textures.armor.trims.hostTrim"] or textures["Giraffe.hostTrim"])

-- Raiser
giraffeArmor.TrimPatterns.raiser
	:setTexture(textures["textures.armor.trims.raiserTrim"] or textures["Giraffe.raiserTrim"])

-- Rib
giraffeArmor.TrimPatterns.rib
	:setTexture(textures["textures.armor.trims.ribTrim"] or textures["Giraffe.ribTrim"])

-- Sentry
giraffeArmor.TrimPatterns.sentry
	:setTexture(textures["textures.armor.trims.sentryTrim"] or textures["Giraffe.sentryTrim"])

-- Shaper
giraffeArmor.TrimPatterns.shaper
	:setTexture(textures["textures.armor.trims.shaperTrim"] or textures["Giraffe.shaperTrim"])

-- Silence
giraffeArmor.TrimPatterns.silence
	:setTexture(textures["textures.armor.trims.silenceTrim"] or textures["Giraffe.silenceTrim"])

-- Snout
giraffeArmor.TrimPatterns.snout
	:setTexture(textures["textures.armor.trims.snoutTrim"] or textures["Giraffe.snoutTrim"])

-- Spire
giraffeArmor.TrimPatterns.spire
	:setTexture(textures["textures.armor.trims.spireTrim"] or textures["Giraffe.spireTrim"])

-- Tide
giraffeArmor.TrimPatterns.tide
	:setTexture(textures["textures.armor.trims.tideTrim"] or textures["Giraffe.tideTrim"])

-- Vex
giraffeArmor.TrimPatterns.vex
	:setTexture(textures["textures.armor.trims.vexTrim"] or textures["Giraffe.vexTrim"])

-- Ward
giraffeArmor.TrimPatterns.ward
	:setTexture(textures["textures.armor.trims.wardTrim"] or textures["Giraffe.wardTrim"])

-- Wayfinder
giraffeArmor.TrimPatterns.wayfinder
	:setTexture(textures["textures.armor.trims.wayfinderTrim"] or textures["Giraffe.wayfinderTrim"])

-- Wild
giraffeArmor.TrimPatterns.wild
	:setTexture(textures["textures.armor.trims.wildTrim"] or textures["Giraffe.wildTrim"])

-- Config setup
config:name("GiraffeTaur")
local helmet     = config:load("ArmorHelmet")
local chestplate = config:load("ArmorChestplate")
local leggings   = config:load("ArmorLeggings")
local boots      = config:load("ArmorBoots")
if helmet     == nil then helmet     = true end
if chestplate == nil then chestplate = true end
if leggings   == nil then leggings   = true end
if boots      == nil then boots      = true end

-- Helmet parts
local helmetGroups = parts:createTable(function(part) return part:getName():find("ArmorHelmet") end)

-- Chestplate parts
local chestplateGroups = parts:createTable(function(part) return part:getName():find("ArmorChestplate") end)

-- Leggings parts
local leggingsGroups = parts:createTable(function(part) return part:getName():find("ArmorLeggings") end)

-- Boots parts
local bootsGroups = parts:createTable(function(part) return part:getName():find("ArmorBoot") end)

function events.RENDER(delta, context)
	
	-- Apply
	for _, part in ipairs(helmetGroups) do
		part:visible(helmet)
	end
	
	for _, part in ipairs(chestplateGroups) do
		part:visible(chestplate)
	end
	
	for _, part in ipairs(leggingsGroups) do
		part:visible(leggings)
	end
	
	for _, part in ipairs(bootsGroups) do
		part:visible(boots)
	end
	
end

-- All toggle
function pings.setArmorAll(boolean)
	
	helmet     = boolean
	chestplate = boolean
	leggings   = boolean
	boots      = boolean
	config:save("ArmorHelmet", helmet)
	config:save("ArmorChestplate", chestplate)
	config:save("ArmorLeggings", leggings)
	config:save("ArmorBoots", boots)
	if player:isLoaded() then
		sounds:playSound("item.armor.equip_generic", player:getPos(), 0.5)
	end
	
end

-- Helmet toggle
function pings.setArmorHelmet(boolean)
	
	helmet = boolean
	config:save("ArmorHelmet", helmet)
	if player:isLoaded() then
		sounds:playSound("item.armor.equip_generic", player:getPos(), 0.5)
	end
	
end

-- Chestplate toggle
function pings.setArmorChestplate(boolean)
	
	chestplate = boolean
	config:save("ArmorChestplate", chestplate)
	if player:isLoaded() then
		sounds:playSound("item.armor.equip_generic", player:getPos(), 0.5)
	end
	
end

-- Leggings toggle
function pings.setArmorLeggings(boolean)
	
	leggings = boolean
	config:save("ArmorLeggings", leggings)
	if player:isLoaded() then
		sounds:playSound("item.armor.equip_generic", player:getPos(), 0.5)
	end
	
end

-- Boots toggle
function pings.setArmorBoots(boolean)
	
	boots = boolean
	config:save("ArmorBoots", boots)
	if player:isLoaded() then
		sounds:playSound("item.armor.equip_generic", player:getPos(), 0.5)
	end
	
end

-- Sync variables
function pings.syncArmor(a, b, c, d)
	
	helmet     = a
	chestplate = b
	leggings   = c
	boots      = d
	
end

-- Host only instructions
if not host:isHost() then return end

-- Required scripts
local itemCheck = require("lib.ItemCheck")
local s, c = pcall(require, "scripts.ColorProperties")
if not s then c = {} end

-- Sync on tick
function events.TICK()
	
	if world.getTime() % 200 == 0 then
		pings.syncArmor(helmet, chestplate, leggings, boots)
	end
	
end

-- Table setup
local t = {}

-- Actions
t.allAct = action_wheel:newAction()
	:item(itemCheck("armor_stand"))
	:toggleItem(itemCheck("netherite_chestplate"))
	:onToggle(pings.setArmorAll)

t.helmetAct = action_wheel:newAction()
	:item(itemCheck("iron_helmet"))
	:toggleItem(itemCheck("diamond_helmet"))
	:onToggle(pings.setArmorHelmet)

t.chestplateAct = action_wheel:newAction()
	:item(itemCheck("iron_chestplate"))
	:toggleItem(itemCheck("diamond_chestplate"))
	:onToggle(pings.setArmorChestplate)

t.leggingsAct = action_wheel:newAction()
	:item(itemCheck("iron_leggings"))
	:toggleItem(itemCheck("diamond_leggings"))
	:onToggle(pings.setArmorLeggings)

t.bootsAct = action_wheel:newAction()
	:item(itemCheck("iron_boots"))
	:toggleItem(itemCheck("diamond_boots"))
	:onToggle(pings.setArmorBoots)

-- Update actions
function events.RENDER(delta, context)
	
	if action_wheel:isEnabled() then
		t.allAct
			:title(toJson(
				{
					"",
					{text = "Toggle All Armor\n\n", bold = true, color = c.primary},
					{text = "Toggles visibility of all armor parts.", color = c.secondary}
				}
			))
			:toggled(helmet and chestplate and leggings and boots)
		
		t.helmetAct
			:title(toJson(
				{
					"",
					{text = "Toggle Helmet\n\n", bold = true, color = c.primary},
					{text = "Toggles visibility of helmet parts.", color = c.secondary}
				}
			))
			:toggled(helmet)
		
		t.chestplateAct
			:title(toJson(
				{
					"",
					{text = "Toggle Chestplate\n\n", bold = true, color = c.primary},
					{text = "Toggles visibility of chestplate parts.", color = c.secondary}
				}
			))
			:toggled(chestplate)
		
		t.leggingsAct
			:title(toJson(
				{
					"",
					{text = "Toggle Leggings\n\n", bold = true, color = c.primary},
					{text = "Toggles visibility of leggings parts.", color = c.secondary}
				}
			))
			:toggled(leggings)
		
		t.bootsAct
			:title(toJson(
				{
					"",
					{text = "Toggle Boots\n\n", bold = true, color = c.primary},
					{text = "Toggles visibility of boots.", color = c.secondary}
				}
			))
			:toggled(boots)
		
		for _, act in pairs(t) do
			act:hoverColor(c.hover):toggleColor(c.active)
		end
		
	end
	
end

-- Return actions
return t