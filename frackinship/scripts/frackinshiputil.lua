frackinship = {}

function frackinship.getRaceList()
	local raceList = {}
	local racesLower = root.assetJson("/interface/windowconfig/charcreation.config").speciesOrdering
	local raceShips = root.assetJson("/universe_server.config").speciesShips
	local racesLowerTable = {}
	for _, race in ipairs (racesLower) do
		racesLowerTable[race] = true
	end
	for race, _ in pairs (raceShips) do
		if racesLowerTable[string.lower(race)] then
			table.insert(raceList, race)
		end
	end
	table.sort(raceList, frackinship.compareRaces)
	return raceList
end

-- Copied from terminal code
function frackinship.compareRaces(raceA, raceB)
	local a = frackinship.comparableName(raceA)
	local b = frackinship.comparableName(raceB)
	return a < b
end

function frackinship.comparableName(name)
	return name:gsub('%^#?%w+;', '') -- removes the color encoding from names, e.g. ^blue;Madness^reset; -> Madness
		:gsub('ū', 'u')
		:upper()
end

function frackinship.getRaceDisplayNames(races)
	local raceDisplayNames = {}
	local raceTableOverride = root.assetJson("/frackinship/configs/racetableoverride.config")
	for _, race in ipairs (races) do
		if raceTableOverride[race] and raceTableOverride[race].name then
			raceDisplayNames[race] = raceTableOverride[race].name
		else
			local succeded, raceData = pcall(root.assetJson, "/species/" .. race .. ".species")
			if succeded and raceData and raceData.charCreationTooltip then
				raceDisplayNames[race] = raceData.charCreationTooltip.title
			end
		end
	end
	return raceDisplayNames
end

function frackinship.makeStarDateReadable(tm)
	local stardate = "Unknown"
	if tm then
		local tmStr1 = string.sub(tm,2,5 )
		local tmStr2 = string.sub(tm,6,6 )
		local tmStr3 = string.sub(tm,8,10 )
		stardate = tmStr1.."."..tmStr2..":"..tmStr3
	end
	return stardate
end