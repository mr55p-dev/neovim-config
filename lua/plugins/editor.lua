return {
	"kshenoy/vim-signature", -- Marks in the gutter
	"aduros/ai.vim",      -- Ai completion
	{
		"numToStr/Comment.nvim",
		keys = { { "gc", mode = "v" }, { "gcc" } },
		config = {
			hook = function()
				require("ts_context_commentstring.internal").update_commentstring()
			end,
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" }
	}, -- "gc" to comment visual regions/lines
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		module = { "nvim-autopairs" },
	}, -- Automatic bracket pairing
	{
		"kylechui/nvim-surround",
		event = "BufReadPost",
		config = true,
	}, -- We love this one
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
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
			end, { remap = true, desc = "Hop to any word" })
			hop.setup({})
		end,
		keys = {
			"f",
			"F",
			"t",
			"T",
			"<Leader>hw",
		},
	}, -- hop
	{
		"abecodes/tabout.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			tabkey = "<Tab>",
			backwards_tabkey = "<S-Tab>",
			act_as_tab = true,
			act_as_shift_tab = false,
			default_tab = "<C-t>",
			default_shift_tab = "<C-d>",
			enable_backwards = true,
			completion = true,
			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
				{ open = "{", close = "}" },
			},
			ignore_beginning = true,
			exclude = {},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"hcl",
					"go",
					"lua",
					"javascript",
					"markdown",
					"markdown_inline",
					"python",
					"regex",
					"rust",
					"sql",
					"terraform",
					"typescript",
					"tsx",
					"vim",
				},
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = "<c-s>",
						node_decremental = "<c-backspace>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["ia"] = "@parameter.inner",
							["il"] = { query = "@assignment.lhs", desc = "Assignment LHS" },
							["ir"] = { query = "@assignment.rhs", desc = "Assignment RHS" },
							["ie"] = {
								query = { "@conditional.inner", "@loop.inner" },
								desc = "Inner loop or coditional",
							},
							["ae"] = {
								query = { "@conditional.inner", "@loop.inner" },
								desc = "Outer loop or conditional",
							},
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					swap = {
						enable = false,
					},
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
			})
		end,
		build = ":TSUpdate",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	}, -- Highlight, edit, and navigate code
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"https://github.com/nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = true,
	},
	{
		"https://github.com/windwp/nvim-ts-autotag",
		config = true,
	},
	{
		"RishabhRD/nvim-cheat.sh",
		cmd = { "Cheat", "CheatWithoutComments" },
		dependencies = { "RishabhRD/popfix" }
	}
}
