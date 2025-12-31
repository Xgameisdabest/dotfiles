return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- In 2025, use 'opts' to define parsers, but note that
	-- many 'modules' like highlight have moved to native Neovim
	opts = {
		ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
		auto_install = true,
	},
	config = function(_, opts)
		local ts = require("nvim-treesitter")

		-- Basic installation of defined parsers
		ts.install(opts.ensure_installed)

		-- Enable highlighting globally via Neovim's native engine
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
				if lang then
					pcall(vim.treesitter.start, args.buf, lang)
				end
			end,
		})
	end,
}
