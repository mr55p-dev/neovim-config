return {
	{
		"mr55p-dev/jobber.nvim",
	-- 	dir = "~/Git/jobber.nvim",
	-- 	dev = true,
		opts = {
			layouts = {
				["Pagemail"] = { "make -C server run", "make -C client run" },
				["GOL UI"] = { "nvm use && npm run start", "proxy_on && nvm use && npm run ui-dev-proxy" },
				["GOL storybook"] = { "proxy_on && nvm use && npm run ui-dev-proxy", "nvm use && npm run storybook" },
				["GOL all"] = { "nvm use && npm run start", "proxy_on && nvm use && npm run ui-dev-proxy",
					"nvm use && npm run storybook" }
			},
		},
		keys = {
			{ "<leader>jj", function() require'jobber'.pick_layout() end, desc = "Open Jobber" },
		},
		dependencies = {
			"pianocomposer321/consolation.nvim",
		},
	},
}
