return {
	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			vim.keymap.set("n", ":", "<cmd>FineCmdline<CR>")
		end,
	},
	{
		"VonHeikemen/searchbox.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			-- vim.keymap.set("n", "/", ":SearchBoxIncSearch<CR>")
			require('searchbox').setup({
		  defaults = {
		    reverse = false,
		    exact = false,
		    prompt = '$ ',
		    modifier = 'disabled',
		    confirm = 'off',
		    clear_matches = false,
		    show_matches = true,
				}
		  })
		end,
	},
}
