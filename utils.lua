-- CLASS UTILS

---OOP. Extneds a class.
---@param parent table
---@return table
function extended(parent)
	local child = {}
	setmetatable(child, { __index = parent })
	return child
end

-- MISC UTILS

---love.graphics.setColor but uses hex string.
---Yoinked from https://love2d.org/wiki/love.math.colorFromBytes#Example
---@param rgba string Hex string (e.g. "#RRGGBBAA")
function setColorHEX(rgba)
	assert(rgba[1] ~= "#", "Hex string starts with `#`!")
	assert(#rgba >= 7, "Too short hex color!")
	assert(#rgba <= 9, "Too long hex color!")
	local rb = tonumber(string.sub(rgba, 2, 3), 16)
	local gb = tonumber(string.sub(rgba, 4, 5), 16)
	local bb = tonumber(string.sub(rgba, 6, 7), 16)
	local ab = tonumber(string.sub(rgba, 8, 9), 16) or nil
	love.graphics.setColor(love.math.colorFromBytes(rb, gb, bb, ab))
end
