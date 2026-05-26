return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
	},
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
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]k"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]K"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[k"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[K"] = "@class.outer",
					},
				},
			},
		})
	end,
}
