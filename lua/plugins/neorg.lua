local M = {}

function M.setup()
	require("neorg").setup({
		load = {
			["core.defaults"] = {},
			["core.norg.concealer"] = {},
			["core.norg.dirman"] = {
	            config = {
	                workspaces = {
	                    work = "~/notes/work",
	                    home = "~/notes/home",
	                }
	            }
	        },
			["core.norg.completion"] = {
				engine = "nvim-cmp"
			}
		}
	})
end

return M
