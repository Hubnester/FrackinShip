require "/scripts/vec2.lua"

function init()
	if not storage.placed then
		local position = entity.position()
		local image = config.getParameter("defaultImageConfig")[1].imageLayers[1].image
		local imageSpaces = root.imageSpaces(image:gsub("<color>", "default"), vec2.add(position, config.getParameter("defaultImageConfig")[1].imagePosition), config.getParameter("defaultImageConfig")[1].spaceScan)
		local imageSpaces = root.imageSpaces(image:gsub("<color>", "default"), {0, 0}, config.getParameter("defaultImageConfig")[1].spaceScan)
		local materialSpaces = {}
		for _, pos in ipairs (imageSpaces) do
			table.insert(materialSpaces, {pos, "fsracialisablespaces"})
		end
		object.setMaterialSpaces(materialSpaces)
		storage.placed = true
	end
end

function die()
	if config.getParameter("keepStorage") then
		object.setConfigParameter("storageData", storage)
	end
	storage = {}
	object.setConfigParameter("treasurePools", nil)
	object.setConfigParameter("doorState", nil)
	if config.getParameter("uniqueId") and not config.getParameter("keepUniqueId") then
		object.setConfigParameter("uniqueId", nil)
	end
end