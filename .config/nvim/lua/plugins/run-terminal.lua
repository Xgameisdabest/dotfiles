return {
  'akinsho/toggleterm.nvim',
	config = function()
		require("toggleterm").setup{}
		vim.api.nvim_set_keymap("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { noremap = true })
		vim.api.nvim_set_keymap("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { noremap = true })
	end
}
