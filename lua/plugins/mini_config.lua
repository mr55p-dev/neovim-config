local M = {}

function M.setup()
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
end

return M
