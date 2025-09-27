return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
	config = function()
		local neotree = require("neo-tree")
		neotree.setup({
			close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
			popup_border_style = "", -- or "" to use 'winborder'
			enable_git_status = true,
			enable_diagnostics = true,
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
			open_files_using_relative_paths = false,
			sort_case_insensitive = false, -- used when sorting files and directories in the tree
			sort_function = function(a, b)
				if a.type == b.type then
					return a.path > b.path
				else
					return a.type > b.type
				end
			end, -- this sorts files and directories descendantly

			default_component_configs = {
				indent = {
					indent_size = 2,
					padding = 1, -- extra padding on left hand side
					-- indent guides
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					-- expander config, needed for nesting files
					with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
						if node.type == "file" or node.type == "terminal" then
							local success, web_devicons = pcall(require, "nvim-web-devicons")
							local name = node.type == "terminal" and "terminal" or node.name
							if success then
								local devicon, hl = web_devicons.get_icon(name)
								icon.text = devicon or icon.text
								icon.highlight = hl or icon.highlight
							end
						end
					end,
					default = "*",
					highlight = "NeoTreeFileIcon",
				},
				modified = {
					symbol = "[]",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "✚",
						modified = "",
						deleted = "󰛌",
						renamed = "󱈤",
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
			window = {
				position = "left",
				width = 35,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["w"] = "",
					["s"] = "",
					["<space>"] = {},
					["<2-LeftMouse>"] = "open",
					["<cr>"] = "open",
					["<esc>"] = "cancel", -- close preview or floating neo-tree window
					["P"] = {
						"toggle_preview",
						config = {
							use_float = true,
							use_snacks_image = true,
							use_image_nvim = true,
						},
					},
					-- Read `# Preview Mode` for more information
					["["] = "open_split",
					["]"] = "open_vsplit",
					["\\"] = "close_node",
					["|"] = "close_all_nodes",
					["="] = {
						"add",
						config = {
							show_path = "absolute",
						},
					},
					["+"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
					["-"] = "delete",
					["_"] = "rename",
					["0"] = "rename_basename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = {
						"copy",
						config = {
							show_path = "absolute",
						},
					},
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
					["i"] = {
						"show_file_details",
						config = {
							created_format = "%Y-%m-%d %I:%M %p",
							modified_format = "relative", -- equivalent to the line below
							modified_format = function(seconds)
								return require("neo-tree.utils").relative_date(seconds)
							end,
						},
					},
					["a"] = "navigate_up",
					["d"] = "set_root",
				},
			},
		})
	end,
}
