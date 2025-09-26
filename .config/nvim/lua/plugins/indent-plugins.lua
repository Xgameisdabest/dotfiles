return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			local highlight = {
				-- "RainbowRed",
				-- "RainbowYellow",
				-- "RainbowCyan",
				-- "RainbowOrange",
				-- "RainbowGreen",
				-- "RainbowViolet",
				-- "RainbowBlue",
				"Grey",
			}
			
			local delimiters_hightlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowCyan",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowBlue",
			}

			local hooks = require "ibl.hooks"
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#f38ba8" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f9e2af" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#81ccee" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#fab387" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a6e3a1" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#cba6f7" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#89dceb" })
				vim.api.nvim_set_hl(0, "Grey", { fg = "#45475a" })
			end)

			vim.g.rainbow_delimiters = { highlight = delimiters_hightlight }
			require("ibl").setup { scope = { highlight = delimiters_hightlight }, indent = { highlight = highlight } }

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end
	},
}
