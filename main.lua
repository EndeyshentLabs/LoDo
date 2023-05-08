Font = nil
List = {}
Cursor = 0
StatusText = "Welcome to LoDo. Made by EndeyshentLabs"
---`N` - normal mode
---`I` - input mode
---@type "N"|"I"
Mode = "N"

local input = ""

require("utils")
require("UI")

function StrSplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

function love.load()
	local c, s = love.filesystem.read("todos.LoDo")
	if c then
		local lines = StrSplit(c, "\r\n")
		for _, v in pairs(lines) do
			if v:sub(1, 2) == "T " then
				List[#List + 1] = TodoElement:new(v:sub(3, #v), 0, 0, love.graphics.getWidth() / 2, 30)
				List[#List].done = false
			elseif v:sub(1, 2) == "D " then
				List[#List + 1] = TodoElement:new(v:sub(3, #v), 0, 0, love.graphics.getWidth() / 2, 30)
				List[#List].done = true
			else
				assert(false, "UNKNOWN: " .. v:sub(1, 2))
			end
		end
	end
	Font = love.graphics.newFont("res/fonts/VictorMono-Regular.ttf", 24)
end

function love.draw()
	love.graphics.setBackgroundColor(love.math.colorFromBytes(0x20, 0x20, 0x20))
	setColorHEX("#efefef")
	love.graphics.rectangle("line", 0, (Cursor - 1) * 32, love.graphics.getWidth(), 32)

	if List then
		for k, v in pairs(List) do
			v.y = (k - 1) * 32
			if v.done then
				v.x = love.graphics.getWidth() / 2
			else
				v.x = 0
			end
			v.w = love.graphics.getWidth() / 2
			v:draw()
		end
	end

	setColorHEX("#101010")
	love.graphics.rectangle(
		"fill",
		0,
		love.graphics.getHeight() - 26,
		love.graphics.getWidth(),
		love.graphics.getHeight()
	)
	setColorHEX("#efefef")
	love.graphics.print(Mode, Font, 0, love.graphics.getHeight() - 28)
	love.graphics.print(("| %s"):format(StatusText), Font, Font:getWidth("W"), love.graphics.getHeight() - 28)
end

local once = false

function love.update()
	if Mode == "I" then
		StatusText = "Creating: " .. string.sub(input, 2, #input)
	end
	if Cursor < 0 and #List == 0 then
		Cursor = 0
	end
	if Cursor < 1 and #List > 0 then
		Cursor = 1
	end
	if Cursor > #List then
		Cursor = #List
	end

	if once then
		List[#List + 1] = TodoElement:new(input, 0, 0, love.graphics.getWidth() / 2, 30)
		List[#List].done = false
		Cursor = #List
		once = false
		StatusText = "Created " .. input
		input = ""
		Mode = "N"
	end
end

function love.keypressed(key)
	if key == "i" then
		Mode = "I"
	end
	if key == "down" then
		Cursor = Cursor + 1
	end
	if key == "up" then
		Cursor = Cursor - 1
	end
	if Mode ~= "I" and key == "space" then
		if Cursor > 0 then
			List[Cursor].done = not List[Cursor].done
		end
	end
	if Mode ~= "I" and key == "d" then
		if Cursor > 0 then
			StatusText = "Deleted " .. List[Cursor].text
			table.remove(List, Cursor)
		end
	end
	if Mode == "I" and key == "return" then
		input = string.sub(input, 2, #input)
		once = true
	end
	if Mode == "I" and key == "backspace" then
		if #input ~= 1 then
			input = string.sub(input, 0, #input - 1)
		end
	end
end

function love.textinput(text)
	if Mode == "I" then
		input = input .. text
	end
end

function love.quit()
	local string = ""
	for _, v in pairs(List) do
		if v then
			if v.done then
				string = string .. "\n" .. "D " .. v.text
			else
				string = string .. "\n" .. "T " .. v.text
			end
		end
	end
	love.filesystem.write("todos.LoDo", string)
end
