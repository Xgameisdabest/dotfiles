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
					extra_args = { "--style={IndentWidth: 8, UseTab: Never}" },
				}),
			},
		})
		-- -- Autoformat on save
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		-- 	callback = function()
		-- 		vim.lsp.buf.format()
		-- 	end,
		-- })
	end,
}
