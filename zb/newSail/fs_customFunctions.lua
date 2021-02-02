require "/frackinship/scripts/frackinshiputil.lua"

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