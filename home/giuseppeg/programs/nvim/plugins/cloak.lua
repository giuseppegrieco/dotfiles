return {
	"laytan/cloak.nvim",
	event = { "BufReadPre *.env*", "BufReadPre *.envrc", "BufNewFile *.env*" },
	opts = {
		enabled = true,
		cloak_character = "*",
		patterns = {
			{
				file_pattern = { ".env*", "wrangler.toml", ".dev.vars" },
				cloak_pattern = "=.+",
			},
		},
	},
}
