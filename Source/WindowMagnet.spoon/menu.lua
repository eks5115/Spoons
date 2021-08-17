
local storage = dofile(hs.spoons.resourcePath('storage.lua'))
local util = dofile(hs.spoons.resourcePath('util.lua'))

local log = hs.logger.new('WM - menu', 'debug')

menu = {}

local iconAscii = [[ASCII:
................
..B###C..H###I..
.A....#..#....J.
.#....#..#....#.
.#....#..#....#.
.#....#..#....#.
.#....#..L####K.
.#....#.........
.#....#.........
.#....#..P####Q.
.#....#..#....#.
.#....#..#....#.
.#....#..#....#.
.F....#..#....R.
..E###D..T###S..
................
]]



local function loadImage(name)
    return hs.image.imageFromPath(hs.spoons.resourcePath('resources/'..name..'Template.tiff'))
end

local function titleFormat(name, shortcutKey)
    if (shortcutKey == nil) then
        return name
    else
        return hs.styledtext.new(string.format('%-20s%s', name, shortcutKey))
                 :setStyle(hs.styledtext.defaultFonts.menuBar)
                 :setStyle({
            font = {
                name = 'Monaco',
                size = 12
            },
            paragraphStyle = {
                maximumLineHeight = 16
            }
        })
                 :setStyle({
            font = {
                name = 'AppleGothic',
                size = 12
            },
            paragraphStyle = {
                maximumLineHeight = 16
            }
        }, 0 - #shortcutKey)
    end
end

local function createMenuItems ()
    local suffix = ''
    local screen = hs.screen.mainScreen()
    if (screen:frame().w > screen:frame().h) then
        -- horizontal
        suffix = ''
        menu.menubar:stateImageSize({ w=80, h=12})
    else
        -- vertical
        suffix = 'Vert'
        menu.menubar:stateImageSize({ w=80, h=17})
    end

    local config = storage:read()

    local items = {
        { name = 'Left', shortcutKey = '⌃⌥ ←', offStateImage = loadImage('Left'..suffix), disabled = true },
        { name = 'Right', shortcutKey = '⌃⌥ →', offStateImage = loadImage('Right'..suffix), disabled = true },
        { name = 'Up', shortcutKey = '⌃⌥ ↑', offStateImage = loadImage('Up'..suffix), disabled = true },
        { name = 'Down', shortcutKey = '⌃⌥ ↓', offStateImage = loadImage('Down'..suffix), disabled = true },
        { name = '-' },
        { name = 'Top Left', shortcutKey = '⌃⌥ U  ', offStateImage = loadImage('Top_Left'..suffix), disabled = true },
        { name = 'Top Right', shortcutKey = '⌃⌥ I  ', offStateImage = loadImage('Top_Right'..suffix), disabled = true },
        { name = 'Bottom Left', shortcutKey = '⌃⌥ J  ', offStateImage = loadImage('Bottom_Left'..suffix), disabled = true },
        { name = 'Bottom Right', shortcutKey = '⌃⌥ K  ', offStateImage = loadImage('Bottom_Right'..suffix), disabled = true },
        { name = '-' },
        { name = 'Left Third', shortcutKey = '⌃⌥ D  ', offStateImage = loadImage('Left1Third'..suffix), disabled = true },
        { name = 'Left Two Thirds', shortcutKey = '⌃⌥ E  ', offStateImage = loadImage('Left2Thirds'..suffix), disabled = true },
        { name = 'Center Third', shortcutKey = '⌃⌥ F  ', offStateImage = loadImage('MiddleThird'..suffix), disabled = true },
        { name = 'Right Two Thirds', shortcutKey = '⌃⌥ T  ', offStateImage = loadImage('Right2Thirds'..suffix), disabled = true },
        { name = 'Right Third', shortcutKey = '⌃⌥ G  ', offStateImage = loadImage('Right1Third'..suffix), disabled = true },
        { name = '-' },
        { name = 'Next Display', shortcutKey = '⌃⌥⌘ →', offStateImage = loadImage('Next'..suffix), disabled = true },
        { name = 'Previous Display', shortcutKey = '⌃⌥⌘ ←', offStateImage = loadImage('Previous'..suffix), disabled = true },
        { name = '-' },
        { name = 'Maximize', shortcutKey = '⌃⌥ ↩', offStateImage = loadImage('Maximize'..suffix), disabled = true },
        { name = 'Center', shortcutKey = '⌃⌥ C  ', offStateImage = loadImage('Center'..suffix), disabled = true },
        { name = 'Restore', shortcutKey = '⌃⌥ ⌫', offStateImage = loadImage('Restore'..suffix), disabled = true },
        { name = '-' },
        { name = 'Show Menu Icon', shortcutKey = '⌃⌥ M  ', checked = config.showMenuIcon, fn = menu.triggerMenuIcon },
    }
    local menuItems = {}
    for i, v in ipairs(items) do
        table.insert(menuItems, {
            title = titleFormat(v.name, v.shortcutKey),
            offStateImage = v.offStateImage,
            disabled = v.disabled,
            checked = v.checked,
            fn = v.fn,
            indent = 1
        })
    end
    return menuItems
end

function menu:create ()
    self.menubar = hs.menubar.new():setIcon(iconAscii)
    self.menubar:setMenu(createMenuItems)
end

function menu:triggerMenuIcon ()
    local config = storage:read()
    if (config.showMenuIcon) then
        storage:write({
            showMenuIcon = false
        })
        menu.menubar:delete()
    else
        storage:write({
            showMenuIcon = true
        })
        menu:create()
    end
end

return menu
