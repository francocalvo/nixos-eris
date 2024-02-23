-- vim.g.Illuminate_delay = 0
-- vim.g.Illuminate_highlightUnderCursor = 0
vim.g.Illuminate_ftblacklist = {'alpha', 'NvimTree'}
-- vim.g.Illuminate_highlightUnderCursor = 0
vim.api.nvim_set_keymap('n', '<S-Down>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<S-Up>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
