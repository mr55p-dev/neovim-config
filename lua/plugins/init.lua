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
		"folke/edgy.nvim",
		config = {
			animate = {
				enabled = false
			},
			options = {
				left = { size = 40 },
				right = { size = 40 },
			},
			bottom = {
				-- toggleterm / lazyterm at the bottom with a height of 40% of the screen
				{
					ft = "toggleterm",
					size = { height = 0.4 },
					-- exclude floating windows
					filter = function(buf, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
				{
					ft = "lazyterm",
					title = "LazyTerm",
					size = { height = 0.4 },
					filter = function(buf)
						return not vim.b[buf].lazyterm_cmd
					end,
				},
				"Trouble",
				{ ft = "qf",            title = "QuickFix" },
				{
					ft = "help",
					size = { height = 20 },
					-- only show help buffers
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
				{ ft = "spectre_panel", size = { height = 0.4 } },
			},
			left = {
				-- Neo-tree filesystem always takes half the screen height
				{
					title = "Neo-Tree",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
					size = { height = 0.5 },
				},
				{
					ft = "Outline",
					pinned = true,
					open = "SymbolsOutlineOpen",
				},
				{
					title = "Neo-Tree Git",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "git_status"
					end,
					pinned = true,
					open = "Neotree position=right git_status",
				},
				{
					title = "Neo-Tree Buffers",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "buffers"
					end,
					pinned = true,
					open = "Neotree position=top buffers",
				},
			},
			right = {
				{ ft = "fugitive", size = { width = 0.25 } }
			}
		},
		keys = {
			{ "<C-,>", function() require("edgy").open() end, desc = "Show edgy bar" },
		},
	},

	-- Interface
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
	{
		"mbbill/undotree",
		keys = {
			{ "<F1>", vim.cmd.UndotreeToggle, desc = "Toggle undo tree" }

		}
	},
	{
		"nvim-lualine/lualine.nvim",
		config = interface.lualine,
	}, -- Fancier statusline
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		config = interface.blankline,
	}, -- Add indentation guides on blank lines
	{
		"alvarosevilla95/luatab.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("luatab").setup()
		end,
	}, -- Tabline
	{
		"s1n7ax/nvim-window-picker",
		config = function()
			require("window-picker").setup()
		end,
	},
	{
		"folke/noice.nvim",
		config = interface.noice,
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({})
			vim.keymap.set({ "n" }, "<leader>zn", function()
				vim.cmd([[ZenMode]])
			end, { desc = "Zen mode toggle", silent = true })
		end,
	},
	{
		"folke/which-key.nvim",
		config = interface.which_key,
	},
	-- Neotree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		config = interface.neotree,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
	},
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
