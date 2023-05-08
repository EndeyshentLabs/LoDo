---@class TodoElement
TodoElement = {}

function TodoElement:new(text, x, y, w, h)
	local public = {}
	public.text = text
	public.x = x
	public.y = y
	public.w = w
	public.h = h
	public.done = false

	function public:draw()
		if self.done then
			setColorHEX("#20ff20")
		else
			setColorHEX("#ff2020")
		end
		love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
		if self.done then
			setColorHEX("#202020")
		else
			setColorHEX("#efefef")
		end
		love.graphics.print(
			self.text,
			Font,
			self.x + (self.w / 2) - Font:getWidth(self.text) / 2,
			self.y + (self.h / 2) - Font:getHeight() / 2
		)
	end

	setmetatable(public, self)
	self.__index = self
	return public
end
