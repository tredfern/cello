-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local name = {}
name.__tostring = function(t)
  return t.first .. " " .. t.family
end

function name:new(opt)
  local n = opt or {}
  n.first = n.first or ""
  n.family = n.family or ""
  setmetatable(n, name)
  return n
end

return name