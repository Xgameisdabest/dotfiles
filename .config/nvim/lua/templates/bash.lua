local M = {}

-- Full Bash template
M.template = [[
#!/usr/bin/env bash
# ============================================
# Script: <script-name>
# Description: <your-description-here>
# Author: <your-name>
# ============================================

# Uncomment for strict mode:
# set -e      # exit on error
# set -u      # error on undefined variables
# set -o pipefail  # fail if any command in pipeline fails

main() {
    echo "Hello, world!"
}

main "$@"
]]

-- Insert the template into the buffer
function M.insert()
	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(M.template, "\n"))
	vim.api.nvim_win_set_cursor(0, { 11, 4 })
end

-- Ask the user before inserting
function M.ask_and_insert()
	local ans = vim.fn.input("Insert Bash script template? [y/N]: ")
	if ans:lower() == "y" then
		M.insert()
	end
end

-- Setup autocmds for new or empty .sh/.bash files
function M.setup()
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
		pattern = { "*.sh", "*.bash" },
		callback = function()
			local lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)
			if vim.api.nvim_buf_line_count(0) == 1 and lines[1] == "" then
				M.ask_and_insert()
			end
		end,
	})
end

return M
