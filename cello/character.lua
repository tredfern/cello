-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local character = {}
character.__index = character
character.__tostring = function(t)
  return string.format([[
-Character-
Name: %s
]], t.name)
end

function character:new(c)
  c = c or {}
  setmetatable(c, character)
  return c
end

return character