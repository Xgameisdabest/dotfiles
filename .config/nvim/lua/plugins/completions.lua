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

			local colors_dark = {
				blue = "#0a2c4d",
				purple = "#514263",
				cyan = "#345a6a",
				green = "#3a4f38",
				yellow = "#3e382c",
				red = "#4d212c",
				grey = "#26282f",
			}

			local hb = vim.api.nvim_set_hl
			hb(0, "CmpItemKindFunction", { fg = colors.blue, bg = colors_dark.blue })
			hb(0, "CmpItemKindMethod", { fg = colors.blue, bg = colors_dark.blue })
			hb(0, "CmpItemKindVariable", { fg = colors.red, bg = colors_dark.red })
			hb(0, "CmpItemKindKeyword", { fg = colors.purple, bg = colors_dark.purple })
			hb(0, "CmpItemKindText", { fg = colors.green, bg = colors_dark.green })
			hb(0, "CmpItemKindFile", { fg = colors.cyan, bg = colors_dark.cyan })
			hb(0, "CmpItemKindModule", { fg = colors.yellow, bg = colors_dark.yellow })
			hb(0, "CmpItemKindClass", { fg = colors.yellow, bg = colors_dark.yellow })
			hb(0, "CmpItemKindSnippet", { fg = colors.grey, bg = colors_dark.grey })
			hb(0, "CmpItemKindField", { fg = colors.green, bg = colors_dark.green })
			hb(0, "CmpItemKindProperty", { fg = colors.green, bg = colors_dark.green })
			hb(0, "CmpItemKindEnum", { fg = colors.green, bg = colors_dark.green })

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
						-- 1. Get the base formatting from lspkind
						local kind = require("lspkind").cmp_format({
							mode = "symbol_text",
							maxwidth = 50,
						})(entry, vim_item)

						-- 2. Apply nvim-highlight-colors formatting
						-- This specifically looks for color patterns in the entry
						local color_item = require("nvim-highlight-colors").format(entry, { kind = vim_item.abbr })

						-- 3. The "Pill" effect logic for the KIND column
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						-- 4. Integration: If it's a color, customize the ABBR column
						if color_item.abbr_hl_group then
							-- This keeps the hex code/name and adds the color icon
							kind.abbr = color_item.abbr
							kind.abbr_hl_group = color_item.abbr_hl_group
						end

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
					{ name = "luasnip" },
					{ name = "vsnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "treesitter" },
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
