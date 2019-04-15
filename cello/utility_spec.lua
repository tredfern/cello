-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("utility", function()
  local utility = require "cello.utility"

  it("can pick random elements out of a table", function()
    local t = { 1, 2, 3, 4 }
    for _=1,100 do
      local n = utility.choose(t)
      assert.is_true(n >= 1 and n <= 4)
    end
  end)
end)