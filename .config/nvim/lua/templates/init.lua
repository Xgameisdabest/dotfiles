local M = {}

-- Automatically require every file inside lua/templates/
function M.load_all()
	local template_dir = vim.fn.stdpath("config") .. "/lua/templates"

	-- Scan directory
	local files = vim.fn.readdir(template_dir)

	for _, file in ipairs(files) do
		-- Only load .lua files that are not this init.lua
		if file:match("%.lua$") and file ~= "init.lua" then
			local module_name = "templates." .. file:gsub("%.lua$", "")
			local ok, mod = pcall(require, module_name)

			-- If module has a setup() function, call it
			if ok and type(mod.setup) == "function" then
				mod.setup()
			end
		end
	end
end

return M
