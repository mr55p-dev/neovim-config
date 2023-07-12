return{
	{
		"akinsho/toggleterm.nvim",
		lazy= true,
		keys = {
			{
				[[<C-\>]],
				mode = { "n", "v", "t", "i" },
			}
		},
		config = {
			open_mapping = [[<C-\>]],
			-- shade_terminals = false,
		}
	},
}
