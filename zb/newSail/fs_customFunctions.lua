function changeSailImage()
	widget.clearListItems("root.miscList")
	GUI.frackinship.sailSelect = true
	local sailList = root.assetJson("/ai/ai.config").species or {}
	local races = {}
	for race, _ in pairs (sailList) do
		table.insert(races, race)
		local succeded, raceData = pcall(root.assetJson, "/species/" .. race .. ".species")
		if succeded and raceData and raceData.charCreationTooltip then
			sailList[race].name = raceData.charCreationTooltip.title
		end
	end
	table.sort(races, fsCompareByName)
	for _, race in pairs (races) do
		local listItem = "root.miscList."..widget.addListItem("root.miscList")
		widget.setText(listItem..".name", sailList[race].name)
		widget.setImage(listItem..".icon", "/ai/" .. sailList[race].aiFrames .. ":idle?scalenearest=0.2")
		widget.setData(listItem, {race = race})
	end
end

-- Copied from terminal code
function fsCompareByName(raceA, raceB)
	local a = fsComparableName(raceA)
	local b = fsComparableName(raceB)
	return a < b
end

function fsComparableName(name)
	return name:gsub('%^#?%w+;', '') -- removes the color encoding from names, e.g. ^blue;Madness^reset; -> Madness
		:gsub('ū', 'u')
		:upper()
end