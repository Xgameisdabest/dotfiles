-- transition to hyprland.lua

-- CONFIG SPLIT

-- custom config

local home = os.getenv("HOME")
local custom_dir = home .. "/.config/hypr_lua/custom/"
local main_cfg_dir = home .. ".config/hypr_lua/hyprland_config_modules/"

-- Add the main_cfg_dir dir to the search path
package.path = package.path .. ";" .. main_cfg_dir .. "?.lua"
local p = io.popen("find " .. main_cfg_dir .. ' -maxdepth 1 -name "*.lua"')
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

---------------------
---- KEYBINDINGS ----
---------------------
--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
local overlayLayerRule = hl.layer_rule({
	name = "no-anim-overlay",
	match = { namespace = "^my-overlay$" },
	no_anim = true,
})
overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

-- Window rules
hl.window_rule({
	name = "rofi"
})
