-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local utility = require "cello.utility"

local names = {
  human = require "cello.names.human"

}

function names.generate(race, gender)
  return utility.choose(names[race][gender])
end

return names