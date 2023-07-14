return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = vim.fn.executable("make") == 1,
				config = function()
					require("telescope").load_extension("fzf")
				end,
			}, -- Terminal
		},
		opts = {
			defaults = {
				mappings = {
					i = {
						['<C-u>'] = false,
						['<C-d>'] = false,
					},
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			local function selector(items, opts, on_choice)
				local theme = require("telescope.themes").get_dropdown()
				local pickers = require("telescope.pickers")
				local actions = require("telescope.actions")
				on_choice = vim.schedule_wrap(on_choice)
				pickers.new(opts.telescope, {
					prompt_title = opts.prompt,
					previewer = false,
					finder = require("telescope.finders").new_table({
						results = items,
						entry_maker = function(item)
							local formatted = opts.format_item(item)
							return {
								display = formatted,
								ordinal = formatted,
								value = item,
							}
						end,
						sorter = require('telescope.config').values.generic_sorter(opts),
						attach_mappings = function(prompt_bufnr)
							actions.select_default:replace(function()
								local selection = require("telescope.actions.state").get_selected_entry()
								local callback = on_choice
								on_choice = function(_, _) end
								actions.close(prompt_bufnr)
								if not selection then
									callback(nil, nil)
									return
								end
								local idx = nil
								for i, item in ipairs(items) do
									if item == selection.value then
										idx = i
										break
									end
								end
								callback(selection.value, idx)
							end)

							actions.close:enhance({
								post = function()
									on_choice(nil, nil)
								end
							})

							return true
						end
					})
				}):find()
			end
			vim.ui.select = selector
		end,
		lazy = false,
		priority = 10000,
		cmd = "Telescope",
		keys = {
			{
				"<leader><space>",
				function() require('telescope.builtin').git_files({ hidden = true }) end,
				desc = "Find git files"
			},
			{
				[[<leader>/]],
				function()
					require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes')
						.get_dropdown { previewer = false, })
				end,
				desc = "[/] Fuzzily search in current buffer]"
			},
			{
				"<leader>sf",
				function() require('telescope.builtin').find_files() end,
				desc = "[S]earch [F]iles"
			},
			{
				"<leader>sb",
				function() require('telescope.builtin').buffers() end,
				desc = "[S]earch [B]uffers"
			},
			{
				"<leader>so",
				function() require('telescope.builtin').oldfiles() end,
				desc = "[S]earch [O]ld"
			},
			{
				"<leader>sd",
				function() require('telescope.builtin').lsp_document_symbols() end,
				desc = "[S]earch [D]ocument"
			},
			{
				"<leader>ss",
				function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
				desc = "[S]earch [S]ymbols"
			},
			{
				"<leader>sw",
				function() require('telescope.builtin').grep_string() end,
				desc = "[S]earch current [W]ord"
			},
			{
				"<leader>sg",
				function() require('telescope.builtin').live_grep() end,
				desc = "[S]earch by [G]rep"
			},
			{
				"<leader>sr",
				function() require('telescope.builtin').resume() end,
				desc = "[S]earch [R]esume"
			},
			{
				"<leader>sh",
				function() require('telescope.builtin').help_tags() end,
				desc = "[S]earch [H]elp"
			},
			-- {
			-- 	"<C-p>",
			-- 	function() vim.cmd [[Telescope]] end,
			-- 	desc = "All commands"
			-- },
			{
				"<C-A-p>",
				function() require('telescope.builtin').commands() end,
				desc = "All commands"
			},
		}
	},
}
