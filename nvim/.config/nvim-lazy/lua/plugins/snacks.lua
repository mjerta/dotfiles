-- lua/plugins/snacks.lua
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        files = { cmd = "fd" },
        grep = { cmd = "rg" },
      },
      dashboard = { enabled = true },
      lazygit = { enabled = true },
      image = { enabled = true },
    },
  },
}
