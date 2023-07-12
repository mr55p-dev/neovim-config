return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		config = function()
			local lsp = require("lsp-zero").preset({})

			---- LSP setup
			-- Set some global mappings
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			vim.keymap.set(
				"n",
				"<Leader>ca",
				vim.lsp.buf.code_action,
				{ silent = true, noremap = true, desc = "Code action" }
			)
			vim.keymap.set(
				"n",
				"<C-.>",
				function() vim.cmd([[CodeActionMenu]]) end,
				{ silent = true, noremap = true, desc = "Code action" }
			)

			vim.keymap.set("n", "<Leader>lf", function()
				vim.lsp.buf.format({
					filter = function(client)
						return client.name ~= "volar" and client.name ~= "tsserver"
					end,
				})
			end, { silent = true, noremap = true, desc = "Format buffer" })

			-- Set mappings on attach
			lsp.on_attach(function(client, bufnr)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				local function setOpts(description)
					return { noremap = true, silent = true, buffer = bufnr, desc = description }
				end

				vim.keymap.set("n", "K", vim.lsp.buf.hover, setOpts("Lsp hover"))
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "<Leader>K", vim.lsp.buf.signature_help, setOpts("Show signature"))
				vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.type_definition, setOpts("Goto type definition"))
				vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, setOpts("Rename symbol"))
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, setOpts("Rename symbol"))
			end)

			-- Complete LSP setup
			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
			lsp.setup()


			---- Nvim cmp setup
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			cmp.setup({
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.abort()
						elseif cmp.visible then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({
								behavior = cmp.ConfirmBehavior.Replace,
								select = true,
							})
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback) end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp", priority = 3 },
					{ name = "buffer",   priority = 1 },
					{ name = "path",     priority = 2 },
					{ name = "emoji",    priority = 0 },
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					}),
				},
			})
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "path",   priority = 2 },
					{ name = "buffer", priority = 1 },
				},
			})

			---- Null LS
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.code_actions.eslint_d,
					null_ls.builtins.code_actions.refactoring,
					null_ls.builtins.diagnostics.checkmake,
					null_ls.builtins.diagnostics.commitlint,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.diagnostics.jsonlint,
					null_ls.builtins.diagnostics.sqlfluff.with({
						extra_args = { "--dialect", "snowflake" }, -- change to your dialect
					}),
					null_ls.builtins.diagnostics.yamllint,

					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.codespell,
					null_ls.builtins.formatting.prettier_eslint,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.sqlfluff.with({
						extra_args = { "--dialect", "snowflake" }, -- change to your dialect
					}),
					null_ls.builtins.formatting.terraform_fmt,
				},
			})
		end,
		dependencies = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ 'williamboman/mason-lspconfig.nvim' },
			{ "jose-elias-alvarez/null-ls.nvim", },
			-- Completion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-emoji" },
			{ "onsails/lspkind.nvim" },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lua' },

			-- Snippets
			{
				"L3MON4D3/LuaSnip",
				keys = function()
					return {}
				end,
			},
			{ 'rafamadriz/friendly-snippets' },
		}
	},

	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
		keys = {
			{
				"<C-.>",
				function()
					vim.cmd([[CodeActionMenu]])
				end,
				mode = { "n", "i" },
				desc = "Code actions",
			},
		},
	},
	{
		"simrat39/symbols-outline.nvim",
		config = true,
		cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
		keys = {
			{
				"<leader>do",
				function()
					vim.cmd([[SymbolsOutline]])
				end,
				desc = "Show symbol outline",
				silent = true,
			},
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = true,
		keys = {
			{
				"<leader>q",
				function()
					vim.cmd([[TroubleToggle document_diagnostics]])
				end,
				desc = "Toggle document diagnostics",
			},
			{
				"<leader>Q",
				function()
					vim.cmd([[TroubleToggle workspace_diagnostics]])
				end,
				desc = "Toggle workspace diagnostics",
			},
		},
	},
	{
		"dnlhc/glance.nvim",
		config = {
			height = 18,
			border = {
				enable = false,
			},
		},
		keys = {
			{ "gd", "<CMD>Glance definitions<CR>",      desc = "Glance definition" },
			{ "gr", "<CMD>Glance references<CR>",       desc = "Glance references" },
			{ "gy", "<CMD>Glance type_definitions<CR>", desc = "Glance type definition" },
			{ "gm", "<CMD>Glance implementations<CR>",  desc = "Glance implementations" },
		},
	},

}
