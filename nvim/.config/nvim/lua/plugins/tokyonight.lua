return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1300,
  opts = {},
  config = function()
    require("tokyonight").setup({
      style = "night",
      on_colors = function(colors)
        colors.bg = "NONE"
        colors.bg_float = "NONE"
        colors.fg_gutter = "#FFFFFF"
        colors.fg_float = "#FFFFFF"
      end,
      on_highlights = function(highlights, colors)
        highlights.CursorLineNr = { fg = colors.yellow, bold = true }
      end,
    })
    vim.cmd([[colorscheme tokyonight]])
  end,
}
