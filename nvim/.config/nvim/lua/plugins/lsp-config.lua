return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"html",
					"lwc_ls",
					"jdtls",
					"ts_ls",
					"bashls",
					"angularls",
					"cssls",
					"emmet_ls",
					"lemminx",
          "jsonls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.lwc_ls.setup({
				capabilities = capabilities,
			})
			-- lspconfig.jdtls.setup({
			-- 	capabilities = capabilities,
			-- })
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.angularls.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.lemminx.setup({
				capabilities = capabilities,
			})
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })
			local lombok_path = vim.fn.expand("~/.local/share/lombok/lombok.jar")
			lspconfig.jdtls.setup({
				cmd = {
					"jdtls",
					"--jvm-arg=-javaagent:" .. lombok_path, -- ✅ Enables Lombok support
				},
				capabilities = capabilities,
			})
			vim.keymap.set("n", "I", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
		end,
	},
}
