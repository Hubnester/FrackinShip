require "/scripts/vec2.lua"
local origInit = init or function() end

function init()
	origInit()
	
	if world.type() == "unknown" then
		local spawn = vec2.add(object.position(), {0,1})
		world.setPlayerStart(spawn, true)
		world.setProperty("frackinship.spawn", spawn)
	end
end