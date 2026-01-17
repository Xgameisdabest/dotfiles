return {
	"startup-nvim/startup.nvim",
	requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	config = function()
		require("startup").setup({
			-- every line should be same width without escaped \
			header = {
				type = "text",
				oldfiles_directory = false,
				align = "center",
				fold_section = false,
				title = "Header",
				margin = 5,

				content = {
					"⣿⣿⣿⣿⣿⣷⣿⣿⣿⡅⡹⢿⠆⠙⠋⠉⠻⠿⣿⣿⣿⣿⣿⣿⣮⠻⣦⡙⢷⡑⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣌⠡⠌⠂⣙⠻⣛⠻⠷⠐⠈⠛⢱⣮⣷⣽⣿",
					"⣿⣿⣿⣿⡇⢿⢹⣿⣶⠐⠁⠀⣀⣠⣤⠄⠀⠀⠈⠙⠻⣿⣿⣿⣦⣵⣌⠻⣷⢝⠦⠚⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⣻⣿⣊⡃⠀⣙⠿⣿⣿⣿⣎⢮⡀⢮⣽⣿⣿",
					"⢿⣿⣿⣿⣧⡸⡎⡛⡩⠖⠀⣴⣿⣿⣿⠀⠀⠀⠀⠸⠇⠀⠙⢿⣿⣿⣿⣷⣌⢷⣑⢷⣄⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣫⠶⠛⠉⠀⠁⠀⠈⠈⠀⠠⠜⠻⣿⣆⢿⣼⣿⣿⣿",
					"⢐⣿⣿⣿⣿⣧⢧⣧⢻⣦⢀⣹⣿⣿⣿⣇⠀⠄⠀⠀⠀⡀⠀⠈⢻⣿⣿⣿⣿⣷⣝⢦⡹⠷⡙⢿⣿⣿⣿⣿⣿⣿⣿⣿⠈⠁⠀⠀⠀⠁⠀⠀⠀⠱⣶⣄⡀⠀⠈⠛⠜⣿⣿⣿⣿",
					"⠀⠊⢫⣿⣏⣿⡌⣼⣄⢫⡌⣿⣿⣿⣿⣿⣦⡈⠲⣄⣤⣤⡡⢀⣠⣿⣿⣿⣿⣿⣿⣷⣼⣍⢬⣦⡙⣿⣿⣿⣿⣿⣯⢁⡄⠀⡀⡀⠀⠄⢈⣠⢪⠀⣿⣿⣿⣦⠀⢉⢂⠹⡿⣿⣿",
					"⠀⠀⠄⢹⢃⢻⣟⠙⣿⣦⠱⢻⣿⣿⣿⣿⣿⣿⣷⣬⣍⣭⣥⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡙⢿⣼⡿⣿⣿⣿⣿⣿⣷⣄⠘⣱⢦⣤⡴⡿⢈⣼⣿⣿⣿⣇⣴⣶⣮⣅⢻⣿⡏",
					"⠀⠀⠈⠹⣇⢡⢿⡆⠻⣿⣷⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣍⡻⣿⣟⣻⣿⣿⣿⣿⣷⣦⣥⣬⣤⣴⣾⣿⣿⣿⣿⣷⣿⣿⣿⣿⣷⡜⠃",
				},

				-- content = {
				-- 	"      ⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷",
				-- 	"      ⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇",
				-- 	"      ⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽",
				-- 	"      ⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕",
				-- 	"      ⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕",
				-- 	"      ⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕",
				-- 	"      ⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄",
				-- 	"      ⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕",
				-- 	"      ⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿",
				-- 	"      ⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
				-- 	"      ⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟",
				-- 	"      ⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠",
				-- 	"      ⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙",
				-- 	"      ⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣",
				-- },

				highlight = "Statement",
				default_color = "",
				oldfiles_amount = 0,
			},

			version_info = {
				type = "text",
				align = "center",
				margin = 5,
				content = {
					"Neovim v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
				},
				highlight = "Special", -- Gives it a distinct color
			},

			-- name which will be displayed and command
			body = {
				type = "mapping",
				oldfiles_directory = false,
				align = "center",
				fold_section = false,
				title = "Basic Commands",
				margin = 5,
				content = {
					{ " Recent Files", "Telescope oldfiles", "Space+fo" },
					{ " Find File", "Telescope find_files", "Space+ff" },
					{ " New File", "lua require'startup'.new_file()", "Space+nf" },
					{ " Open Neotree", "Neotree", "Ctrl+e" },
					{ "󰒲 Open Lazy", "Lazy", "Space+L" },
					{ "󰢷 Open Mason", "Mason", "Space+M" },
					{ "󰓜 Open Store", "Store", "Space+S" },
				},
				highlight = "String",
				default_color = "",
				oldfiles_amount = 0,
			},

			footer = {
				type = "text",
				oldfiles_directory = false,
				align = "center",
				fold_section = false,
				title = "Footer",
				margin = 5,
				content = {
					"󰌵! Tips",
					"Move around using w,a,s,d and arrow keys",
					"Enter Insert/Write Mode by i",
					"Change modes via ctrl+space or esc",
					"Exit and don't save via qq",
					"Exit and save via eeqq",
				},
				highlight = "Number",
				default_color = "",
				oldfiles_amount = 0,
			},

			options = {
				mapping_keys = true,
				cursor_column = 0.5,
				empty_lines_between_mappings = false,
				disable_statuslines = true,
				paddings = { 1, 1, 1, 1 },
			},
			mappings = {
				execute_command = "<CR>",
				open_file = "o",
				open_file_split = "<c-o>",
				open_section = "<TAB>",
				open_help = "?",
			},
			colors = {
				background = "#1f2227",
				folded_section = "#56b6c2",
			},
			parts = { "header", "version_info", "body", "footer" },
		})
	end,
}
