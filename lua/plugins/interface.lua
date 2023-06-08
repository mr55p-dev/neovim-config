local M = {}

function M.lualine()
	-- Override 'encoding': Don't display if encoding is UTF-8.
	local encoding = function()
		local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
		return ret
	end
	-- fileformat: Don't display if &ff is unix.
	local fileformat = function()
		local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
		return ret
	end

	require("lualine").setup({
		options = {
			icons_enabled = true,
			-- theme = "tokyonight",
			component_separators = "|",
			section_separators = "",
		},
		sections = {
			lualine_c = {
				{ "filename", path = 1 },
			},
			lualine_x = { "filetype", "windows", "tabs" },
			lualine_y = { encoding(), "progress", fileformat() },
		},
	})
end

function M.neotree()
	vim.cmd("let g:neo_tree_remove_legacy_commands = 1")

	require("neo-tree").setup({
		close_if_last_window = true,
		open_files_do_not_replace_types = { "Trouble", "qf", "edgy" },
		filesystem = {
			follow_current_file = true,
		},
	})

	vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>Neotree left toggle<CR>", { silent = true })
	vim.api.nvim_set_keymap("n", "<C-A-n>", "<cmd>Neotree float toggle<CR>", { silent = true })
end

function M.codewindow()
	local codewindow = require("codewindow")
	codewindow.setup({})
	codewindow.apply_default_keybinds()
end

function M.blankline()
	require("indent_blankline").setup({
		char = "┊",
		show_trailing_blankline_indent = false,
	})
end

function M.noice()
	require("noice").setup({
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false,  -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
	})
end

function M.which_key()
	vim.o.timeout = true
	vim.o.timeoutlen = 300
	require("which-key").setup({
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		-- add operators that will trigger motion and text object completion
		-- to enable all native operators, set the preset / operators plugin above
		-- operators = { gc = "Comments" },
		key_labels = {
			-- override the label used to display some keys. It doesn't effect WK in any other way.
			-- For example:
			-- ["<space>"] = "SPC",
			["<leader>"] = "SPC",
			-- ["<cr>"] = "RET",
			-- ["<tab>"] = "TAB",
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "rounded", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 0,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3,           -- spacing between columns
			align = "center",      -- align columns left, center or right
		},
	})
end

return M
