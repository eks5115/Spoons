
local hotkey = require('hs.hotkey')
local wm = dofile(hs.spoons.resourcePath('window-management.lua'))
local menu = dofile(hs.spoons.resourcePath('menu.lua'))

local kb = {
    bindings = {}
}

local function bindHotkeys (mods, keyFus)
    local modsJson = hs.json.encode(mods)
    if kb.bindings[modsJson] == nil then
        kb.bindings[modsJson] = {}
    end
    for key, fn in pairs(keyFus) do
        kb.bindings[modsJson][key] = fn
        hotkey.bind(mods, key, fn)
    end
end

bindHotkeys({'ctrl', 'alt'}, {
    left = wm.left,    -- ⌃⌥ + ←
    right = wm.right,  -- ⌃⌥ + →
    up = wm.up,        -- ⌃⌥ + ↑
    down = wm.down     -- ⌃⌥ + ↓
})

bindHotkeys({'ctrl', 'alt'}, {
    u = wm.topLeft,    -- ⌃⌥ + U
    i = wm.topRight,   -- ⌃⌥ + I
    j = wm.bottomLeft, -- ⌃⌥ + J
    k = wm.bottomRight -- ⌃⌥ + K
})

bindHotkeys({'ctrl', 'alt'}, {
    d = wm.leftThird,           -- ⌃⌥ + D
    e = wm.leftTwoThirds,       -- ⌃⌥ + E
    f = wm.centerThird,         -- ⌃⌥ + F
    t = wm.rightTwoThirds,      -- ⌃⌥ + T
    g = wm.rightThird           -- ⌃⌥ + G
})

bindHotkeys({'ctrl', 'alt', 'cmd'}, {
    right = wm.nextDisplay,    -- ⌃⌥⌘ + →
    left = wm.previousDisplay  -- ⌃⌥⌘ + ←
})

bindHotkeys({'ctrl', 'alt'}, {
    c = wm.centerOnScreen,          -- ⌃⌥ + C
    ["return"] = wm.maximizeWindow, -- ⌃⌥ + ⏎
    delete = wm.restore             -- ⌃⌥ + ⌫
})

bindHotkeys({'ctrl', 'alt'}, {
    m = menu.triggerMenuIcon,          -- ⌃⌥ + M
})

--for mods, keyFus in pairs(kb.bindings) do
--    print(mods)
--    for key, fu in pairs(keyFus) do
--        print(key)
--    end
--end

return kb
