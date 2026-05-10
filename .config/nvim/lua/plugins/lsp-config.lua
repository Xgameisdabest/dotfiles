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
			local servers = require("mason-lspconfig").get_installed_servers()

			for _, server in ipairs(servers) do
				local config = {
					capabilities = capabilities,
				}

				-- Hyprland Lua LSP Support (Only works in the hyprland configuration directory)
				if server == "lua_ls" then
					config.on_init = function(client)
						if client.workspace_folders and client.workspace_folders[1].name:match(".config/hypr") then
							client.config.settings.Lua =
								vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
									workspace = { library = { "/usr/share/hypr/stubs" } },
									diagnostics = { globals = { "hl" } },
								})
							client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
						end
						return true
					end
					config.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
				end

				-- Inject Zsh support if the server is bashls
				if server == "bashls" then
					config.filetypes = { "sh", "bash", "zsh" }
					config.settings = {
						bashIde = {
							globPattern = "**/*@(.sh|.inc|.bash|.command|.zsh)",
						},
					}
				end

				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end,
	},
}
