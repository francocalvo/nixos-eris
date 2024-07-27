local M = {
  "karb94/neoscroll.nvim",
}

function M.config()
  vim.cmd [[
  nnoremap <C-j> <C-D>
  vnoremap <C-j> <C-D>

  nnoremap <C-k> <C-U>
  vnoremap <C-k> <C-U>
]]

  require("neoscroll").setup {
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    hide_cursor = true, -- Hide cursor while scrolling
    stop_eof = true, -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil, -- Default easing function
    pre_hook = nil, -- Function to run before the scrolling animation starts
    post_hook = nil, -- Function to run after the scrolling animation ends
    performance_mode = false, -- Disable "Performance Mode" on all buffers.
  }

  local neoscroll = require "neoscroll"
  local keymap = {
    ["<C-u>"] = function()
      neoscroll.ctrl_u { duration = 250 }
    end,
    ["<C-d>"] = function()
      neoscroll.ctrl_d { duration = 250 }
    end,
    ["<C-b>"] = function()
      neoscroll.ctrl_b { duration = 450 }
    end,
    ["<C-f>"] = function()
      neoscroll.ctrl_f { duration = 450 }
    end,
    ["<C-y>"] = function()
      neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
    end,
    ["<C-e>"] = function()
      neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
    end,
    ["zt"] = function()
      neoscroll.zt { half_win_duration = 250 }
    end,
    ["zz"] = function()
      neoscroll.zz { half_win_duration = 250 }
    end,
    ["zb"] = function()
      neoscroll.zb { half_win_duration = 250 }
    end,
  }
  local modes = { "n", "v", "x" }
  for key, func in pairs(keymap) do
    vim.keymap.set(modes, key, func)
  end

  --
  -- local t = {}
  -- -- Syntax: t[keys] = {function, {function arguments}}
  -- t["<C-u>"] = { "ctrl_u", { "250" } }
  -- t["<C-d>"] = { "ctrl_d", { "250" } }
  -- t["<C-b>"] = { "ctrl_b", { "450" } }
  -- t["<C-f>"] = { "ctrl_f", { "450" } }
  -- t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
  -- t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
  -- t["zt"] = { "zt", { "250" } }
  -- t["zz"] = { "zz", { "250" } }
  -- t["zb"] = { "zb", { "250" } }
  --
  -- require("neoscroll.config").set_mappings(t)
end

return M
