return {
  -- Gruvbox with transparency enabled
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true, -- <-- enable transparency
    },
  },

  -- Configure LazyVim to use gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
