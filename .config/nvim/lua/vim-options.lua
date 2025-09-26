-- general configs and keybinds

-- variables
local o = vim.o
local g = vim.g
local km = vim.keymap

-- general config
g.mapleader = " "
g.termguicolors = true

o.number = true
o.relativenumber = false
o.autoindent = true
o.ruler = true
o.cursorline = true
o.guifont = "Jetbrainsmono Nerd Font:h10"

g.goyo_width = 120

-- keybinds
km.set("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { noremap = true })
km.set("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { noremap = true })

km.set("n", "<leader>[", "<cmd>FineCmdline split <CR>")
km.set("n", "<leader>]", "<cmd>FineCmdline vsplit <CR>")
km.set("n", "<leader><bs>", ":q<CR>")

km.set("n", "<TAB>", "<Cmd>BufferLineCycleNext<CR>")
km.set("n", "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>")

km.set("n", "<C-u>","<Cmd>UndotreeToggle<CR>")

km.set("n", "<C-=>", "<cmd>:GUIFontSizeUp<CR>")
km.set("n", "<C-->", "<cmd>:GUIFontSizeDown<CR>")
km.set("n", "<C-0>", "<cmd>:GUIFontSizeSet<CR>")

km.set("n", "<C-e>", "<cmd>Neotree toggle<CR>")

km.set("n", ":", "<cmd>FineCmdline<CR>")
km.set("n", "/", ":SearchBoxMatchAll<CR>")

km.set("n", "<leader>db", ":DBUIToggle<CR>")

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
km.set("n", "<leader>ts", "<cmd> FineCmdline TSInstall <CR>")

km.set("n", "<leader><Tab>", "<cmd>Telescope buffers<CR>")
km.set("n", "<leader>F", "<cmd>Telescope find_files<CR>")
km.set("n", "<leader>H", "<cmd>Telescope command_history<CR>")
km.set("n", "<leader>?", "<cmd>Telescope keymaps<CR>")

-- Arrow keys
km.set("n", "<Up>", ":")
km.set("n", "<Down>", "/")
km.set("n", "<Left>", "<cmd>Neotree toggle<CR>")
km.set("n", "<Right>", "<cmd>UndotreeToggle<cr>")

-- Visual Mode
km.set('v', 'w', 'k', { noremap = true, silent = true })
km.set('v', 's', 'j', { noremap = true, silent = true })
km.set('v', 'a', 'h', { noremap = true, silent = true })
km.set('v', 'd', 'l', { noremap = true, silent = true })

-- Insert Mode
km.set('n', 'w', 'k', { noremap = true, silent = true })
km.set('n', 's', 'j', { noremap = true, silent = true })
km.set('n', 'a', 'h', { noremap = true, silent = true })
km.set('n', 'd', 'l', { noremap = true, silent = true })

-- Normal mode
km.set("n", "q", "0", { noremap = true, silent = true })  -- e = Home (line start)
km.set("n", "e", "$", { noremap = true, silent = true })  -- q = End (line end)

-- Visual mode
km.set("v", "q", "0", { noremap = true, silent = true })
km.set("v", "e", "$", { noremap = true, silent = true })

-- Restore original 'a' (append) on key 'h'
km.set("n", "h", "a")
km.set("n", "i", "a")
-- (jump forward a word) on key 'j'
km.set("n", "j", "w")
-- (substitute char) on key 'k'
km.set("n", "k", "s")
-- (delete) on key 'l'
km.set("n", "l", "d")
km.set("n", "ll", "dd")
