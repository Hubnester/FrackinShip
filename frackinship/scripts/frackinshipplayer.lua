require "/scripts/util.lua"
require "/scripts/messageutil.lua"
require "/scripts/vec2.lua"

local fsInit = init or function() end
local fsUpdate = update or function() end
local fsUninit = uinit or function() end

frackinShip = {}

function init(args)
	fsInit(args)
	shiftToFrackinShip()
	
	message.setHandler("fs_respawn", function()
		local spawn = world.getProperty("fu_byos.spawn", {1024, 1025})
		mcontroller.setPosition(vec2.add(spawn, {0, 2}))
	end)
end

-- Change the world property names to the new ones if they exist and the new one doesn't exist
function shiftToFrackinShip()
	if player.hasCompletedQuest("fu_byos") and not player.hasCompletedQuest("frackinship") then
		player.startQuest("frackinship")
	end
	if world.type() == "unknown" then
		if world.getProperty("fu_byos") and not world.getProperty("frackinship") then
			world.setProperty("frackinship", world.getProperty("fu_byos"))
			world.setProperty("fu_byos", nil)
		end
		if world.getProperty("fu_byos.spawn") and not world.getProperty("frackinship.spawn") then
			world.setProperty("frackinship.spawn", world.getProperty("fu_byos.spawn"))
			world.setProperty("fu_byos.spawn", nil)
		end
		if world.getProperty("fu_byos.newAtmosphereSystem") and not world.getProperty("frackinship.atmosphereMode") then
			world.setProperty("frackinship.atmosphereMode", "fullRoom")
			world.setProperty("fu_byos.newAtmosphereSystem", nil)
		end
		if world.getProperty("fu_byos.owner") and not world.getProperty("frackinShip.owner") then
			world.setProperty("frackinship.owner", world.getProperty("fu_byos.owner"))
			world.setProperty("fu_byos.owner", nil)
		end
	end
end

function update(dt)
	fsUpdate(dt)
	
	-- Make sure the ship handler stagehand exists
	if world.type() == "unknown" then
		if handlerPromise then
			if handlerPromise:finished() then
				if not handlerPromise:succeeded() then
					world.spawnStagehand({1024, 1024}, "frackinshiphandler")
				end
				handlerPromise = world.findUniqueEntity("frackinshiphandler")
			end
		else
			handlerPromise = world.findUniqueEntity("frackinshiphandler")
		end
	end
	
	if player.worldId() == player.ownShipWorldId() then
		if not frackinShip.initFinished then
			frackinShip.initFinished = true
			world.setProperty("frackinship.owner", player.uniqueId())
			world.setProperty("frackinship.race", player.species())
		end
	end
end