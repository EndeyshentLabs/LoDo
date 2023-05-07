Font = nil
List = {}
Cursor = 0
StatusText = "Welcome to LoDo. Made by EndeyshentLabs"

require("utils")
require("UI")

function love.load()
	Font = love.graphics.newFont("res/fonts/Lato-Light.ttf", 24)
end

function love.draw()
	love.graphics.setBackgroundColor(0.04, 0.04, 0.04)
	setColorHEX("#ffffff")
	love.graphics.print(tostring(Cursor), Font, 300, 300)

	if List then
		for k, v in pairs(List) do
			if v.done then
				v.x = 200
			else
				v.x = 0
			end
			v:draw()
		end
	end

	setColorHEX("#202020")
	love.graphics.rectangle(
		"fill",
		0,
		love.graphics.getHeight() - 26,
		love.graphics.getWidth(),
		love.graphics.getHeight()
	)
	local mode = "T"
	if List[Cursor] and List[Cursor].done then
		mode = "D"
	else
		mode = "T"
	end
	setColorHEX("#efefef")
	love.graphics.print((" %s | %s"):format(mode, StatusText), Font, 0, love.graphics.getHeight() - 28)
end

function love.update(dt)
	if Cursor < 0 and #List == 0 then
		Cursor = 0
	end
	if Cursor < 1 and #List > 0 then
		Cursor = 1
	end
	if Cursor > #List then
		Cursor = #List
	end
end

function love.keypressed(key)
	if love.keyboard.isDown("i") then
		List[#List + 1] = Button:new("TODO", function()
		end, 0, #List * 102, 100, 100)
		List[#List].done = false
		Cursor = #List
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
end
