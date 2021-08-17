local window = require('hs.window')
local grid = require('hs.grid')
local geometry = require('hs.geometry')

local log = hs.logger.new('WM - wm', 'debug')

local function cell(x, y, w, h)
    return geometry(x, y, w, h)
end

grid.setMargins('0, 0')
local width = 6
local height = 4

for i, screen in pairs(hs.screen.allScreens()) do
    if (screen:frame().w > screen:frame().h) then
        -- horizontal
        grid.setGrid(width .. ' * ' .. height, screen)
    else
        -- vertical
        grid.setGrid(height .. ' * ' .. width, screen)
    end
end

local wm = {
    initFrames = {}
}

wm.left = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    grid.set(fWindow, cell(0, 0, fGrid.w/2, fGrid.h), fWindow:screen())
end

wm.right = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    grid.set(fWindow, cell(fGrid.w/2, 0, fGrid.w/2, fGrid.h), fWindow:screen())
end

wm.up = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    grid.set(fWindow, cell(0, 0, fGrid.w, fGrid.h/2), fWindow:screen())
end

wm.down = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    grid.set(fWindow, cell(0, fGrid.h/2, fGrid.w, fGrid.h/2), fWindow:screen())
end
---
wm.topLeft = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    grid.set(fWindow, cell(0, 0, fGrid.w/2, fGrid.h/2), fWindow:screen())
end
wm.topRight = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    grid.set(fWindow, cell(fGrid.w/2, 0, fGrid.w/2, fGrid.h/2), fWindow:screen())
end
wm.bottomLeft = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    grid.set(fWindow, cell(0, fGrid.h/2, fGrid.w/2, fGrid.h/2), fWindow:screen())
end
wm.bottomRight = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    grid.set(fWindow, cell(fGrid.w/2, fGrid.h/2, fGrid.w/2, fGrid.h/2), fWindow:screen())
end
---
wm.leftThird = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    if (fGrid.w > fGrid.h) then
        grid.set(fWindow, cell(0, 0, fGrid.w/3, fGrid.h), fWindow:screen())
    else
        grid.set(fWindow, cell(0, 0, fGrid.w, fGrid.h/3), fWindow:screen())
    end
end
wm.leftTwoThirds = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    if (fGrid.w > fGrid.h) then
        grid.set(fWindow, cell(0, 0, fGrid.w*2/3, fGrid.h), fWindow:screen())
    else
        grid.set(fWindow, cell(0, 0, fGrid.w, fGrid.h*2/3), fWindow:screen())
    end
end
wm.centerThird = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    if (fGrid.w > fGrid.h) then
        grid.set(fWindow, cell(fGrid.w/3, 0, fGrid.w/3, fGrid.h), fWindow:screen())
    else
        grid.set(fWindow, cell(0, fGrid.h/3, fGrid.w, fGrid.h/3), fWindow:screen())
    end
end
wm.rightTwoThirds = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    if (fGrid.w > fGrid.h) then
        grid.set(fWindow, cell(fGrid.w/3, 0, fGrid.w*2/3, fGrid.h, fGrid), fWindow:screen())
    else
        grid.set(fWindow, cell(0, fGrid.h/3, fGrid.w, fGrid.h*2/3, fGrid), fWindow:screen())
    end
end
wm.rightThird = function ()
    local fWindow = window.focusedWindow()
    local fGrid = hs.grid.getGrid(fWindow:screen())
    if (fGrid.w > fGrid.h) then
        grid.set(fWindow, cell(fGrid.w*2/3, 0, fGrid.w/3, fGrid.h, fGrid), fWindow:screen())
    else
        grid.set(fWindow, cell(0, fGrid.h*2/3, fGrid.w, fGrid.h/3, fGrid), fWindow:screen())
    end
end
---
wm.maximizeWindow = function ()
    local fWindow = window.focusedWindow()
    grid.maximizeWindow(fWindow)
end
wm.centerOnScreen = function ()
    local fWindow = window.focusedWindow()
    fWindow:centerOnScreen(fWindow:screen())
end
initFrames = {}
wm.restore = function ()
    local fWindow = window.focusedWindow()
    local frame = initFrames[fWindow:id()]
    if (not frame == nil) then
        fWindow:setFrame(frame)
    end
end
---
wm.nextDisplay = function ()
    local fWindow = window.focusedWindow()
    fWindow:moveToScreen(fWindow:screen():next())
end

wm.previousDisplay = function ()
    local fWindow = window.focusedWindow()
    fWindow:moveToScreen(fWindow:screen():previous())
end

--- subscribe event
wm.subscribe = function ()
    hs.window.filter.new(true):subscribe(hs.window.filter.windowFocused, function(win, appName, event)
        local initFrame = initFrames[win:id()]
        if (initFrame == nil) then
            initFrames[win:id()] = win:frame()
        end
    end)

    hs.window.filter.new(true):subscribe(hs.window.filter.windowDestroyed, function(win, appName, event)
        initFrames[win:id()] = nil
    end)
end

return wm
