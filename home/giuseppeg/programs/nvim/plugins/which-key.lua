return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		spec = {
			{ "<leader>f", group = "Find (Telescope)" },
			{ "<leader>t", group = "Test (Neotest)" },
			{ "<leader>g", group = "Git / Grep / DAP run-to-cursor" },
			{ "<leader>x", group = "Trouble" },
			{ "<leader>c", group = "Code / Trouble" },
			{ "<leader>w", group = "Workspace (LSP)" },
		},
	},
}
