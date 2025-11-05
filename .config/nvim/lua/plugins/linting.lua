return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			c = { "cpplint" },
			cpp = { "cpplint" },
			python = { "pylint" },
			lua = { "luacheck" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Example: soft background colors for virtual text
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "#3b0000", fg = "#f38ba8" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "#3b2f00", fg = "#f9e2af" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "#003b3b", fg = "#81ccee" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "#002b00", fg = "#a6e3a1" })

		vim.diagnostic.config({
			virtual_text = {
				prefix = "●", -- could be "▎", "■", "●"
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})
	end,
}
