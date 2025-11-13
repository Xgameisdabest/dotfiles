return {

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim", -- mason itself
			"WhoIsSethDaniel/mason-tool-installer.nvim", -- handles formatters/linters
		},
		config = function()
			-- LSP servers
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"lua_ls",
					"pyright",
					"clangd",
					"hyprls",
				},
			})

			-- Formatters & linters
			require("mason-tool-installer").setup({
				ensure_installed = {
					"isort",
					"blue",
					"biome",
					"shfmt",
					"stylua",
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})

			vim.lsp.config("pyright", {
				capabilities = capabilities,
			})

			vim.lsp.config("clangd", {
				capabilities = capabilities,
			})

			vim.lsp.config("bashls", {
				capabilities = capabilities,
			})

			vim.lsp.config("biome", {
				capabilities = capabilities,
			})

			vim.lsp.config("sqls", {
				capabilities = capabilities,
			})

			vim.lsp.config("hyprls", {
				capabilities = capabilities,
			})

			vim.lsp.config("html", {
				capabilities = capabilities,
			})
		end,
	},
}
