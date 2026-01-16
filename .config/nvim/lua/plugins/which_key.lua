return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- Default settings
		preset = "icons",
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- 1. Global Mappings (Movement, Buffers, UI)
		wk.add({
			-- WASD Movement
			{ "w", "k", desc = "Up" },
			{ "s", "j", desc = "Down" },
			{ "a", "h", desc = "Left" },
			{ "d", "l", desc = "Right" },
			-- Shift Movement
			{ "S-w", "<PageUp>", desc = "Page Up" },
			{ "S-s", "<PageDown>", desc = "Page Down" },
			{ "S-a", "^", desc = "Line Start" },
			{ "S-d", "$", desc = "Line End" },
			-- Window Management (C-w)
			{ "<C-w>w", "<C-W>K", desc = "Move Window Up" },
			{ "<C-w>s", "<C-W>J", desc = "Move Window Down" },
			{ "<C-w>a", "<C-W>H", desc = "Move Window Left" },
			{ "<C-w>d", "<C-W>L", desc = "Move Window Right" },
			-- Buffers & Editor
			{ "<TAB>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
			{ "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
			{ "<C-a>", "ggVG", desc = "Select All" },
			{ "<C-e>", "<cmd>Neotree toggle<CR>", desc = "File Explorer" },
			{ "<C-u>", "<Cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
			{ "ee", "<cmd>w<CR>", desc = "Save File" },
			{ "qq", "<cmd>q<CR>", desc = "Quit" },
			{ "Q", "<cmd>wq<CR>", desc = "Save & Quit" },
			{ ";", "<cmd>FineCmdline<CR>", desc = "Command Line" },
			{ "/", ":SearchBoxMatchAll<CR>", desc = "Search" },
		})

		-- 2. Leader Mappings
		wk.add({
			{ "<leader><bs>", "<cmd>q<CR>", desc = "Close Window" },
			{ "<leader><Tab>", "<cmd>Telescope buffers<CR>", desc = "Switch Buffers" },
			{ "<leader>SO", "<cmd>source %<CR>", desc = "Source Config" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
			{ "<leader>db", ":DBUIToggle<CR>", desc = "Database UI" },
			{ "<leader>f", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
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
		})

		-- 3. Visual Mode Mappings
		wk.add({
			mode = "v",
			{ "w", "k", desc = "Up" },
			{ "s", "j", desc = "Down" },
			{ "a", "h", desc = "Left" },
			{ "d", "l", desc = "Right" },
			{ "3", "dd", desc = "Delete Line" },
			{ "1", "d", desc = "Delete Selection" },
			{
				"<leader>/",
				"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
				desc = "Toggle Comment",
			},
		})
	end,
}
