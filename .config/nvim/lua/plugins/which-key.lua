return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- Default settings
		preset = "icons",
		plugins = {
			presets = {
				operators = false, -- prevents help for d, c, y, etc.
				motions = false, -- prevents help for v, h, j, k, l
			},
		},
		disable = {
			modes = { "v" }, -- This disables the popup entirely in visual mode
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		wk.add({
			{ "<leader><bs>", "<cmd>q<CR>", desc = "Close Window" },
			{ "<leader><Tab>", "<cmd>Telescope buffers<CR>", desc = "Switch Buffers" },
			{ "<leader>SO", "<cmd>source %<CR>", desc = "Source Config" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
			{ "<leader>db", ":DBUIToggle<CR>", desc = "Database UI" },
			{ "<leader>gf", vim.lsp.buf.format, desc = "Format Code" },
			{
				"<leader>gl",
				function()
					require("lint").try_lint()
				end,
				desc = "Lint Code",
			},
			{ "<leader>h", "<cmd>Telescope command_history<CR>", desc = "Command History" },
			{ "<leader>l", "<cmd>Lazy<CR>", desc = "Lazy" },
			{ "<leader>m", "<cmd>Mason<CR>", desc = "Mason" },
			{ "<leader>nh", "<cmd>Telescope notify<CR>", desc = "Notification History" },
			{ "<leader>s", "<cmd>Store<CR>", desc = "Store" },
			{ "<leader>ts", "<cmd>FineCmdline TSInstall<CR>", desc = "Treesitter Install" },
			{
				"<leader>/",
				function()
					require("Comment.api").toggle.linewise.current()
				end,
				desc = "Toggle Comment",
			},

			-- Grouped Sections
			{ "<leader>t", group = "Terminal" },
			{ "<leader>th", ":ToggleTerm direction=horizontal<CR>", desc = "Horizontal" },
			{ "<leader>tv", ":ToggleTerm direction=vertical<CR>", desc = "Vertical" },

			{ "<leader>w", group = "Splits" }, -- Mapping your split logic here
			{ "<leader>[", "<cmd>FineCmdline split <CR>", desc = "Horizontal Split" },
			{ "<leader>]", "<cmd>FineCmdline vsplit <CR>", desc = "Vertical Split" },
			{ "<leader>{", ":split #<CR>", desc = "Split Previous" },
			{ "<leader>}", ":vsplit #<CR>", desc = "V-Split Previous" },

			{ "<leader>f", group = "Find" },
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Find Recent/Old Files" },
		})

		-- -- 3. Visual Mode Mappings
		wk.add({
			mode = "v",
			{ "w", "k", desc = "Up" },
			{ "s", "j", desc = "Down" },
			{ "a", "h", desc = "Left" },
			{ "d", "l", desc = "Right" },
			{ "<S-s>", "<PageDown>", desc = "Page Up" },
			{ "<S-w>", "<PageUp>", desc = "Page Down" },
			{ "<S-a>", "^", desc = "Jump To The Start Of The Line" },
			{ "<S-d>", "$", desc = "Jump To The End Of The Line" },
			{ "3", "dd", desc = "Delete The Entire Line" },
			{ "1", "d", desc = "Delete Selection" },
			{
				"<leader>/",
				"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
				desc = "Toggle Comment",
			},
		})
	end,
}
