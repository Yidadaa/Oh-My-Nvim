local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
		"c",
		"cpp",
		"lua",
		"javascript",
		"vim",
		"json",
		"cmake",
		"typescript",
		"tsx",
		"html",
		"css",
		"rust",
		"vue",
		"bash",
		"prisma",
		"java",
		"vimdoc",
		"markdown"
	},                      -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true,        -- false will disable the whole extension
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = {} },
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = 200, -- Do not enable for files with more than n lines, int
	},
})

require("treesitter-context").setup()

require("ibl").setup()

require('ts_context_commentstring').setup({
	enable = true,
	enable_autocmd = false
})
