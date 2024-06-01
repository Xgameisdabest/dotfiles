return {

	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local tsconfig = require("nvim-treesitter.configs")
		tsconfig.setup({
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
