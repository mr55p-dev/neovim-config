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
			theme = "tokyonight",
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
	require("which-key").setup({})
end

return M
