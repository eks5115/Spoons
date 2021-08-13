
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
                name = 'SimSong'
            }
        }, 0 - #shortcutKey)
    end
end

local function createMenuItems ()
    local items = {
        { name = 'Left', shortcutKey = '⌃⌥ ←', offStateImage = loadImage('Left') },
        { name = 'Right', shortcutKey = '⌃⌥ →', offStateImage = loadImage('Right') },
        { name = 'Up', shortcutKey = '⌃⌥ ↑', offStateImage = loadImage('Up') },
        { name = 'Down', shortcutKey = '⌃⌥ ↓', offStateImage = loadImage('Down')},
        { name = '-' },
        { name = 'Top Left', shortcutKey = '⌃⌥ U  ', offStateImage = loadImage('Top_Left')},
        { name = 'Top Right', shortcutKey = '⌃⌥ I  ', offStateImage = loadImage('Top_Right')},
        { name = 'Bottom Left', shortcutKey = '⌃⌥ J  ', offStateImage = loadImage('Bottom_Left')},
        { name = 'Bottom Right', shortcutKey = '⌃⌥ K  ', offStateImage = loadImage('Bottom_Right')},
        { name = '-' },
        { name = 'Next Display', shortcutKey = '⌃⌥⌘ →', offStateImage = loadImage('Next')},
        { name = 'Previous Display', shortcutKey = '⌃⌥⌘ ←', offStateImage = loadImage('Previous')},
        { name = '-' },
        { name = 'Maximize', shortcutKey = '⌃⌥ ↩', offStateImage = loadImage('Maximize')},
        { name = 'Center', shortcutKey = '⌃⌥ C  ', offStateImage = loadImage('Center')},
        { name = 'Restore', shortcutKey = '⌃⌥ ⌦', offStateImage = loadImage('Restore')},
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

local menu = hs.menubar.new():setIcon(iconAscii)
menu:stateImageSize({ w=80, h=10})
menu:setMenu(createMenuItems())

return menu
