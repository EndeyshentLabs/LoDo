Font = nil
List = {}
Cursor = 0
StatusText = "Welcome to LoDo. Made by EndeyshentLabs"
---@type "T"|"E"|"I"
Mode = "E"

local input = ""

require("utils")
require("UI")

function love.load()
	Font = love.graphics.newFont("res/fonts/Lato-Light.ttf", 24)
end

function love.draw()
	love.graphics.setBackgroundColor(love.math.colorFromBytes(0x20, 0x20, 0x20))
	setColorHEX("#efefef")
	love.graphics.print(tostring(Cursor), Font, 300, 300)

	love.graphics.rectangle("line", 0, (Cursor - 1) * 32, love.graphics.getWidth(), 32)

	if List then
		for k, v in pairs(List) do
			v.y = (k - 1) * 32
			if v.done then
				v.x = love.graphics.getWidth() / 2
			else
				v.x = 0
			end
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
	love.graphics.print((" | %s"):format(StatusText), Font, 18, love.graphics.getHeight() - 28)
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
		Mode = "T"
	end
end

function love.keypressed(key)
	if love.keyboard.isDown("i") then
		Mode = "I"
	end
	if love.keyboard.isDown("down") then
		Cursor = Cursor + 1
	end
	if love.keyboard.isDown("up") then
		Cursor = Cursor - 1
	end
	if love.keyboard.isDown("space") then
		if Cursor > 0 then
			List[Cursor].done = not List[Cursor].done
		end
	end
	if Mode ~= "I" and love.keyboard.isDown("d") then
		if Cursor > 0 then
			table.remove(List, Cursor)
		end
	end
	if Mode == "I" and key == "return" then
		input = string.sub(input, 2, #input)
		once = true
	end
	if Mode == "I" and key == "backspace" then
		input = string.sub(input, 0, #input - 1)
	end
end

function love.textinput(text)
	if Mode == "I" then
		input = input .. text
	end
end
