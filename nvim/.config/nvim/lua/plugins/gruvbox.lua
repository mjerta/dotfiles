return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1100,
		config = function()
			require("gruvbox").setup({
        transparent_mode = true,
			})
			vim.cmd.colorscheme("gruvbox")
		end,
	},
}
