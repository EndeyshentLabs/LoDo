---@class UIElement
UIElement = {}

---Basic UI element
---@param x number X pos
---@param y number Y pos
---@param w number Width
---@param h number Height
---@return table
function UIElement:new(x, y, w, h)
    local private = {}

    local public = {}
    public.x = x
    public.y = y
    public.w = w
    public.h = h

    function UIElement:draw()
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end

    function public:isHovered()
        local mX = love.mouse.getX()
        local mY = love.mouse.getY()

        if mX >= self.x and mX <= self.x + self.w and mY >= self.y and mY <= self.y + self.h then
            return true
        end
        return false
    end

    function public:isClicked()
        if self:isHovered() and love.mouse.isDown(1) then
            return true
        end
        return false
    end

    setmetatable(public, self)
    self.__index = self
    return public
end

---@class ColorButton
ColorButton = extended(UIElement)

---Constructor to ColorButton class
---@param text string Text on button
---@param fun function Function to do on-click
---@param x number X pos
---@param y number Y pos
---@param w number Width
---@param h number Height
---@param normalColor string Hex string of the color when button is idle
---@param hoveredColor string Hex string of the color when button is hovered by mouse
---@param textColor string Hex string of the label text color
---@return table
function ColorButton:new(text, fun, x, y, w, h, normalColor, hoveredColor, textColor)
    local private = {}

    local public = {}
    public.text = text
    public.x = x
    public.y = y
    public.w = w
    public.h = h

    function ColorButton:draw()
        if self:isHovered() then
            setColorHEX(hoveredColor) -- #ffffff
        else
            setColorHEX(normalColor) -- #282828
        end
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
        setColorHEX(textColor) -- #ff0000
        love.graphics.print(
            self.text,
            Font,
            self.x + (self.w / 2) - Font:getWidth(self.text) / 2,
            self.y + (self.h / 2) - Font:getHeight() / 2
        )
    end

    function public:isHovered()
        local mX = love.mouse.getX()
        local mY = love.mouse.getY()

        if mX >= self.x and mX <= self.x + self.w and mY >= self.y and mY <= self.y + self.h then
            return true
        end
        return false
    end

    function public:isClicked()
        if self:isHovered() and love.mouse.isDown(1) then
            return true
        end
        return false
    end

    function ColorButton:update(dt)
        if self:isClicked() then
            fun()
        end
    end

    setmetatable(public, self)
    self.__index = self
    return public
end

Button = extended(ColorButton)

function Button:draw()
    if self:isHovered() then
        setColorHEX("#ffffff")
    else
        setColorHEX("#282828")
    end
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    setColorHEX("#ff0000")
    love.graphics.print(
        self.text,
        Font,
        self.x + (self.w / 2) - Font:getWidth(self.text) / 2,
        self.y + (self.h / 2) - Font:getHeight() / 2
    )
end

---@class ColorCheckButton
ColorCheckButton = extended(UIElement)

---Constructor to ColorCheckButton class
---@param x number X pos
---@param y number Y pos
---@param w number Width
---@param h number Height
---@param enabledColor string Hex string of the color when button is checked
---@param disabledColor string Hex string of the color when button is UNckecked
---@return table
function ColorCheckButton:new(x, y, w, h, enabledColor, disabledColor)
    local private = {}

    local public = {}
    public.x = x
    public.y = y
    public.w = w
    public.h = h
    public.enabled = false

    function ColorCheckButton:draw()
        if self.enabled then
            setColorHEX(enabledColor)
        else
            setColorHEX(disabledColor)
        end
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end

    function public:isHovered()
        local mX = love.mouse.getX()
        local mY = love.mouse.getY()

        if mX >= self.x and mX <= self.x + self.w and mY >= self.y and mY <= self.y + self.h then
            return true
        end
        return false
    end

    function public:isClicked()
        local once = false
        if self:isHovered() and love.mouse.isDown(1) and not once then
            once = true
            return true
        end
        return false
    end

    function ColorCheckButton:update(dt)
        if self:isClicked() then
            self.enabled = not self.enabled
        end
    end

    function ColorCheckButton:isEnabled()
        return self.enabled
    end

    setmetatable(public, self)
    self.__index = self
    return public
end

---@class CheckButton
CheckButton = extended(ColorCheckButton)

function CheckButton:draw()
    if self.enabled then
        setColorHEX("#00ff00")
    else
        setColorHEX("#ff0000")
    end
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
