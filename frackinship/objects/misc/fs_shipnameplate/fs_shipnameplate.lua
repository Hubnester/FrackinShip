require "/frackinship/scripts/frackinshiputil.lua"

function init()
	object.setInteractive(true)
	shipOwner = world.getProperty("frackinship.owner")
	text = config.getParameter("text")
	if not storage.placed then
		if not world.getProperty("frackinship.nameplatePlaced") then
			world.setProperty("frackinship.nameplatePlaced", true)
			storage.placed = true
		else
			object.smash()
		end
	end
end

function die()
	if storage.placed then
		world.setProperty("frackinship.name", nil)
		world.setProperty("frackinship.classification", nil)
		world.setProperty("frackinship.nameplatePlaced", false)
	end
end

function onInteraction(args)
    local shipName = world.getProperty("frackinship.name")
    local shipType = world.getProperty("frackinship.classification")
    local shipDate = frackinship.makeStarDateReadable(world.getProperty("frackinship.constructionTime"))

    if shipName and shipType then
		local displayText = tostring(text.shipNamed):gsub("<shipName>", tostring(shipName)):gsub("<shipDate>", tostring(shipDate)):gsub("<shipType>", tostring(shipType))
        object.say(displayText)
    else
		if world.entityUniqueId(args.sourceId) == shipOwner then
			return { "ScriptPane", "/frackinship/interface/fs_shipnameplate/fs_shipnameplate.config"}
		else
			return { "ShowPopup", {message = tostring(text.notOnOwnShip)}}
		end
    end
end