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

	-- mini
	{
		"echasnovski/mini.nvim",
		branch = "stable",
		config = function()
			require('mini.ai').setup()
			require('mini.bufremove').setup()
			require('mini.cursorword').setup()
			require('mini.splitjoin').setup()
			require('mini.basics').setup({ windows = true })
			require('mini.starter').setup({})

			local session = require('mini.sessions')
			local function close_nvim_tree() require 'neo-tree.sources.manager'.close_all() end
			session.setup({
				auto_write = true,
				hooks = {
					pre = {
						read = close_nvim_tree,
						write = close_nvim_tree,
					}
				}
			}
			)
		end,
	},

	-- Meme
	{
		"tamton-aquib/duck.nvim",
		keys = {
			{ "<leader>dd", function() require("duck").hatch() end, desc = "Hatch a duck" },
			{ "<leader>dk", function() require("duck").cook() end,  desc = "Cook a duck" },
		},
	},
}
