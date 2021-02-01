require "/scripts/vec2.lua"

function init()
	
end

function update(dt)
	if not imageRendered and config.getParameter("backgroundOverlays") then
		local backgroundOverlays = config.getParameter("backgroundOverlays")
		for i, overlay in ipairs (backgroundOverlays) do
			localAnimator.addDrawable({
				image = overlay.image,
				position = vec2.add(entity.position(), overlay.position or {0, 0}),
				fullbright = overlay.fullbright
			}, "backgroundOverlay+" .. i)
		end
		imageRendered = true
	end
end