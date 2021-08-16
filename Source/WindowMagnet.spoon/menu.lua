
local log = hs.logger.new('WM - menu', 'debug')

local obj = {}

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

local menu = hs.menubar.new():setIcon(iconAscii)

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
                name = 'Monaco'
            }
        })
                 :setStyle({
            font = {
                name = 'AppleGothic'
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
        menu:stateImageSize({ w=80, h=12})
    else
        -- vertical
        suffix = 'Vert'
        menu:stateImageSize({ w=80, h=17})
    end
    local items = {
        { name = 'Left', shortcutKey = '⌃⌥ ←', offStateImage = loadImage('Left'..suffix) },
        { name = 'Right', shortcutKey = '⌃⌥ →', offStateImage = loadImage('Right'..suffix) },
        { name = 'Up', shortcutKey = '⌃⌥ ↑', offStateImage = loadImage('Up'..suffix) },
        { name = 'Down', shortcutKey = '⌃⌥ ↓', offStateImage = loadImage('Down'..suffix)},
        { name = '-' },
        { name = 'Top Left', shortcutKey = '⌃⌥ U  ', offStateImage = loadImage('Top_Left'..suffix)},
        { name = 'Top Right', shortcutKey = '⌃⌥ I  ', offStateImage = loadImage('Top_Right'..suffix)},
        { name = 'Bottom Left', shortcutKey = '⌃⌥ J  ', offStateImage = loadImage('Bottom_Left'..suffix)},
        { name = 'Bottom Right', shortcutKey = '⌃⌥ K  ', offStateImage = loadImage('Bottom_Right'..suffix)},
        { name = '-' },
        { name = 'Left Third', shortcutKey = '⌃⌥ D  ', offStateImage = loadImage('Left1Third'..suffix)},
        { name = 'Left Two Thirds', shortcutKey = '⌃⌥ E  ', offStateImage = loadImage('Left2Thirds'..suffix)},
        { name = 'Center Third', shortcutKey = '⌃⌥ F  ', offStateImage = loadImage('MiddleThird'..suffix)},
        { name = 'Right Two Thirds', shortcutKey = '⌃⌥ T  ', offStateImage = loadImage('Right2Thirds'..suffix)},
        { name = 'Right Third', shortcutKey = '⌃⌥ G  ', offStateImage = loadImage('Right1Third'..suffix)},
        { name = '-' },
        { name = 'Next Display', shortcutKey = '⌃⌥⌘ →', offStateImage = loadImage('Next'..suffix)},
        { name = 'Previous Display', shortcutKey = '⌃⌥⌘ ←', offStateImage = loadImage('Previous'..suffix)},
        { name = '-' },
        { name = 'Maximize', shortcutKey = '⌃⌥ ↩', offStateImage = loadImage('Maximize'..suffix)},
        { name = 'Center', shortcutKey = '⌃⌥ C  ', offStateImage = loadImage('Center'..suffix)},
        { name = 'Restore', shortcutKey = '⌃⌥ ⌫', offStateImage = loadImage('Restore'..suffix)},
    }
    local menuItems = {}
    for i, v in ipairs(items) do
        table.insert(menuItems, {
            title = titleFormat(v.name, v.shortcutKey),
            disabled = true,
            offStateImage = v.offStateImage,
            indent = 1
        })
    end
    return menuItems
end

menu:setMenu(createMenuItems)

return menu
