--- === WindowMagnet ===
---
--- Fast Window management.
---
--- Example:
--- ```
--- hs.loadSpoon("WindowMagnet")
---
---
--- spoon.WindowMagnet:start()
--- ```
---
--- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/WindowMagnet.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/WindowMagnet.spoon.zip)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "WindowMagnet"
obj.version = "1.0"
obj.author = "eks5115 <eks5115@gmail.com>"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

local log = hs.logger.new('WM','debug')
log.d('Init')

local wm = dofile(hs.spoons.resourcePath('window-management.lua'))
local kb = dofile(hs.spoons.resourcePath('key-binding.lua'))
local menu = dofile(hs.spoons.resourcePath('menu.lua'))

obj.windowManagement = wm
obj.keyBinding = kb
obj.menu = menu

wm:subscribe()

menu:create()

return obj
