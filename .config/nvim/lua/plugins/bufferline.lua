return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.opt.termguicolors = true
		vim.api.nvim_set_hl(0, "BufferLineOffsetLabel", {
			fg = "#ECBE7B",
			bold = true,
		})
		require("bufferline").setup({
			options = {
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
						highlight = "BufferLineOffsetLabel",
					},
				},
			},
		})
	end,
}
