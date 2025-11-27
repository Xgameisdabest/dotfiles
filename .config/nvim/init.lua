local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.api.nvim_set_option("clipboard", "unnamedplus")
require("vim-options")
require("lazy").setup("plugins")
-- require("notify")("Hello User!")

-- HTML boilerplate template
local html_template = [[
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

-- Insert template
local function insert_html_boilerplate()
	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(html_template, "\n"))
	vim.api.nvim_win_set_cursor(0, { 9, 8 })
end

-- For files created by nvim file.html
vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = { "*.html", "*.htm" },
	callback = function()
		insert_html_boilerplate()
	end,
})

-- For files created via "touch"
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*.html", "*.htm" },
	callback = function()
		-- If file is empty, insert the template
		if vim.api.nvim_buf_line_count(0) == 1 and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == "" then
			insert_html_boilerplate()
		end
	end,
})
