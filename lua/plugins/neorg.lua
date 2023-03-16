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
				config = {
					engine = "nvim-cmp"
				}
			},
			["core.presenter"] = {
				config = {
					zen_mode = "zen-mode"
				}
			}
		}
	})
	vim.keymap.set('n', '<Leader>nc', function() vim.cmd[[Neorg toggle-concealer]] end, { silent = true })
end

return M
