-- nvim-tree configs
local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")

local function collapse_all()
  require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function expand_all()
  require("nvim-tree.actions.tree-modifiers.expand-all").fn()
end

local function edit_or_open()
  -- open as vsplit on current node
  local action = "edit"
  local node = lib.get_node_at_cursor()

  if node == nil then
    return
  end

  -- Just copy what's done normally with vsplit
  if node.link_to and not node.nodes then
    require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
    view.close() -- Close the tree if file was opened

  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)

  else
    require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
    view.close() -- Close the tree if file was opened
  end
end

require('nvim-tree').setup({
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = "l", action = "edit", action_cb = edit_or_open },
        { key = "L", action = "expand_all", action_cb = expand_all },
        { key = "h", action = "close_node" },
        { key = "H", action = "collapse_all", action_cb = collapse_all }
      }
    },
    width = 45
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = true,
  sort_by = 'extension',
})

