local base_path = ""
if vim.fn.has("win32") == 1 then
  base_path = "D:/notes"
else
  base_path = vim.fn.expand("~/notes")
end

local personal_path = vim.fn.simplify(base_path .. "/personal-notes")
local work_path = vim.fn.simplify(base_path .. "/work-notes")

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  -- Add nvim-cmp to dependencies so it's available
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    -- Optional but highly recommended for search and picker support
    "nvim-telescope/telescope.nvim",
    -- For improved markdown highlighting, consider:
    -- "nvim-treesitter/nvim-treesitter",
  },
  opts = {

    disable_frontmatter = true,
    workspaces = {
      { name = "personal", path = personal_path },
      { name = "work", path = work_path },
    },
    completion = {
      -- Change this to false IF you don't actually use nvim-cmp
      -- If you DO use nvim-cmp, keep it true.
      nvim_cmp = true,
      min_chars = 2,
    },
    attachments = {
      img_folder = "attachments",
    },
    -- way then set 'mappings = {}'.
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>rr"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
  },
}
