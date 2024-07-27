local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

vim.g.skip_ts_context_commentstring_module = true
require("ts_context_commentstring").setup({})

configs.setup({
	ensure_installed = {}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	autotag = {
		enable = true,
		disable = { "xml" },
	},
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "python", "css", "yaml" } },
})
