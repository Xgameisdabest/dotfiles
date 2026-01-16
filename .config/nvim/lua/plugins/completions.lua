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
		dependencies = {
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")

			local colors = {
				blue = "#81ccee",
				purple = "#cba6f7",
				cyan = "#89dceb",
				green = "#a6e3a1",
				yellow = "#f9e2af",
				red = "#f38ba8",
				grey = "#45475a",
			}

			local hb = vim.api.nvim_set_hl
			hb(0, "CmpItemKindFunction", { fg = "#1e1e2e", bg = colors.blue })
			hb(0, "CmpItemKindMethod", { fg = "#1e1e2e", bg = colors.blue })
			hb(0, "CmpItemKindVariable", { fg = "#1e1e2e", bg = colors.red })
			hb(0, "CmpItemKindKeyword", { fg = "#1e1e2e", bg = colors.purple })
			hb(0, "CmpItemKindText", { fg = "#1e1e2e", bg = colors.green })
			hb(0, "CmpItemKindFile", { fg = "#1e1e2e", bg = colors.cyan })
			hb(0, "CmpItemKindModule", { fg = "#1e1e2e", bg = colors.yellow })
			hb(0, "CmpItemKindSnippet", { fg = "#1e1e2e", bg = colors.grey })
			hb(0, "CmpItemKindField", { fg = "#1e1e2e", bg = colors.green })

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				-- 1. NvChad Window Styling
				window = {
					completion = {
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
						zindex = 1001,
						scrolloff = 0,
						col_offset = -3, -- Moves the menu slightly left for that specific NvChad look
						side_padding = 0,
					},
					documentation = {
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
					},
				},
				-- 2. NvChad Item Formatting
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({
							mode = "symbol_text",
							maxwidth = 50,
						})(entry, vim_item)

						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						-- This part creates the "Pill" effect
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						return kind
					end,
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
				}),
			})

			-- Cmdline setup remains mostly the same
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
