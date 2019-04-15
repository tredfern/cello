-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Name", function()
  local name = require "cello.names.name"

  it("initializes the required names to empty string", function()
    local n = name:new()
    assert.equals("", n.first)
    assert.equals("", n.family)
  end)

  it("can pretty print the name", function()
    local n = name:new({ first = "Foo", family = "Bar"})
    assert.equals("Foo Bar", tostring(n))
  end)
end)