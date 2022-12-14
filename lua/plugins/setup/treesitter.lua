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
		"html",
		"css"
	}, -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = {} },
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = 65536, -- Do not enable for files with more than n lines, int
	},
	context_commentstring = {
		enable = true
	}
})

require("treesitter-context").setup()

require("indent_blankline").setup {
	show_current_context = true,
	show_current_context_start = true,
}
