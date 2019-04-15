-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Dice = {}

function Dice.d6()
  return math.random(1, 6)
end

return Dice