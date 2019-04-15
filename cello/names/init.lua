-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local utility = require "cello.utility"
local name = require "cello.names.name"

local names = {
  human = require "cello.names.human"
}

function names.generate(race, gender)
  return name:new({
    first = utility.choose(names[race][gender]),
    family = utility.choose(names[race].family)
  })
end

return names