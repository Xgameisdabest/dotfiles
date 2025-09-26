return {
	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{
		"VonHeikemen/searchbox.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			require("searchbox").setup({
				defaults = {
					reverse = false,
					exact = false,
					prompt = "> ",
					modifier = "disabled",
					confirm = "off",
					clear_matches = false,
					show_matches = true,
				},
			})
		end,
	},
}
