-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Character", function()
  local Character = require "cello.character"

  it("can create a new character", function()
    local c = Character:new()
    assert.not_nil(c)
  end)

end)