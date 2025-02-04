local o = vim.o
local g = vim.g
local km = vim.keymap

g.mapleader = " "
g.termguicolors = true

o.number = true
o.relativenumber = false
o.autoindent = true
o.ruler = true
o.cursorline = true
o.guifont = "Jetbrainsmono Nerd Font:h10"

km.set("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { noremap = true })
km.set("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { noremap = true })

km.set("n","<TAB>","<Cmd>BufferLineCycleNext<CR>")
km.set("n","<S-TAB>","<Cmd>BufferLineCyclePrev<CR>")

km.set("n", "<C-=>", "<cmd>:GUIFontSizeUp<CR>")
km.set("n", "<C-->", "<cmd>:GUIFontSizeDown<CR>")
km.set("n", "<C-0>", "<cmd>:GUIFontSizeSet<CR>")

km.set("n", "<C-e>", ":Neotree filesystem reveal <CR>", {})

km.set("n", ":", "<cmd>FineCmdline<CR>")

km.set("n", "<leader>/", function()
		require("Comment.api").toggle.linewise.current()
	end, { desc = "comment toggle" }
)

km.set(
	"v",
	"<leader>/",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "comment toggle" }
)

km.set("n", "<leader>gf", vim.lsp.buf.format, {})

km.set("n", "K", vim.lsp.buf.hover, {})
km.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

km.set("n", "<leader>SO", "<cmd>source %<CR>")
km.set("n", "<leader>L", "<cmd>Lazy<CR>")
km.set("n", "<leader>M", "<cmd>Mason<CR>")
