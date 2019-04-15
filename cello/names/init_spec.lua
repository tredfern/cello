-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Names module", function()
  local names = require "cello.names"

  describe("metadata", function()
    it("has human names", function()
      assert.not_nil(names.human)
      assert.not_nil(names.human.female)
      assert.not_nil(names.human.male)
    end)
  end)

  it("can generate a female human name", function()
    local n = names.generate("human", "female")
    assert.equals("string", type(n))
  end)
end)