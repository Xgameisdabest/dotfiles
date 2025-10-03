return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")

		-- Replace the default notify
		vim.notify = notify

		-- Setup notify
		notify.setup({
			stages = "slide",
			render = "wrapped-compact",
			timeout = 1000,
			background_colour = "#000000",
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		})

		-- Capture LSP "window/showMessage" notifications
		vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
			local lvl = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]
			local client = vim.lsp.get_client_by_id(ctx.client_id)
			vim.notify(result.message, lvl, {
				title = "LSP | " .. (client and client.name or "Unknown"),
			})
		end

		-- Notify on save
		vim.api.nvim_create_autocmd("BufWritePost", {
			callback = function(args)
				local filename = vim.fn.fnamemodify(args.file, ":t") -- just the filename
				local filetype = vim.bo[args.buf].filetype or "none" -- buffer filetype
				local linecount = vim.api.nvim_buf_line_count(args.buf) -- total lines
				local size = vim.fn.getfsize(args.file) -- file size in bytes

				local msg = string.format(
					[["%s" [%s] %dL, %dB]],
					filename,
					filetype ~= "" and filetype or "none",
					linecount,
					size
				)

				vim.notify(msg, "info", {
					title = "File Saved",
					timeout = 1500,
				})
			end,
		})

		-- Show notification on undo / redo
		vim.api.nvim_create_autocmd("TextChanged", {
			callback = function()
				if vim.v.event and vim.v.event.operator == "undo" then
					local lines = #vim.v.event.regcontents

					local msg
					if lines == 1 then
						msg = "Undid 1 line"
					else
						msg = string.format("Undid %d lines", lines)
					end

					vim.schedule(function()
						vim.notify(msg, "info", {
							title = "Undo",
							timeout = 1200,
						})
					end)
				elseif vim.v.event and vim.v.event.operator == "redo" then
					local lines = #vim.v.event.regcontents

					local msg
					if lines == 1 then
						msg = "Redid 1 line"
					else
						msg = string.format("Redid %d lines", lines)
					end

					vim.schedule(function()
						vim.notify(msg, "info", {
							title = "Redo",
							timeout = 1200,
						})
					end)
				end
			end,
		})

		-- Show "X lines copied" in nvim-notify
		vim.api.nvim_create_autocmd("TextYankPost", {
			callback = function()
				local event = vim.v.event
				local lines = #event.regcontents

				local msg
				if lines == 1 then
					msg = "1 Line Copied"
				else
					msg = string.format("%d Lines Copied", lines)
				end

				-- defer so notify doesn't run inside yank handler
				vim.schedule(function()
					vim.notify(msg, "info", {
						title = "Yank",
						timeout = 1200,
					})
				end)
			end,
		})

		-- Keymap to view notification history
		vim.keymap.set("n", "<leader>nh", function()
			require("notify").history()
		end, { desc = "Notification history" })
	end,
}
