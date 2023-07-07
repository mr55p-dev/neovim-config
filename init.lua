-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	vim.cmd([[packadd packer.nvim]])
end

local editor = require("plugins.editor")
local interface = require("plugins.interface")
local application = require("plugins.application")
local ts = require("plugins.treesitter")
local git = require("plugins.git")
local terminal = require("plugins.terminal")
local telescope = require("plugins.telescope")
local cmp = require("plugins.cmp")
local lsp = require("plugins.lsp")
local ft_plugins = require("plugins.ft_plugins")
local mini_config = require("plugins.mini_config")

require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- Package manager

	-- Color schemes
	use({ "shaunsingh/nord.nvim" })               -- Nord theme
	use({ "andersevenrud/nordic.nvim" })
	use({ "mjlbach/onedark.nvim", disabled = true }) -- Theme inspired by Atom
	use({ "folke/tokyonight.nvim" })
	use({
		"projekt0n/github-nvim-theme",
		config = function()
			vim.cmd("colorscheme github_dark")
		end,
	})

	-- Application
	-- use { 'rmagatti/auto-session', config = application.autosession }
	use({ "djoshea/vim-autoread" }) -- Auto-reload files from disk
	use({
		"sindrets/winshift.nvim",
		config = application.winshift.setup,
		keys = application.winshift.keys,
		event = "WinEnter",
	}) -- Winshift
	use({
		"willothy/flatten.nvim",
		config = function()
			require("flatten").setup({})
		end,
	})
	-- use { 'glepnir/dashboard-nvim', config = application.dashboard, event = "VimEnter", requires = {'nvim-tree/nvim-web-devicons'} }
	use({ "hood/popui.nvim", config = application.pop })

	-- mini
	use({ "echasnovski/mini.nvim", branch = "stable", config = mini_config.setup })

	-- Meme
	use({ "tamton-aquib/duck.nvim", config = editor.duck.setup, keys = editor.duck.keys })

	-- Editor pane
	use({ "numToStr/Comment.nvim", keys = { { "v", "gc" }, "gc" }, config = editor.comment })                     -- "gc" to comment visual regions/lines
	use({ "windwp/nvim-autopairs", event = "InsertEnter", config = editor.autopairs, module = "nvim-autopairs" }) -- Automatic bracket pairing
	use({ "kylechui/nvim-surround", tag = "*", event = "BufReadPost", config = editor.surround })                 -- We love this one
	use({ "phaazon/hop.nvim", branch = "v2", keys = editor.hop.keys, config = editor.hop.config })                -- hop
	use({ "abecodes/tabout.nvim", event = "InsertEnter", requires = { "nvim-treesitter" }, config = editor.tabout }) -- Tabout for getting out of autopairs
	use("kshenoy/vim-signature")                                                                                  -- Marks in the gutter
	use({ "folke/edgy.nvim", config = editor.edgy })

	-- Interface
	use({ "dnlhc/glance.nvim", config = editor.glance, event = "BufReadPost" }) -- Glance window for code
	use({
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<F1>", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })
		end,
	})
	use({ "folke/edgy.nvim", config = editor.edgy })
	use { "chrisgrieser/nvim-spider" }
	-- Interface
	use({ "nvim-lualine/lualine.nvim", config = interface.lualine })                                 -- Fancier statusline
	use({ "lukas-reineke/indent-blankline.nvim", event = "BufReadPost", config = interface.blankline }) -- Add indentation guides on blank lines
	use({
		"alvarosevilla95/luatab.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("luatab").setup()
		end,
	}) -- Tabline
	use({
		"s1n7ax/nvim-window-picker",
		tag = "v1.*",
		config = function()
			require("window-picker").setup()
		end,
	})
	use({ "folke/noice.nvim", config = interface.noice, requires = { "MunifTanjim/nui.nvim" } })
	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({})
			vim.api.keymap({ "n" }, function()
				vim.cmd([[ZenMode]])
			end, { desc = "Zen mode toggle", silent = true })
		end,
	})
	use({
		"folke/which-key.nvim",
		config = interface.which_key,
	})

	-- Neotree
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		config = interface.neotree,
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
	})

	-- Git
	use({ "tpope/vim-fugitive", config = git.fugitive.setup }) -- Git commands in nvim
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" }, config = git.gitsigns })
	
	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = { "nvim-lua/plenary.nvim" },
		keys = telescope.keys,
		config = telescope.setup,
		cmd = "Telescope",
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })
	
	-- Terminal
	use({ "akinsho/toggleterm.nvim", tag = "*", keys = terminal.toggleterm.keys, config = terminal.toggleterm.setup })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", tag = "*", config = ts.config, run = ":TSUpdate" }) -- Highlight, edit, and navigate code
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = { "nvim-treesitter" } })     -- Additional textobjects for treesitter
	use({
		"https://github.com/windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
		after = { "nvim-treesitter" },
	})

	-- Completion
	use({ "aduros/ai.vim" })
	use({
		"hrsh7th/nvim-cmp",
		requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "onsails/lspkind.nvim" },
		config = cmp.setup,
	})                                                                  -- Autocompletion
	use({ "L3MON4D3/LuaSnip", requires = { "saadparwaiz1/cmp_luasnip" } }) -- Snippet Engine and Snippet Expansion

	-- LSP
	use({ "williamboman/mason.nvim", config = lsp.mason })                                            -- Manage external editor tooling i.e LSP servers
	use({ "williamboman/mason-lspconfig.nvim", config = lsp.mason_lspconfig, after = { "mason.nvim" } }) -- Automatically install language servers to stdpath
	use({ "neovim/nvim-lspconfig", config = lsp.lspconfig })                                          -- Collection of configurations for built-in LSP client
	use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu", config = lsp.action_menu })
	use({ "jose-elias-alvarez/null-ls.nvim", config = lsp.null_ls })
	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
			vim.keymap.set("n", "<leader>q", function()
				vim.cmd([[TroubleToggle document_diagnostics]])
			end, { desc = "Toggle document diagnostics" })
			vim.keymap.set("n", "<leader>Q", function()
				vim.cmd([[TroubleToggle workspace_diagnostics]])
			end, { desc = "Toggle workspace diagnostics" })
		end,
	})
	use({ 'simrat39/symbols-outline.nvim', config = lsp.symboloutline })
	use({ 'mfussenegger/nvim-dap', config = lsp.dap })
	use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" }, config = lsp.dap_ui }
	use 'leoluz/nvim-dap-go'
	use 'David-Kunz/jester'

	-- FT-specific
	use({ "ellisonleao/glow.nvim", ft = { "markdown" }, config = ft_plugins.glow }) -- Markdown syntax control
	if is_bootstrap then
		require("packer").sync()
	end
end)

if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

require("opts")
require("mappings")
require("commands")
