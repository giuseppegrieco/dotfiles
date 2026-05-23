return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua", "vim", "vimdoc", "query", "bash", "nix",
				"html", "css", "javascript", "typescript", "tsx", "json", "yaml", "toml",
				"c", "cpp", "rust", "go", "elixir", "heex",
				"markdown", "markdown_inline",
				"python",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
