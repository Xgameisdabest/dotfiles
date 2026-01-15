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
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
