local o = vim.o
local g = vim.g
local km = vim.keymap

g.mapleader = " "

o.number = true
o.relativenumber = false
o.autoindent = true
o.ruler = true
o.cursorline = true
o.guifont = "Jetbrainsmono Nerd Font:h10"

km.set("n", "<C-=>", "<cmd>:GUIFontSizeUp<CR>")
km.set("n", "<C-->", "<cmd>:GUIFontSizeDown<CR>")
km.set("n", "<C-0>", "<cmd>:GUIFontSizeSet<CR>")

g.termguicolors = true

km.set("n", "<leader>SO", "<cmd>source %<CR>")
km.set("n", "<leader>L", "<cmd>Lazy<CR>")
km.set("n", "<leader>M", "<cmd>Mason<CR>")
