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

	{
		"akinsho/toggleterm.nvim",
		keys = terminal.toggleterm.keys,
		config = terminal.toggleterm.setup,
	},

}
