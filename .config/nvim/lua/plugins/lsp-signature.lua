return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		require("lsp_signature").setup({
			bind = true,
			handler_opts = {
				border = "rounded",
			},
			floating_window = true,
			hint_enable = true,
			hint_prefix = "󰏪 ",
			padding = " ",
		})
	end,
}
