return {
	"nvim-telescope/telescope.nvim",
	dependencies = "tsakirist/telescope-lazy.nvim",

	config = function()
		local data = assert(vim.fn.stdpath "data") --[[@as string]]

		require("telescope").setup({
			defaults = {},
			extensions = {
				wrap_results = true,
				fzf = {},
				history = {
					path = vim.fs.joinpath(
						data,
						"telescope_history.sqlite3"
					),
					limit = 100,
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		-- safely load extensions
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "smart_history")
		pcall(require("telescope").load_extension, "ui-select")

		local set = vim.keymap.set
		local builtin = require("telescope.builtin")

		-- searches for files by name in the current project
		set("n", "<leader>fd", builtin.find_files)
		-- search through neovim's help documentation
		set("n", "<leader>fh", builtin.help_tags)
		-- search for a specific text across the current project
		-- set("n", "<leader>fg", require "custom.telescope.multi-ripgrep")
		-- search for a specific text across opened files
		set("n", "<leader>fb", builtin.buffers)
		-- search for a specific text within the current file
		set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
		-- search current word in the current project
		set("n", "<leader>gw", builtin.grep_string)
	end
}
