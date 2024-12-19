local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.api.nvim_set_option("clipboard", "unnamedplus")
require("vim-options")
require("lazy").setup("plugins")
-- require("notify")("Hello User!")

-- -- Visual Mode
-- vim.api.nvim_set_keymap('v', 'w', 'k', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', 's', 'j', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', 'a', 'h', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', 'd', 'l', { noremap = true, silent = true })
--
-- -- Insert Mode
-- vim.api.nvim_set_keymap('n', 'w', 'k', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 's', 'j', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'a', 'h', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'd', 'l', { noremap = true, silent = true })
