return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		-- A list of parser names, or "all"
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			"python",
			"javascript",
			"typescript",
		},

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		auto_install = true,

		-- New way: Highlighting is now a 'module' again in the stable wrapper
		highlight = {
			enable = true,
			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set to `false` if you want only tree-sitter highlighting.
			additional_vim_regex_highlighting = false,
		},

		indent = { enable = true },
	},
	config = function(_, opts)
		-- This uses the standard setup call which is still supported
		-- by the nvim-treesitter wrapper to maintain compatibility
		require("nvim-treesitter").setup(opts)
	end,
}
