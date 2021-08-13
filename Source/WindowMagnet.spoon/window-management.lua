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
        grid.setGrid(width .. ' * ' .. height, screen)
    else
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
    fWindow:setFrame(initFrames[fWindow:id()])
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
wm.start = function ()
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
