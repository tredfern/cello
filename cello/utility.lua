-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local utility = {}

function utility.choose(t)
  local i = math.random(1, #t)
  return t[i]
end

return utility