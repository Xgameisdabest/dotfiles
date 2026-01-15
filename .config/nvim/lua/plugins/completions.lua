return {
	{
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"echasnovski/mini.snippets",
		"abeldekat/cmp-mini-snippets",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			-- border style: bold, double, none, rounded, shadow, single, solid
			local window_border_style = "rounded"

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered({ border = window_border_style }),
					documentation = cmp.config.window.bordered({ border = window_border_style }),
				},
				mapping = cmp.mapping.preset.insert({
					["<Up>"] = cmp.config.disable,
					["<Down>"] = cmp.config.disable,
					["<Left>"] = cmp.config.disable,
					["<Right>"] = cmp.config.disable,
					["<S-Up>"] = cmp.mapping.scroll_docs(2),
					["<S-Down>"] = cmp.mapping.scroll_docs(-2),
					["<S-TAB>"] = cmp.mapping.select_prev_item(),
					["<TAB>"] = cmp.mapping.select_next_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "treesitter" },
					{ name = "luasnip" },
					{ name = "ultisnips" },
					{ name = "snippy" },
					{ name = "cmdline" }
				}),
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
