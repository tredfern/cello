-- Copyright (c) 2019 Trevor Redfern
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

function love.conf(t)
  t.window.title = "Cello RPG"
  t.window.height = 600
  t.window.width = 800
  t.window.vsync = 1
  t.window.fullscreen = false
  
  package.path = package.path .. ";./ext/?.lua;./ext/?/init.lua"
end