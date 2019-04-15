-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Dice", function()
  local Dice = require "cello.dice"

  describe("basic dice types", function()
    it("d6", function()
      local r = Dice.d6()
      assert.is_true(r >= 1 and r <= 6)
      assert.is_nil(string.find(tostring(r), "%."))
    end)
  end)
end)