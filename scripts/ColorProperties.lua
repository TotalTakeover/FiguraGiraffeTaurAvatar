-- Avatar color
avatar:color(vectors.hexToRGB("FDCD6B"))

-- Host only instructions
if not host:isHost() then return end

-- Table setup
local c = {}

-- Action variables
c.hover     = vectors.hexToRGB("FDCD6B")
c.active    = vectors.hexToRGB("DB8049")
c.primary   = "#FDCD6B"
c.secondary = "#DB8049"

-- Return variables
return c