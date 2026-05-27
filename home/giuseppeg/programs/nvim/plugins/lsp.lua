return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "saghen/blink.cmp", "nvim-telescope/telescope.nvim" },
	config = function()
		local servers = {
			"lua_ls", "nixd", "clangd", "cmake", "bashls",
			"html", "cssls", "jsonls", "eslint",
			"ts_ls", "yamlls", "taplo",
			"rust_analyzer", "gopls",
			"basedpyright", "ruff",
			"marksman", "elixirls",
		}

		vim.lsp.config("clangd", {
			cmd = { "clangd", "--query-driver=/nix/store/*/bin/*" },
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = {
						checkThirdParty = false,
						library = vim.api.nvim_get_runtime_file("", true),
					},
					diagnostics = { globals = { "vim" } },
				},
			},
		})

		vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

		vim.lsp.enable(servers)

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local builtin = require("telescope.builtin")
				vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

				local map = function(lhs, rhs)
					vim.keymap.set("n", lhs, rhs, { buffer = args.buf })
				end
				map("gd", vim.lsp.buf.definition)
				map("gr", builtin.lsp_references)
				map("gD", vim.lsp.buf.declaration)
				map("gT", vim.lsp.buf.type_definition)
				map("K", vim.lsp.buf.hover)
				map("<space>cr", vim.lsp.buf.rename)
				map("<space>ca", vim.lsp.buf.code_action)
				map("<space>wd", builtin.lsp_document_symbols)
				map("<space>ww", function() builtin.diagnostics({ root_dir = true }) end)
			end,
		})
	end,
}
