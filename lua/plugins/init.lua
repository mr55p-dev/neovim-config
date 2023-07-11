local terminal = require("plugins.terminal")
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
		"akinsho/toggleterm.nvim",
		keys = terminal.toggleterm.keys,
		config = terminal.toggleterm.setup,
	},

}
