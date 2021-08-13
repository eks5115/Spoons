
local hotkey = require('hs.hotkey')
local wm = dofile(hs.spoons.resourcePath('window-management.lua'))

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
    u = wm.topLeft,    -- ⌃⌥⌘ + U
    i = wm.topRight,   -- ⌃⌥⌘ + I
    j = wm.bottomLeft, -- ⌃⌥⌘ + J
    k = wm.bottomRight -- ⌃⌥⌘ + K
})

bindHotkeys({'ctrl', 'alt', 'cmd'}, {
    right = wm.nextDisplay,    -- ⌃⌥⌘ + →
    left = wm.previousDisplay  -- ⌃⌥⌘ + ←
})

bindHotkeys({'ctrl', 'alt'}, {
    c = wm.centerOnScreen,          -- ⌃⌥⌘ + C
    ["return"] = wm.maximizeWindow, -- ⌃⌥⌘ + ⏎
    delete = wm.restore             -- ⌃⌥⌘ + ⌦
})

for mods, keyFus in pairs(kb.bindings) do
    print(mods)
    for key, fu in pairs(keyFus) do
        print(key)
    end
end

return kb
