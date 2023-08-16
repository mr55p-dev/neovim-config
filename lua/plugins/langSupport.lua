return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		config = function()
			-- configure neodev first
			require("neodev").setup()

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
			vim.keymap.set("n", "<C-.>", function()
				vim.cmd([[CodeActionMenu]])
			end, { silent = true, noremap = true, desc = "Code action" })

			vim.keymap.set("n", "<Leader>lf", function()
				vim.lsp.buf.format({
					filter = function(client)
						return client.name ~= "volar" and client.name ~= "tsserver"
					end,
				})
			end, { silent = true, noremap = true, desc = "Format buffer" })

			vim.keymap.set("n", "<leader>lm", "<cmd>Mason<CR>", { silent = false })

			-- Set mappings on attach
			lsp.on_attach(function(_, bufnr)
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
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm({
								behavior = cmp.ConfirmBehavior.Replace,
								select = false,
							})
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-e>"] = function(fallback)
						if cmp.visible() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
						else
							fallback()
						end
					end,
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "emoji" },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" },
				}, {
					{ name = "buffer" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "path", priority = 2 },
					{ name = "buffer", priority = 1 },
				},
			})

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			require("cmp_git").setup()

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
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" },
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "folke/neodev.nvim" },
			-- Completion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "petertriho/cmp-git" },
			{ "onsails/lspkind.nvim" },
			{ "hrsh7th/cmp-nvim-lua" },
			-- Snippets
			{"L3MON4D3/LuaSnip",},
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
			{ "gd", "<CMD>Glance definitions<CR>", desc = "Glance definition" },
			{ "gr", "<CMD>Glance references<CR>", desc = "Glance references" },
			{ "gy", "<CMD>Glance type_definitions<CR>", desc = "Glance type definition" },
			{ "gm", "<CMD>Glance implementations<CR>", desc = "Glance implementations" },
		},
	},
}
