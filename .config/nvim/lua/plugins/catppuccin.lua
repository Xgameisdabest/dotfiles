return {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			show_end_of_buffer = true,
			transparent_background = true,
			float = {
				transparent = true, -- enable transparent floating windows
				solid = false, -- use solid styling for floating windows, see |winborder|
			},
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				-- Styles (from :h highlight-args): bold underline undercurl underdouble underdotted underdashed inverse italic standout strikethrough altfont nocombine
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "bold", "italic", "underline" },
				loops = { "bold", "underline" },
				functions = { "bold", "underdashed" },
				keywords = {},
				strings = {},
				variables = { "underdotted", "italic" },
				numbers = {},
				booleans = { "underline", "italic" },
				properties = {},
				types = {},
				operators = {},
			},
			lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
					ok = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
					ok = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
