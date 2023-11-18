local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	--[[ use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter ]]
	use("windwp/nvim-ts-autotag") -- Autotags for CSS, HTML, etc
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim")
	use("akinsho/toggleterm.nvim")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("folke/which-key.nvim")
	use("karb94/neoscroll.nvim") -- Gives commands like "zz" a nice scroll
	use("folke/todo-comments.nvim") -- Gives hints on comments like TODO, BUG, etc.
	use("nacro90/numb.nvim") -- Allows to peek at line by using :{number}
	use({
		"akinsho/nvim-bufferline.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})

	use("LnL7/vim-nix")

	-- utils
	use("ghillb/cybu.nvim")

	-- Colorschemes
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	use("lunarvim/darkplus.nvim")
	use("francocalvo/dracula.nvim")
	--[[ use 'Mofiqul/dracula.nvim' ]]
	use("shaunsingh/nord.nvim")
	use("folke/tokyonight.nvim")

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-omni") -- vsnip completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("crispgm/cmp-beancount") -- vsnip completions

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	--[[ use "williamboman/nvim-lsp-installer" -- simple to use language server installer ]]
	use("williamboman/mason.nvim") -- replaces lsp-installer
	use("williamboman/mason-lspconfig.nvim") -- replaces lsp-installer
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("lvimuser/lsp-inlayhints.nvim") -- adds inlay hints, markers in the editor
	use("ray-x/lsp_signature.nvim") -- adds function signature when you type
	use("nvimtools/none-ls.nvim") -- for formatters and linters
	use("RRethy/vim-illuminate") -- For highlighting the same word under cursor
	use({
		"zbirenbaum/copilot.lua",
		event = { "VimEnter" },
		config = function()
			vim.defer_fn(function()
				require("user.copilot")
			end, 100)
		end,
	})

	-- Telescope
	use("nvim-telescope/telescope.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Refactoring for Python
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- DAP
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use({ "Pocco81/DAPInstall.nvim", commit = "24923c3" }) -- in got a rebranding that's shit
	use("theHamsta/nvim-dap-virtual-text")

	-- Winbar
	use("fgheng/winbar.nvim")
	use("SmiteshP/nvim-navic")

	-- Personal
	use("lervag/vimtex") -- LaTeX
	use("vimwiki/vimwiki") -- Wiki
	use("itchyny/calendar.vim") -- Calendar
	use("nathangrigg/vim-beancount")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
