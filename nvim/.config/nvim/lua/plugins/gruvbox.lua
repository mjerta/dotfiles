return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1100,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
      vim.cmd.colorscheme("gruvbox")
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffffff" }) -- Set the color for line numbers
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffff00", bold = true })
    end,
  },
}
