-- transition to hyprland.lua

-- CONFIG SPLIT

-- custom config

local home = os.getenv("HOME")
local custom_dir = home .. "/.config/hypr/custom/"
local main_cfg_dir = home .. "/.config/hypr_lua/hyprland_config_modules/"

-- Add the main_cfg_dir to the search path
package.path = package.path .. ";" .. main_cfg_dir .. "?.lua"
-- We use -printf to get the path relative to the main_cfg_dir
local p = io.popen("find " .. main_cfg_dir .. ' -maxdepth 2 -name "*.lua" -printf "%P\n"')
if p then
	for file in p:lines() do
		-- Remove the .lua extension
		local module_path = file:gsub("%.lua$", "")
		-- Convert directory slashes (/) to dots (.) for Lua's require
		local module_name = module_path:gsub("/", ".")
		if module_name ~= "" then
			require(module_name)
			print("Loading: " .. module_name)
		end
	end
	p:close()
end

-- Add the custom dir to the search path
package.path = package.path .. ";" .. custom_dir .. "?.lua"
local p = io.popen("find " .. custom_dir .. ' -maxdepth 1 -name "*.lua"')
if p then
	for file in p:lines() do
		-- Extract just the filename without the path or .lua extension
		local module_name = file:match("([^/]+)%.lua$")
		if module_name then
			require(module_name)
		end
	end
	p:close()
end

-----------------------
----- PERMISSIONS -----
-----------------------
hl.config({
	ecosystem = {
		enforce_permissions = false,
	},
})
