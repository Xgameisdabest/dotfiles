return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	opts = {},
	config = function(_, opts)
		require("lsp_signature").setup({
			-- Customizing it to match your NvChad aesthetic
			bind = true,
			handler_opts = {
				border = "rounded", -- Matches your cmp border style
			},
			floating_window = true, -- show hint in a floating window
			hint_enable = true, -- show hint in virtual text (behind the cursor)
			hint_prefix = "󰏪 ", -- A nice icon for the virtual text
			padding = " ", -- character to pad on left and right of signature
		})
	end,
}
