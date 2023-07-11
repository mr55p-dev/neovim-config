local editor = require("plugins.editor")
local interface = require("plugins.interface")
local application = require("plugins.application")
local ts = require("plugins.treesitter")
local git = require("plugins.git")
local terminal = require("plugins.terminal")
local telescope = require("plugins.telescope")
local cmp = require("plugins.cmp")
local lsp = require("plugins.lsp")
local mini_config = require("plugins.mini_config")

return {
	-- Color schemes
	"shaunsingh/nord.nvim", -- Nord theme
	"andersevenrud/nordic.nvim",
	{
		"mjlbach/onedark.nvim",
		disabled = true,
	}, -- Theme inspired by Atom
	"folke/tokyonight.nvim",
	{
		"projekt0n/github-nvim-theme",
		config = function()
			vim.cmd("colorscheme github_dark")
		end,
	},

	-- Application
	-- use { 'rmagatti/auto-session', config = application.autosession }
	"djoshea/vim-autoread", -- Auto-reload files from disk
	{
		"sindrets/winshift.nvim",
		config = application.winshift.setup,
		keys = application.winshift.keys,
		event = "WinEnter",
	}, -- Winshift
	{
		"willothy/flatten.nvim",
		config = function()
			require("flatten").setup({})
		end,
	},
	{
		"hood/popui.nvim",
		config = application.pop,
	},

	-- mini
	{
		"echasnovski/mini.nvim",
		branch = "stable",
		config = mini_config.setup,
	},

	-- Meme
	{
		"tamton-aquib/duck.nvim",
		keys = {
			{ "<leader>dd", function() require("duck").hatch() end, desc = "Hatch a duck" },
			{ "<leader>dk", function() require("duck").cook() end,  desc = "Cook a duck" },
		},
	},

	{
		"dnlhc/glance.nvim",
		config = {
			height = 18,
			border = {
				enable = false
			},
		},
		keys = {
			{ "gd", "<CMD>Glance definitions<CR>",      desc = "Glance definition" },
			{ "gr", "<CMD>Glance references<CR>",       desc = "Glance references" },
			{ "gy", "<CMD>Glance type_definitions<CR>", desc = "Glance type definition" },
			{ "gm", "<CMD>Glance implementations<CR>",  desc = "Glance implementations" },
		},
		event = "BufReadPost",
	}, -- Glance window for code
	-- Git
	{
		"tpope/vim-fugitive",
		config = git.fugitive.setup,
	}, -- Git commands in nvim
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = git.gitsigns,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = telescope.keys,
		config = telescope.setup,
		cmd = "Telescope",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = vim.fn.executable("make") == 1,
	}, -- Terminal
	{
		"akinsho/toggleterm.nvim",
		keys = terminal.toggleterm.keys,
		config = terminal.toggleterm.setup,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = ts.config,
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			{
				"https://github.com/windwp/nvim-ts-autotag",
				config = function()
					require("nvim-ts-autotag").setup()
				end,
			},
		},
	}, -- Highlight, edit, and navigate code

	-- Completion
	"aduros/ai.vim",
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "onsails/lspkind.nvim" },
		config = cmp.setup,
	}, -- Autocompletion
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "saadparwaiz1/cmp_luasnip" },
	}, -- Snippet Engine and Snippet Expansion
	-- LSP
	{
		"williamboman/mason.nvim",
		config = lsp.mason,
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				config = lsp.mason_lspconfig,
			}, -- Automatically install language servers to stdpath
		},
	}, -- Manage external editor tooling i.e LSP servers
	{
		"neovim/nvim-lspconfig",
		config = lsp.lspconfig,
	}, -- Collection of configurations for built-in LSP client
	{ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu", config = lsp.action_menu },
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = lsp.null_ls,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = lsp.symboloutline,
	},
	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
			vim.keymap.set("n", "<leader>q", function()
				vim.cmd([[TroubleToggle document_diagnostics]])
			end, { desc = "Toggle document diagnostics" })
			vim.keymap.set("n", "<leader>Q", function()
				vim.cmd([[TroubleToggle workspace_diagnostics]])
			end, { desc = "Toggle workspace diagnostics" })
		end,
	},
}
