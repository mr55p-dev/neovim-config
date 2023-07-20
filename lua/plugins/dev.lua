return {
	{
		"mr55p-dev/jobber.nvim",
		opts = {
			layouts = {
				["Pagemail"] = { "make -C server run", "make -C client run" },
				["GOL UI"] = { "npm run start", "npm run ui-dev-proxy-prod" },
				["GOL storybook"] = {"npm run start", "npm run ui-dev-proxy-prod", "npm run storybook"}
			},
		},
		dependencies = {
			"pianocomposer321/consolation.nvim",
		},
	},
}
