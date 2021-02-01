require "/scripts/vec2.lua"

function init()
	if not config.getParameter("backgroundOverlays") then
		local shipRace = world.getProperty("frackinship.race", "apex")
		local shipsConfig = root.assetJson("/universe_server.config").speciesShips[shipRace]
		if shipsConfig then
			local shipConfigPath = shipsConfig[2]
			local shipConfig = root.assetJson(shipConfigPath)
			for i, overlay in ipairs (shipConfig.backgroundOverlays) do
				if string.sub(overlay.image, 1, 1) ~= "/" then
					local reversedFile = string.reverse(shipConfigPath)
					local snipLocation = string.find(reversedFile, "/")
					local shipImagePathGsub = string.sub(shipConfigPath, -snipLocation + 1)
					shipConfig.backgroundOverlays[i].image = shipConfigPath:gsub(shipImagePathGsub, overlay.image)
				end
			end
			object.setConfigParameter("backgroundOverlays", shipConfig.backgroundOverlays)
		end
	end
end

function update(dt)
	if world.getProperty("ship.level", 1) ~= 0 or world.getProperty("frackinship") then
		object.smash()
	end
end