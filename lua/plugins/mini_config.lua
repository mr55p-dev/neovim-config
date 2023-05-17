local M = {}

-- maps
vim.keymap.set('n', '<leader>Sw', function() require('mini.sessions').write() end, { desc = "write session" })
vim.keymap.set('n', '<leader>Sr', function() require('mini.sessions').read() end, { desc = "read session" })

local function basics()
	require('mini.basics').setup({
		windows = true,
	})
end

local function starter()
	require('mini.starter').setup({

	})
end

local function sessions()
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


function M.setup()
	require('mini.ai').setup()
	require('mini.bufremove').setup()
	require('mini.cursorword').setup()
	require('mini.splitjoin').setup()

	basics()
	starter()
	sessions()
end

return M
