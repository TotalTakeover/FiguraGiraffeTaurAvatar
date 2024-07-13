-- Avatar color
avatar:color(vectors.hexToRGB("FDCD6B"))

-- Host only instructions
if not host:isHost() then return end

-- Table setup
local t = {}

-- Action variables
t.hover     = vectors.hexToRGB("FDCD6B")
t.active    = vectors.hexToRGB("DB8049")
t.primary   = "#FDCD6B"
t.secondary = "#DB8049"

-- Return variables
return t