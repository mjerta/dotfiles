-- ~/.config/nvim/lua/plugins/harpoon.lua
return {
  {
    "ThePrimeagen/harpoon",
    lazy = false, -- load immediately
    config = function()
      local harpoon = require("harpoon")
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      -- Basic setup (optional, uses defaults)
      harpoon.setup({
        menu = {
          width = vim.api.nvim_win_get_width(0) - 10,
        },
      })

      -- Keymaps
      local opts = { noremap = true, silent = true }

      -- Add current file to harpoon marks
      vim.keymap.set("n", "<leader>a", mark.add_file, opts)

      -- Toggle the harpoon quick menu
      vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, opts)

      -- Jump to harpoon files directly
      vim.keymap.set("n", "<leader>1", function()
        ui.nav_file(1)
      end, opts)
      vim.keymap.set("n", "<leader>2", function()
        ui.nav_file(2)
      end, opts)
      vim.keymap.set("n", "<leader>3", function()
        ui.nav_file(3)
      end, opts)
      vim.keymap.set("n", "<leader>4", function()
        ui.nav_file(4)
      end, opts)
      vim.keymap.set("n", "<leader>5", function()
        ui.nav_file(5)
      end, opts)
      vim.keymap.set("n", "<leader>6", function()
        ui.nav_file(6)
      end, opts)
      vim.keymap.set("n", "<leader>7", function()
        ui.nav_file(7)
      end, opts)
      vim.keymap.set("n", "<leader>8", function()
        ui.nav_file(8)
      end, opts)
      vim.keymap.set("n", "<leader>9", function()
        ui.nav_file(9)
      end, opts)
    end,
  },
}
