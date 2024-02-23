local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
	return
end

copilot.setup({
	cmp = {
		enabled = true,
		method = "getCompletionsCycling",
	},
	panel = {
		enabled = true,
		auto_refresh = true,
		keymap = {
			accept = "<CR>",
			jump_prev = "[[",
			jump_next = "]]",
			refresh = "gr",
			open = "<M-CR>",
		},
	},
	suggestion = {
		--[[ enabled = false, ]]
		auto_trigger = true,
		keymap = {
			accept = "<Tab>",
			prev = "<C-a>",
			next = "<C-s>",
			dismiss = "<C-x>",
		},
	},
	ft_disable = { "markdown", "beancount" },
	-- plugin_manager_path = vim.fn.stdpath "data" .. "/site/pack/packer",
	server_opts_overrides = {
		-- trace = "verbose",
		settings = {
			advanced = {
				-- listCount = 10, -- #completions for panel
				inlineSuggestCount = 3, -- #completions for getCompletions
			},
		},
	},
})
