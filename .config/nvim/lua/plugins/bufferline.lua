return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.api.nvim_set_hl(0, "BufferLineOffsetLabel", {
			fg = "#ECBE7B",
			bold = true,
		})

		local indicator_color = "#ff6f91"
		local groups = {
			"tab_separator_selected",
			"close_button_selected",
			"buffer_selected",
			"numbers_selected",
			"diagnostic_selected",
			"hint_selected",
			"hint_diagnostic_selected",
			"info_diagnostic_selected",
			"warning_diagnostic_selected",
			"error_diagnostic_selected",
			"modified_selected",
			"duplicate_selected",
			"indicator_selected",
			"pick_selected",
			"modified_selected",
		}

		local highlights = {}
		for _, group in ipairs(groups) do
			highlights[group] = {
				sp = indicator_color,
				underline = true,
			}
		end

		highlights.buffer_selected.bold = true
		highlights.fill = { bg = "none" }

		require("bufferline").setup({
			options = {
				separator_style = { " ", " " }, -- Completely removes separators
				indicator = {
					style = "underline",
				},
				offsets = {
					{
						filetype = "neo-tree",
						text = "  File Explorer",
						text_align = "center",
						separator = true,
						highlight = "BufferLineOffsetLabel",
					},
				},
				hover = {
					enabled = true,
					delay = 5,
					reveal = { "close" },
				},
			},
			highlights = highlights,
		})
	end,
}
