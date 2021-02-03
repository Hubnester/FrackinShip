require "/frackinship/scripts/frackinshiputil.lua"

local shipTypes
local currTypeIndex
local stardate

function init()
	shipTypes = config.getParameter("shipTypes")
    currTypeIndex = 7

    widget.setText("lblType", shipTypes[currTypeIndex])

    widget.setText("lblDate","Recorded Stardate: " .. frackinship.makeStarDateReadable(world.getProperty("frackinship.constructionTime")))
end

function update(dt)

end

-- widget functions
function btnAccept_Click()
    local name = widget.getText("tboxName")
    if name ~= nil and name ~= "" then
        world.setProperty("frackinship.name", name)
        world.setProperty("frackinship.classification", shipTypes[currTypeIndex])
    end
    pane.dismiss()
end

function btnPickLeft_Click()
   if currTypeIndex > 1 then
      currTypeIndex =currTypeIndex - 1
   else
      currTypeIndex = #shipTypes
   end
   widget.setText("lblType",shipTypes[currTypeIndex])
end

function btnPickRight_Click()
   if currTypeIndex < #shipTypes then
      currTypeIndex = currTypeIndex + 1
   else
      currTypeIndex = 1
   end
   widget.setText("lblType",shipTypes[currTypeIndex])
end