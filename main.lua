-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local moonpie = require "moonpie"

function love.update()
  moonpie.update()
end

function love.draw()
  moonpie.paint()
end