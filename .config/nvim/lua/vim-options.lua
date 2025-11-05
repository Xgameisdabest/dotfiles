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
o.ruler = true
o.cursorline = true
o.guifont = "Jetbrainsmono Nerd Font:h10"

g.goyo_width = 120

-- keybinds
km.set("n", "<C-Space>", "<Esc>", { noremap = true, silent = true })
km.set("i", "<C-Space>", "<Esc>", { noremap = true, silent = true })
km.set("v", "<C-Space>", "<Esc>", { noremap = true, silent = true })

km.set("n", "<leader>SO", "<cmd>source %<CR>")
km.set("n", "<leader>l", "<cmd>Lazy<CR>")
km.set("n", "<leader>m", "<cmd>Mason<CR>")
km.set("n", "<leader>ts", "<cmd> FineCmdline TSInstall <CR>")
km.set("n", "<leader>s", "<cmd>Store<CR>")

km.set("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { noremap = true })
km.set("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { noremap = true })

km.set("n", "<leader>[", "<cmd>FineCmdline split <CR>")
km.set("n", "<leader>]", "<cmd>FineCmdline vsplit <CR>")
km.set("n", "<leader>{", ":split #<CR>")
km.set("n", "<leader>}", ":vsplit #<CR>")

km.set("n", "<leader><bs>", "<cmd>:q<CR>")
km.set("n", "Q", "<cmd>:wq<CR>")
km.set("n", "qq", "<cmd>:q<CR>")
km.set("n", "ee", "<cmd>:w<CR>")

km.set("n", "<TAB>", "<Cmd>BufferLineCycleNext<CR>")
km.set("n", "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>")

km.set("n", "<C-u>", "<Cmd>UndotreeToggle<CR>")

km.set("n", "<C-=>", "<cmd>:GUIFontSizeUp<CR>")
km.set("n", "<C-->", "<cmd>:GUIFontSizeDown<CR>")
km.set("n", "<C-0>", "<cmd>:GUIFontSizeSet<CR>")

km.set("n", "<C-e>", "<cmd>Neotree toggle<CR>")

km.set("n", ";", "<cmd>FineCmdline<CR>")
km.set("n", "/", ":SearchBoxMatchAll<CR>")

km.set("n", "<leader>db", ":DBUIToggle<CR>")

km.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "comment toggle" })

km.set(
	"v",
	"<leader>/",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "comment toggle" }
)
-- Keymap to view notification history
km.set("n", "<leader>nh", "<cmd>Telescope notify<CR>", { desc = "Notification history" })

km.set("n", "<leader>gf", vim.lsp.buf.format, {})

km.set("n", "<leader>gl", function()
	local lint = require("lint")
	lint.try_lint()
end, {})

km.set("n", "K", vim.lsp.buf.hover, {})
km.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

km.set("n", "<leader><Tab>", "<cmd>Telescope buffers<CR>")
km.set("n", "<leader>f", "<cmd>Telescope find_files<CR>")
km.set("n", "<leader>h", "<cmd>Telescope command_history<CR>")
km.set("n", "<leader>?", "<cmd>Telescope keymaps<CR>")

km.set("n", "w", "k", { noremap = true, silent = true })
km.set("n", "s", "j", { noremap = true, silent = true })
km.set("n", "a", "h", { noremap = true, silent = true })
km.set("n", "d", "l", { noremap = true, silent = true })
km.set("n", "<S-s>", "<PageDown>", { noremap = true, silent = true })
km.set("n", "<S-w>", "<PageUp>", { noremap = true, silent = true })
km.set("n", "<S-a>", "^", { noremap = true, silent = true })
km.set("n", "<S-d>", "$", { noremap = true, silent = true })

km.set("n", "<C-w>w", "<C-W>K", { noremap = true, silent = true })
km.set("n", "<C-w>s", "<C-W>J", { noremap = true, silent = true })
km.set("n", "<C-w>a", "<C-W>H", { noremap = true, silent = true })
km.set("n", "<C-w>d", "<C-W>L", { noremap = true, silent = true })

km.set("n", "<C-w><Up>", "<C-W>K", { noremap = true, silent = true })
km.set("n", "<C-w><Down>", "<C-W>J", { noremap = true, silent = true })
km.set("n", "<C-w><Left>", "<C-W>H", { noremap = true, silent = true })
km.set("n", "<C-w><Right>", "<C-W>L", { noremap = true, silent = true })

km.set("n", "h", "a", { noremap = true, silent = true })
km.set("n", "i", "a", { noremap = true, silent = true })
km.set("n", "j", "w", { noremap = true, silent = true })
km.set("n", "k", "s", { noremap = true, silent = true })
km.set("n", "l", "d", { noremap = true, silent = true })

km.set("n", "2", "a", { noremap = true, silent = true })
km.set("n", "3", "dd", { noremap = true, silent = true })
km.set("v", "3", "dd", { noremap = true, silent = true })
km.set("n", "1", "d", { noremap = true, silent = true })
km.set("v", "1", "d", { noremap = true, silent = true })

km.set("v", "w", "k", { noremap = true, silent = true })
km.set("v", "s", "j", { noremap = true, silent = true })
km.set("v", "a", "h", { noremap = true, silent = true })
km.set("v", "d", "l", { noremap = true, silent = true })
km.set("v", "<S-s>", "<PageDown>", { noremap = true, silent = true })
km.set("v", "<S-w>", "<PageUp>", { noremap = true, silent = true })
km.set("v", "<S-a>", "^", { noremap = true, silent = true })
km.set("v", "<S-d>", "$", { noremap = true, silent = true })
