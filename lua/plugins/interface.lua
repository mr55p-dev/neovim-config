return {
	{
		"folke/edgy.nvim",
		config = {
			animate = {
				enabled = false,
			},
			options = {
				left = { size = 40 },
				right = { size = 40 },
			},
			bottom = {
				-- toggleterm / lazyterm at the bottom with a height of 40% of the screen
				{
					ft = "toggleterm",
					size = { height = 0.4 },
					-- exclude floating windows
					filter = function(buf, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
				{
					ft = "lazyterm",
					title = "LazyTerm",
					size = { height = 0.4 },
					filter = function(buf)
						return not vim.b[buf].lazyterm_cmd
					end,
				},
				"Trouble",
				{ ft = "qf",            title = "QuickFix" },
				{ ft = "spectre_panel", size = { height = 0.4 } },
			},
			left = {
				-- Neo-tree filesystem always takes half the screen height
				{
					title = "Neo-Tree",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
					size = { height = 0.5 },
				},
				{
					ft = "Outline",
					pinned = true,
					open = "SymbolsOutlineOpen",
				},
				{
					title = "Neo-Tree Git",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "git_status"
					end,
					pinned = true,
					open = "Neotree position=right git_status",
				},
				{
					title = "Neo-Tree Buffers",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "buffers"
					end,
					pinned = true,
					open = "Neotree position=top buffers",
				},
			},
			right = {
				{ ft = "fugitive", size = { width = 0.25 } },
			},
		},
		lazy = false,
		keys = {
			{
				"<C-,>",
				function()
					require("edgy").open()
				end,
				desc = "Show edgy bar",
			},
		},
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<F1>", vim.cmd.UndotreeToggle, desc = "Toggle undo tree" },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
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
					lualine_x = { "filetype" },
					lualine_y = { encoding(), "progress", fileformat() },
				},
			})
		end,
	}, -- Fancier statusline
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		config = {
			char = "┊",
			show_trailing_blankline_indent = false,
		},
	}, -- Add indentation guides on blank lines
	{
		"alvarosevilla95/luatab.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = true,
	}, -- Tabline
	{
		"s1n7ax/nvim-window-picker",
		config = true,
	},
	{
		"folke/noice.nvim",
		config = {
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
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({})
			vim.keymap.set({ "n" }, "<leader>zn", function()
				vim.cmd([[ZenMode]])
			end, { desc = "Zen mode toggle", silent = true })
		end,
	},
	{
		"folke/which-key.nvim",
		config = {
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
					operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator
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
				["<space>"] = "SPC",
				["<leader>"] = "SPC",
				["<cr>"] = "CR",
				["<tab>"] = "TAB",
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
				spacing = 3,        -- spacing between columns
				align = "center",   -- align columns left, center or right
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		config = {
			close_if_last_window = true,
			open_files_do_not_replace_types = { "Trouble", "qf", "edgy" },
			filesystem = {
				follow_current_file = {
					enabled = true
				},
			},
			window = {
				width = 60,
			},
		},
		keys = {
			{ "<C-n>",   "<cmd>Neotree left toggle<CR>",  silent = true, desc = "Toggle Neotree" },
			{ "<C-A-N>", "<cmd>Neotree float toggle<CR>", silent = true, desc = "Toggle Neotree float" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
	},
	{
		"mrjones2014/legendary.nvim",
		priority = 10000,
		lazy = false,
		keys = {
			{ "<C-p>", "<cmd>Legendary<CR>", mode = { "n", "v", "i" } },
		},
	},
	{
		"stevearc/dressing.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {
			input = {
				enabled = false,
			},
			select = {
				enabled = true,
				backend = "telescope",
				-- telescope = require('telescope.themes').get_dropdown()
			},
		},
	},
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = true,
		cmd = "ChatGPT",
		keys = {
			{ "<leader>ch", function() vim.cmd [[ChatGPT]] end, silent = true, desc = "ChatGPT" }
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim"
		}
	},
	{
		'ThePrimeagen/harpoon',
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		keys = {
			{ "<leader>am", function() require("harpoon.mark").add_file() end, desc = "Add to harpoon"},
			{ "<leader>al", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Open harpoon menu"},
			{ "<leader>aj", function() require("harpoon.ui").nav_next() end, desc = "Cycle next harpoon file"},
			{ "<leader>ak", function() require("harpoon.ui").nav_prev() end, desc = "Cycle prev harpoon file"},
		}
	}
}
