return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- show filtered items
        show_hidden_count = true,
        hide_dotfiles = false, -- show dotfiles
        hide_gitignored = false, -- show .git folder
        hide_by_name = {}, -- optional files to hide
        never_show = {}, -- don't automatically hide anything
      },
    },
  },
}
