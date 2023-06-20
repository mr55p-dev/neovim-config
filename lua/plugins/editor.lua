local M = {}

function M.comment()
	require("Comment").setup()
end

function M.autopairs()
	require("nvim-autopairs").setup()
end

function M.surround()
	require("nvim-surround").setup()
end

M.hop = {
	keys = {
		"f",
		"F",
		"t",
		"T",
		"<Leader>hw",
	},
}

function M.hop.config()
	local hop = require("hop")
	local directions = require("hop.hint").HintDirection
	vim.keymap.set("", "f", function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
	end, { remap = true })
	vim.keymap.set("", "F", function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
	end, { remap = true })
	vim.keymap.set("", "t", function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
	end, { remap = true })
	vim.keymap.set("", "T", function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
	end, { remap = true })
	vim.keymap.set("", "<Leader>hw", function()
		hop.hint_words()
	end, { remap = true })
	hop.setup({})
end

function M.tabout()
	require("tabout").setup({
		tabkey = "<Tab>",       -- key to trigger tabout, set to an empty string to disable
		backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
		act_as_tab = true,      -- shift content if tab out is not possible
		act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
		default_tab = "<C-t>",  -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
		default_shift_tab = "<C-d>", -- reverse shift default action,
		enable_backwards = true, -- well ...
		completion = true,      -- if the tabkey is used in a completion pum
		tabouts = {
			{ open = "'", close = "'" },
			{ open = '"', close = '"' },
			{ open = "`", close = "`" },
			{ open = "(", close = ")" },
			{ open = "[", close = "]" },
			{ open = "{", close = "}" },
		},
		ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
		exclude = {}, -- tabout will ignore these filetypes
	})
end

function M.glance()
	local glance = require("glance")
	local actions = glance.actions

	glance.setup({
		height = 18, -- Height of the window
		border = {
			enable = false, -- Show window borders. Only horizontal borders allowed
			top_char = "―",
			bottom_char = "―",
		},
	})

	vim.keymap.set("n", "gd", "<CMD>Glance definitions<CR>")
	vim.keymap.set("n", "gr", "<CMD>Glance references<CR>")
	vim.keymap.set("n", "gy", "<CMD>Glance type_definitions<CR>")
	vim.keymap.set("n", "gm", "<CMD>Glance implementations<CR>")
end

M.treesj = {
	keys = {
		"<Leader>ms",
		"<Leader>mj",
	},
}

function M.treesj.setup()
	require("treesj").setup({
		use_default_keymaps = false,
	})

	vim.keymap.set(
		"n",
		"<Leader>ms",
		"<cmd>TSJSplit<CR>",
		{ silent = true, desc = "Split all arguments onto their own lines" }
	)
	vim.keymap.set("n", "<Leader>mj", "<cmd>TSJJoin<CR>", { silent = true, desc = "Join all arguments to one line" })
end

M.fsread = {
	keys = {
		"<Leader>fr",
	},
}

function M.fsread.setup()
	vim.keymap.set("n", "<Leader>fr", function()
		vim.cmd("FSToggle")
	end, { silent = true, desc = "Toggle the fast reader state" })
	vim.keymap.set("n", "<Leader>fc", function()
		vim.cmd("FSClear")
	end, { silent = true, desc = "Clear the fast reader state" })
end

M.duck = {
	keys = {
		"<Leader>dd",
		"<Leader>dk",
	},
}

function M.duck.setup()
	vim.keymap.set("n", "<leader>dd", function()
		require("duck").hatch()
	end, {})
	vim.keymap.set("n", "<leader>dk", function()
		require("duck").cook()
	end, {})
end

function M.edgy()
	require("edgy").setup({
		animate = {
			enabled = false
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
			{
				ft = "help",
				size = { height = 20 },
				-- only show help buffers
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
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
			{ ft = "fugitive", size = { width = 0.25 } }
		}
	})

	vim.keymap.set("n", "<C-,>", function() require("edgy").open() end, { desc = "Show edgy bar" })
end

-- function M.ufo()
-- 	require("ufo").setup(
-- 		provider_selector = function(bufnr, filetype, buftype)
-- 			return "treesitter", "indent"
-- 		end,
-- 	)
-- end

return M
