return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = function()
		require("nvim-treesitter").update()
	end,
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
	},
	config = function()
		local parsers = {
			"lua",
			"vim",
			"vimdoc",
			"query",
			"bash",
			"nix",
			"html",
			"css",
			"javascript",
			"typescript",
			"tsx",
			"json",
			"yaml",
			"toml",
			"c",
			"cpp",
			"cmake",
			"rust",
			"go",
			"java",
			"elixir",
			"heex",
			"markdown",
			"markdown_inline",
			"python",
		}

		require("nvim-treesitter").install(parsers)

		-- Filetypes that should get highlight + indent.
		-- (Parser names and filetype names differ in a few cases.)
		local filetypes = {
			"lua",
			"vim",
			"help",
			"query",
			"bash",
			"sh",
			"nix",
			"html",
			"css",
			"javascript",
			"typescript",
			"typescriptreact",
			"json",
			"yaml",
			"toml",
			"c",
			"cpp",
			"cmake",
			"rust",
			"go",
			"java",
			"elixir",
			"heex",
			"markdown",
			"python",
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function(ev)
				pcall(vim.treesitter.start)
				vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		-- textobjects: bind keymaps manually against the new API
		local select = require("nvim-treesitter-textobjects.select")
		local function sel(obj)
			return function()
				select.select_textobject(obj, "textobjects")
			end
		end
		vim.keymap.set({ "x", "o" }, "af", sel("@function.outer"))
		vim.keymap.set({ "x", "o" }, "if", sel("@function.inner"))
		vim.keymap.set({ "x", "o" }, "ac", sel("@class.outer"))
		vim.keymap.set({ "x", "o" }, "ic", sel("@class.inner"))
		vim.keymap.set({ "x", "o" }, "aa", sel("@parameter.outer"))
		vim.keymap.set({ "x", "o" }, "ia", sel("@parameter.inner"))

		local move = require("nvim-treesitter-textobjects.move")
		local function goto_(fn, obj)
			return function()
				fn(obj, "textobjects")
			end
		end
		vim.keymap.set({ "n", "x", "o" }, "]f", goto_(move.goto_next_start, "@function.outer"))
		vim.keymap.set({ "n", "x", "o" }, "]k", goto_(move.goto_next_start, "@class.outer"))
		vim.keymap.set({ "n", "x", "o" }, "]a", goto_(move.goto_next_start, "@parameter.inner"))
		vim.keymap.set({ "n", "x", "o" }, "]F", goto_(move.goto_next_end, "@function.outer"))
		vim.keymap.set({ "n", "x", "o" }, "]K", goto_(move.goto_next_end, "@class.outer"))
		vim.keymap.set({ "n", "x", "o" }, "[f", goto_(move.goto_previous_start, "@function.outer"))
		vim.keymap.set({ "n", "x", "o" }, "[k", goto_(move.goto_previous_start, "@class.outer"))
		vim.keymap.set({ "n", "x", "o" }, "[a", goto_(move.goto_previous_start, "@parameter.inner"))
		vim.keymap.set({ "n", "x", "o" }, "[F", goto_(move.goto_previous_end, "@function.outer"))
		vim.keymap.set({ "n", "x", "o" }, "[K", goto_(move.goto_previous_end, "@class.outer"))
	end,
}
