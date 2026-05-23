return {
	"tpope/vim-fugitive",
	cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
	keys = {
		{ "<leader>gs", "<cmd>Git<cr>", desc = "Git status (fugitive)" },
		{ "<leader>gB", "<cmd>Git blame<cr>", desc = "Git blame (fugitive)" },
		{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split (fugitive)" },
		{ "<leader>gl", "<cmd>Git log<cr>", desc = "Git log (fugitive)" },
	},
}
