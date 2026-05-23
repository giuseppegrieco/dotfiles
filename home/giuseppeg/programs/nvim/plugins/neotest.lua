return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"rouge8/neotest-rust",
		"nvim-neotest/neotest-go",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
		"jfpedroza/neotest-elixir",
	},
	cmd = "Neotest",
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-rust"),
				require("neotest-go"),
				require("neotest-python"),
				require("neotest-jest"),
				require("neotest-vitest"),
				require("neotest-elixir"),
			},
		})

		local set = vim.keymap.set
		local neotest = require("neotest")

		-- run the nearest test
		set("n", "<leader>tn", function() neotest.run.run() end)
		-- run all tests in the current file
		set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end)
		-- toggle the test summary side panel
		set("n", "<leader>ts", function() neotest.summary.toggle() end)
		-- open the floating output for the nearest test
		set("n", "<leader>to", function() neotest.output.open({ enter = true }) end)
		-- toggle the persistent output panel
		set("n", "<leader>tO", function() neotest.output_panel.toggle() end)
	end,
}
