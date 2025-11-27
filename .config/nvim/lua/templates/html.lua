local M = {}

-- HTML boilerplate template
M.html_template = [[
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="x-ua-compatible" content="ie=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="description" content="Short page description" />

  <title>Page Title</title>
  <link rel="icon" href="/favicon.ico" />
  <link rel="stylesheet" href="styles.css" />
  <script defer src="main.js"></script>
</head>
<body>
  <header>
    <h1>Heading</h1>
  </header>

  <main>
    <p>Hello world — replace with your content.</p>
  </main>

  <footer>
    <small>© Year — Your Name</small>
  </footer>

  <!-- vim: set ft=html ts=2 sw=2 expandtab: -->
</body>
</html>
]]

-- Function to insert template
function M.insert()
	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(M.html_template, "\n"))
	vim.api.nvim_win_set_cursor(0, { 9, 8 })
end

-- Function to ask user before inserting
function M.ask_and_insert()
	local answer = vim.fn.input("Insert HTML template? [y/N]: ")
	if answer:lower() == "y" then
		M.insert()
	end
end

-- Setup autocmds for HTML files
function M.setup()
	vim.api.nvim_create_autocmd("BufNewFile", {
		pattern = { "*.html", "*.htm" },
		callback = M.ask_and_insert,
	})

	-- Empty files created via touch
	vim.api.nvim_create_autocmd("BufReadPost", {
		pattern = { "*.html", "*.htm" },
		callback = function()
			local lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)
			if vim.api.nvim_buf_line_count(0) == 1 and lines[1] == "" then
				M.ask_and_insert()
			end
		end,
	})
end

return M
