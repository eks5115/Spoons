
local json = require('hs.json')
local util = dofile(hs.spoons.resourcePath('util.lua'))

local storage = {}

storage.path = hs.configdir..'/Spoons/WindowMagnet.spoon/config.json'

function storage:write(data)
    local configData = self:read()
    if (configData == nil) then
        configData = {}
    end
    return json.write(util:merge(configData, data), self.path, true, true)
end

function storage:read()
    return json.read(self.path)
end

return storage
