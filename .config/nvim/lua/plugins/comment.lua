return {
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = function(ctx)
					-- Only calculation if the filetype is zsh
					if vim.bo.filetype == "zsh" then
						return "# %s"
					end
				end,
			})
		end,
	},
}
