return {
	"karb94/neoscroll.nvim",
	config = function()
		local neoscroll = require("neoscroll")

		neoscroll.setup({
			mappings = {},
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = false,
			cursor_scrolls_alone = true,
			easing = "linear",
			pre_hook = nil, -- Function to run before the scrolling animation starts
			post_hook = nil, -- Function to run after the scrolling animation ends
			performance_mode = false, -- Disable "Performance Mode" on all buffers.
			ignored_events = { -- Events ignored while scrolling
				"WinScrolled",
				"CursorMoved",
			},
		})

		local km = vim.keymap

		km.set("n", "<S-s>", function()
			neoscroll.ctrl_f({ duration = 150 })
		end, { desc = "Page Down" })

		km.set("n", "<S-w>", function()
			neoscroll.ctrl_b({ duration = 150 })
		end, { desc = "Page Up" })

		km.set("v", "<S-s>", function()
			neoscroll.ctrl_f({ duration = 150 })
		end, { desc = "Page Down" })

		km.set("v", "<S-w>", function()
			neoscroll.ctrl_b({ duration = 150 })
		end, { desc = "Page Up" })
		
		km.set("n", "<PageDown>", function()
			neoscroll.ctrl_f({ duration = 150 })
		end, { desc = "Page Down" })

		km.set("n", "<PageUp>", function()
			neoscroll.ctrl_b({ duration = 150 })
		end, { desc = "Page Up" })

	end,
}
