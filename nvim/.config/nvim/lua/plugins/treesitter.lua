return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			auto_install = true,
			ensure_installed = { "java", "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "css"},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
