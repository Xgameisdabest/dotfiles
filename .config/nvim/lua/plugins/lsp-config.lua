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
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"lua_ls",
					"pyright",
					"clangd",
					"hyprls",
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"isort",
					"blue",
					"biome",
					"shfmt",
					"stylua",
					"clang-format",
					"markdownlint",
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Get the list of installed servers
			local servers = require("mason-lspconfig").get_installed_servers()

			for _, server in ipairs(servers) do
				vim.lsp.config(server, {
					capabilities = capabilities,
				})

				vim.lsp.enable(server)
			end
		end,
	},
}
