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
			virtual_text = false,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		vim.api.nvim_create_autocmd("CursorHold", {
			group = lint_augroup,
			callback = function()
				vim.diagnostic.open_float(nil, {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = "rounded",
					source = "always",
					prefix = "",
					format = function(diagnostic)
						-- Define custom icons/colors per severity
						local severity = vim.diagnostic.severity[diagnostic.severity]
						local icons = {
							[vim.diagnostic.severity.ERROR] = " ",
							[vim.diagnostic.severity.WARN] = " ",
							[vim.diagnostic.severity.INFO] = " ",
							[vim.diagnostic.severity.HINT] = " ",
						}
						local icon = icons[diagnostic.severity] or ""
						-- Return colored prefix text
						local hl_group = ({
							[vim.diagnostic.severity.ERROR] = "DiagnosticFloatingError",
							[vim.diagnostic.severity.WARN] = "DiagnosticFloatingWarn",
							[vim.diagnostic.severity.INFO] = "DiagnosticFloatingInfo",
							[vim.diagnostic.severity.HINT] = "DiagnosticFloatingHint",
						})[diagnostic.severity]

						return string.format("%s%s", icon, diagnostic.message)
					end,
				})
			end,
		})
	end,
}
