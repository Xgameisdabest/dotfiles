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
		local all_modes = { "n", "i", "v" }
		local nv_modes = { "n", "v" }

		for _, nv_modes in ipairs(nv_modes) do
			km.set(nv_modes, "<S-s>", function()
				neoscroll.ctrl_f({ duration = 150 })
			end, { desc = "Page Down" })

			km.set(nv_modes, "<S-w>", function()
				neoscroll.ctrl_b({ duration = 150 })
			end, { desc = "Page Up" })
		end

		for _, all_modes in ipairs(all_modes) do
			km.set(all_modes, "<PageDown>", function()
				neoscroll.ctrl_f({ duration = 150 })
			end, { desc = "Page Down" })

			km.set(all_modes, "<PageUp>", function()
				neoscroll.ctrl_b({ duration = 150 })
			end, { desc = "Page Up" })

			km.set(all_modes, "<S-Down>", function()
				neoscroll.ctrl_f({ duration = 150 })
			end, { desc = "Page Down (Shift)" })

			km.set(all_modes, "<S-Up>", function()
				neoscroll.ctrl_b({ duration = 150 })
			end, { desc = "Page Up (Shift)" })
		end
	end,
}
