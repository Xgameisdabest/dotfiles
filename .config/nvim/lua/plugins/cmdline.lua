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
			vim.keymap.set("n", "/", ":SearchBoxIncSearch<CR>")
		end,
	},
}
