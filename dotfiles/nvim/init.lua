if vim.g.vscode then
	vim.cmd([[ xmap gc  <Plug>VSCodeCommentary ]])
	vim.cmd([[ nmap gc  <Plug>VSCodeCommentary ]])
	vim.cmd([[ omap gc  <Plug>VSCodeCommentary ]])
	vim.cmd([[ nmap gcc  <Plug>VSCodeCommentaryLine ]])
else
	-- This should make Mason work in NixOS.
	-- https://github.com/williamboman/mason.nvim/issues/428
	--
	require("user.plugins") -- OK - See below
	--local mason_registry = require("mason-registry")
	--mason_registry:on("package:install:success", function(pkg)
	--	pkg:get_receipt():if_present(function(receipt)
	--		-- Figure out the interpreter inspecting nvim itself
	--		-- This is the same for all packages, so compute only once
	--		local interpreter = os.execute(
	--			("patchelf --print-interpreter %q"):format(
	--				"$(grep -oE '\\/nix\\/store\\/[a-z0-9]+-neovim-unwrapped-[0-9]+\\.[0-9]+\\.[0-9]+\\/bin\\/nvim' $(which nvim))"
	--			)
	--		)

	--		for _, rel_path in pairs(receipt.links.bin) do
	--			local bin_abs_path = pkg:get_install_path() .. "/" .. rel_path
	--			if pkg.name == "lua-language-server" then
	--				bin_abs_path = pkg:get_install_path() .. "/extension/server/bin/lua-language-server"
	--			end

	--			-- Set the interpreter on the binary
	--			os.execute(("patchelf --set-interpreter %q %q"):format(interpreter, bin_abs_path))
	--		end
	--	end)
	--end)

	require("user.alpha") -- OK
	require("user.nvim-webdev-icons") -- OK - updated up to 5b240a9
	require("user.whichkey") -- OK
	require("user.options") -- OK - updated up to 2022/09/12
	require("user.illuminate") -- Not updated
	require("user.colorscheme") -- OK
	require("user.cmp") -- OK - Pretty similar, without tabnine
	require("user.treesitter") -- OK - without textobjects part at the end
	require("user.keymaps") -- OK
	require("user.autopairs") -- OK
	require("user.telescope") -- OK - updated up to  5b240a9
	require("user.lsp") -- OK - updated up to 2022/09/12
	require("user.autotag") -- OK
	require("user.comment") -- OK
	require("user.gitsigns") -- OK
	require("user.lualine") -- OK - updated up to 5b240a9
	require("user.toggleterm")
	require("user.project") -- OK
	require("user.impatient") -- OK
	require("user.indentline") -- OK - updated up to 5b240a9
	require("user.autocommands") -- updated up to 2022/09/12
	require("user.neoscroll") -- OK
	--[[ require "user.todo-comments"              -- NOT OK ]]
	require("user.numb") -- OK
	require("user.vimwiki") -- TODO: Finish setup
	require("user.functions") -- updated up to  5b240a9
	require("user.navic") -- updated up to  5b240a9
	require("user.winbar") -- OK - updated up to 2022/09/12
	require("user.dap")
	require("user.cybu")
	require("user.vimtex")
	require("user.bufferline") -- OK - updated up to 2022/09/12
	require("user.nvimtree") -- OK - updated up to  5b240a9
	--[[ require "user.copilot" ]]
end

-- Not added nor checked from his repo:
-- - lsp-inlayhints
-- - project
-- - hop
-- - matchup
-- - dial
-- - colorizer
-- - spectre
-- - zen-mode
-- - bookmark
-- - symbol-outline
-- - git-blame
-- - gitlinker
-- - notify
-- - ts-context
-- - registers
-- - sniprun
-- - lir
-- - bfs
-- - crates
-- - dressing
-- - tabout
-- - fidget
-- - browse
-- - auto-session
-- - jaq
-- - surround
-- - harpoon
-- - lab
-- - vim-slash
