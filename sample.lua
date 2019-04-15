-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local names = require "cello.names.init"

for _ = 1, 100 do
  print(names.generate("human", "male"))
end

for _ = 1, 100 do
  print(names.generate("human", "female"))
end
