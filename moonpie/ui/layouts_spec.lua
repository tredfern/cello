-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Layouts", function()
  local layouts = require "moonpie.ui.layouts"
  local Node = require "moonpie.ui.node"
  local mock_love = require "moonpie.test_helpers.mock_love"

  local parent
  before_each(function()
    parent = Node({ width = 152, layout = layouts.standard })
    parent:layout()
  end)

  describe("standard layout", function()
    it("uses it's parent width to determine it's maximum and defaults to full width", function()
      local test = Node({ layout = layouts.standard }, parent)
      test:layout()
      assert.equals(152, test.box.content.width)
    end)

    it("can use a percentage of the width of the parent if provided", function()
      local test = Node({ layout = layouts.standard, width = "50%" }, parent)
      test:layout()
      assert.equals(76, test.box.content.width)
    end)

    it("uses it's own width if provided on the node", function()
      local test = Node({  layout = layouts.standard,  width = 120 })
      test:layout(parent)
      assert.equals(120, test.box.content.width)
    end)

    it("uses the width of its children if display is 'inline'", function()
      local b = Node({ layout = layouts.standard, display = "inline" })
      local c1 = Node({ layout = layouts.standard, width = 30 })
      local c2 = Node({ layout = layouts.standard, width = 34 })
      b:add(c1, c2)

      b:layout(parent)
      assert.equals(64, b.box.content.width)
    end)

    it("shaves off the margin from the width", function()
      local b = Node({ layout = layouts.standard, margin = 12 })
      b:layout(parent)
      assert.equals(128, b.box.content.width)
    end)

    it("shaves off the padding from the content width", function()
      local b = Node({ layout = layouts.standard, padding = 6 })
      b:layout(parent)
      assert.equals(140, b.box.content.width)
    end)

    it("shaves off the border from the content width", function()
      local b = Node({ border = 2 })
      b:layout(parent)
      assert.equals(148, b.box.content.width)
    end)

    it("uses its height if provided on the node", function()
      local b = Node({ height = 493 })
      b:layout(parent)
      assert.equals(493, b.box.content.height)
    end)

    it("can expand to parent's height if specified", function()
      local p = Node({ height = 150, width = 10 })
      local b = Node({ height = "100%" })
      p:add(b)
      p:layout()
      assert.equals(150, b.box:height())
    end)

    it("updates the layouts of its children with itself as parent", function()
      local child_layout = spy.new(function() end)
      local b = Node({ layout = child_layout, width = 39, height = 39 })
      parent:add(b)
      parent:layout()
      assert.spy(child_layout).was.called()
      assert.spy(child_layout).was.called_with(b, parent)
    end)

    it("keeps the same layout if called multiple times in a row", function()
      local b = Node({ layout = layouts.standard, width = 1, margin = 1, padding = 1, border = 1 })
      local c = Node({layout = layouts.standard, width = 1, height = 1, margin = 1, padding = 1, border = 1 })
      b:add(c)
      b:layout()
      assert.equals(0, b.box.x)
      assert.equals(0, b.box.y)
      assert.equals(0, c.box.x)
      assert.equals(0, c.box.y)
      assert.equals(13, b.box:height())
      assert.equals(7, c.box:height())
      b:layout()
      assert.equals(0, b.box.x)
      assert.equals(0, b.box.y)
      assert.equals(0, c.box.x)
      assert.equals(0, c.box.y)
      assert.equals(13, b.box:height())
      assert.equals(7, c.box:height())
    end)

    describe("Horizontal layout", function()
      it("assigns the position of components after calculating the width of them", function()
        local b = Node()
        local c1 = Node({width = 10 })
        local c2 = Node({width = 20 })
        local c3 = Node({width = 49 })
        b:add(c1, c2, c3)
        b:layout(parent)
        assert.equals(0, c1.box.x)
        assert.equals(0, c1.box.y)
        assert.equals(10, c2.box.x)
        assert.equals(0, c2.box.y)
        assert.equals(30, c3.box.x)
        assert.equals(0, c3.box.y)
      end)

      describe("Wrapping", function()
        local node = Node()
        local big_child = Node({ width = 500, height = 39})
        local little_child = Node({ width = 43, height = 32})
        node:add(big_child, little_child)
        node:layout(parent)

        it("puts a node onto another line if the next node cannot fit onto the line", function()
          assert.equals(0, big_child.box.x)
          assert.equals(0, big_child.box.y)
          assert.equals(0, little_child.box.x)
          assert.equals(39, little_child.box.y)
        end)

        it("calculates it's own height to be the size of all the lines", function()
          assert.equals(71, node.box.content.height)
        end)
      end)

      describe("Margins", function()
        local node = Node({ display = "inline", margin = 5 })
        local child = Node({ margin = 2, width = 10, height = 10 })
        node:add(child)
        node:layout(parent)

        it("starts the content based on the margin", function()
          local x, y = node.box:content_position()
          assert.equals(5, x)
          assert.equals(5, y)
        end)

        it("content area includes the margins of the child", function()
          assert.equals(14, node.box.content.width)
          assert.equals(14, node.box.content.height)
        end)

        it("uses the margins for the total size", function()
          assert.equals(14, child.box:height())
          assert.equals(14, child.box:width())
          assert.equals(24, node.box:height())
          assert.equals(24, node.box:width())
        end)
      end)
    end)
  end)

  describe("Positioning Children", function()
    it("can align children to the right", function()
      local b = Node()
      local c1 = Node({ width = 10, align = "right" })
      b:add(c1)
      b:layout(parent)
      assert.equals(parent.width - 10, c1.box.x)
    end)

    it("can middle align children", function()
      local b = Node()
      local c1 = Node({ width = 10, height = 10})
      local c2 = Node({ width = 10, height = 6, vertical_align = "middle" })
      b:add(c1, c2)
      b:layout(parent)
      assert.equals(2, c2.box.y)
    end)

  end)

  describe("Text Layouts", function()
    it("creates an image of the text", function()
      local node = Node({ text = "Foo", font = mock_love.font })
      layouts.text(node, parent)
      assert.not_nil(node.image)
    end)

    it("handles when text is by treating it as empty string", function()
      -- override love.graphics.newText to return this specific object
      local text_object = love.graphics.newText()
      text_object.setf = spy.new(function() end)
      mock_love.mock(love.graphics, "newText", function() return text_object end)

      local node = Node({ text = nil, font = mock_love.font })
      layouts.text(node, parent)
      assert.spy(text_object.setf).was.called()
      assert.spy(text_object.setf).was.called.with(text_object, "", parent.box.content.width, "left")
    end)
  end)

  describe("Image layouts", function()
    it("calculates it's layout width and height based on the size of the image", function()
      local img_node = Node({ image = mock_love.image, layout = layouts.image })
      img_node:layout(parent)
      assert.equals(100, img_node.box.content.width)
      assert.equals(100, img_node.box.content.height)
    end)

    it("does uses the specified width or height instead of image if specified", function()
      local img_node = Node({ image = mock_love.image, layout = layouts.image, width = 200, height = 250 })
      img_node:layout(parent)
      assert.equals(200, img_node.box.content.width)
      assert.equals(250, img_node.box.content.height)
    end)
  end)

  describe("Tricky Bugs", function()
    it("uses percentage width if display is set to inline properly", function()
      local n = Node({ display = "inline", width = "50%" })
      layouts.standard(n, parent)
      assert.equals(76, n.box:width())
    end)
  end)

  describe("Position Elements", function()
    it("can position elements to absolute coordinates", function()
      local n = Node({ position = "absolute", x = 10, y = 10, width = 100, height = 100 })
      parent:add(n)
      layouts.standard(parent)
      assert.equals(10, n.box.x)
      assert.equals(10, n.box.y)
      assert.equals(100, n.box.content.width)
      assert.equals(100, n.box.content.height)
    end)

    it("will default to 0, 0 if no x, y set on absolute position", function()
      local n = Node({ position = "absolute", width = 100, height = 100 })
      parent:add(n)
      layouts.standard(parent)
      assert.equals(0, n.box.x)
      assert.equals(0, n.box.y)
    end)
  end)

  it("can layout vertically and display inline", function()
    local n = Node({ display = "inline", child_orientation = "vertical" })
    local c1 = Node({ width = 100, height = 10 })
    local c2 = Node({ width = 120, height = 12 })
    n:add(c1, c2)
    parent:add(n)
    parent:layout()
    assert.equals(0, c1.box.x)
    assert.equals(0, c2.box.x)
    assert.equals(0, c1.box.y)
    assert.equals(10, c2.box.y)
    assert.equals(120, n.box:width())
    assert.equals(22, n.box:height())
  end)

  it("sets the last child of each row to take up any remaining space", function()
    local b = Node({ display = "inline", child_orientation = "vertical" })
    local c1 = Node({ width = 120, height = 2 })
    local c2 = Node({ width = 140, height = 3 })
    b:add(c1, c2)
    parent:add(b)
    parent:layout()
    assert.equals(140, c1.box:width())
    assert.equals(140, c2.box:width())
    assert.equals(140, b.box:width())
  end)

  it("uses a default width of the screen width for max width if the parent is null and width is empty", function()
    local w = love.graphics.getWidth()
    local n = Node({})
    n.parent = nil
    n:layout()
    assert.equals(w, n.box.content.width)
  end)
end)
