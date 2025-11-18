return {
	"jay-babu/mason-null-ls.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local mason_null_ls = require("mason-null-ls")

		-- normal null-ls setup (NO sources needed)
		null_ls.setup()

		mason_null_ls.setup({
			automatic_installation = false, -- you install tools manually using :Mason
			handlers = {
				-- default handler to automatically register everything
				function(source_name, methods)
					mason_null_ls.default_setup(source_name, methods)
				end,
			},
		})
	end,
}
