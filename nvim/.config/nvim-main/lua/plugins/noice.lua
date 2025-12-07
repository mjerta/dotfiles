return {
  -- Add nvim-notify as a separate plugin
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#1e1e2e", -- Match your theme background
    },
  },

  -- Configure Noice separately
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      notify = {
        enabled = true, -- Ensure Noice integrates with nvim-notify
      },
      -- Ensures that the annoying lsp messages dont appear see: https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages#lsp-messages
      lsp = { progress = { enabled = false }}
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
}
