return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.biome,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.clang_format.with({
					extra_args = {
						"--style={BasedOnStyle: LLVM, IndentWidth: 8, UseTab: Never}",
						"--fallback-style=none",
					},
				}),
			},
		})
	end,
}
