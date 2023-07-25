return {
	{
		"mr55p-dev/jobber.nvim",
		opts = {
			layouts = {
				["Pagemail"] = { "make -C server run", "make -C client run" },
				["GOL UI"] = { "nvm use && npm run start", "nvm use && npm run ui-dev-proxy-prod" },
				["GOL storybook"] = { "nvm use && npm run ui-dev-proxy-prod", "nvm use && npm run storybook" },
				["GOL all"] = { "nvm use && npm run start", "nvm use && npm run ui-dev-proxy-prod",
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
