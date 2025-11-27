local M = {}

function M.get_template()
	local filename = vim.fn.expand("%:t:r")
	return string.format(
		[[
/*
 Script: %s.java
 Description: <your-description-here>
 Author: <your-name>
 Credits: <credits-here>
*/

public class %s {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
]],
		filename,
		filename
	)
end

function M.insert()
	local template = M.get_template()
	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template, "\n"))
	vim.api.nvim_win_set_cursor(0, { 8, 8 })
end

function M.ask_and_insert()
	local ans = vim.fn.input("Insert Java template? [y/N]: ")
	if ans:lower() == "y" then
		M.insert()
	end
end

function M.setup()
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
		pattern = "*.java",
		callback = function()
			local lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)
			if vim.api.nvim_buf_line_count(0) == 1 and lines[1] == "" then
				M.ask_and_insert()
			end
		end,
	})
end

return M
