require "/frackinship/scripts/frackinshiputil.lua"

function viewShipStats()
	widget.setVisible("root.miscList", false)
	local text = GUI.frackinship.viewShipStatsText
	local shipUpgrades = player.shipUpgrades()
	local systemTravel = contains(shipUpgrades.capabilities, "planetTravel") or (world.getProperty("fu_byos.systemTravel") or 0) > 0
	local planetTravel = contains(shipUpgrades.capabilities, "planetTravel") or (world.getProperty("fu_byos.planetTravel") or 0) > 0
	if systemTravel then
		text = text:gsub("<engineType>", "Intersystem")
	elseif planetTravel then
		text = text:gsub("<engineType>", "Interplanetary")
	else
		text = text:gsub("<engineType>", "None")
	end
	text = text:gsub("<systemTravelDistance>", "Infinite")	-- Make it get the max system travel distance when that is implemented
	text = text:gsub("<crewSize>", (world.getProperty("frackinship") and world.getProperty("frackinship.crewSize", 0)) or shipUpgrades.crewSize)
	text = text:gsub("<activeCrew>", (type(cfg.Data.crew) == table and #cfg.Data.crew) or "Unknown")
	-- Inactive crew
	text = text:gsub("<maxFuel>", shipUpgrades.maxFuel or 0)
	text = text:gsub("<fuel>", world.getProperty("ship.fuel", 0))
	text = text:gsub("<fuelEfficiency>", (1 - shipUpgrades.fuelEfficiency) * 100)
	text = text:gsub("<shipSpeed>", shipUpgrades.shipSpeed)
	text = text:gsub("<shipMass>", status.stat("shipMass"))
	widget.setText("root.text", text)
end

function changeSailImage()
	widget.clearListItems("root.miscList")
	GUI.frackinship.sailSelect = true
	local sailList = root.assetJson("/ai/ai.config").species or {}
	local races = frackinship.getRaceList()
	local raceDisplayNames = frackinship.getRaceDisplayNames(races)
	for _, race in pairs (races) do
		local listItem = "root.miscList."..widget.addListItem("root.miscList")
		widget.setText(listItem..".name", raceDisplayNames[race] or race)
		widget.setImage(listItem..".icon", "/ai/" .. sailList[race].aiFrames .. ":idle?scalenearest=0.2")
		widget.setData(listItem, {race = race})
	end
end