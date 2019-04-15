-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local character = {}
character.__index = character

function character:new()
  local c = {}
  setmetatable(c, character)
  return c
end

return character