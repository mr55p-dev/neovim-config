-- LSP
return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
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
			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(_, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				local function setOpts(description)
					return { noremap = true, silent = true, buffer = bufnr, desc = description }
				end
				vim.keymap.set("n", "K", vim.lsp.buf.hover, setOpts("Lsp hover"))
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "<Leader>K", vim.lsp.buf.signature_help, setOpts("Show signature"))
				-- vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
				-- vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
				-- vim.keymap.set("n", "<Leader>wl", function()
				-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				-- end, bufopts)
				vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.type_definition, setOpts("Goto type definition"))
				vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, setOpts("Rename symbol"))
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, setOpts("Rename symbol"))
			end

			local lsp_flags = {
				-- This is the default in Nvim 0.7+
				debounce_text_changes = 150,
			}

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("lspconfig")["pyright"].setup({
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			})

			require("lspconfig")["rust_analyzer"].setup({
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			})

			require("lspconfig")["sqlls"].setup({
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			})

			require("lspconfig")["tsserver"].setup({
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			})

			require("lspconfig")["lua_ls"].setup({
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			require("lspconfig")["terraform_lsp"].setup({
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			})

			require("lspconfig")["html"].setup({
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			})

			require("lspconfig")["gopls"].setup({
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			})

			--Enable (broadcasting) snippet capability for completion
			local css_capabilities = vim.lsp.protocol.make_client_capabilities()
			css_capabilities.textDocument.completion.completionItem.snippetSupport = true

			require("lspconfig")["cssls"].setup({
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = css_capabilities,
			})
		end,
	}, -- Collection of configurations for built-in LSP client
	{
		"williamboman/mason.nvim",
		config = {
			ui = {
				border = "single",
			},
		},
		keys = {
			{ "<Leader>lm", "<cmd>:Mason<CR>", silent = true, desc = "Open mason" },
		},
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				config = {
					ensure_installed = {
						"clangd",
						"gopls",
						"rust_analyzer",
						"pyright",
						"html",
						"cssls",
						"tsserver",
						"lua_ls",
						"sqlls",
					},
					automatic_installation = true,
				},
			}, -- Automatically install language servers to stdpath
		},
	}, -- Manage external editor tooling i.e LSP servers
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
		"jose-elias-alvarez/null-ls.nvim",
		config = {
			sources = {
				require("null-ls").builtins.code_actions.eslint_d,
				require("null-ls").builtins.code_actions.refactoring,

				require("null-ls").builtins.diagnostics.checkmake,
				require("null-ls").builtins.diagnostics.commitlint,
				require("null-ls").builtins.diagnostics.eslint_d,
				require("null-ls").builtins.diagnostics.jsonlint,
				require("null-ls").builtins.diagnostics.sqlfluff.with({
					extra_args = { "--dialect", "snowflake" }, -- change to your dialect
				}),
				require("null-ls").builtins.diagnostics.yamllint,

				require("null-ls").builtins.formatting.black,
				require("null-ls").builtins.formatting.codespell,
				require("null-ls").builtins.formatting.prettier_eslint,
				require("null-ls").builtins.formatting.prettier,
				require("null-ls").builtins.formatting.stylua,
				require("null-ls").builtins.formatting.sqlfluff.with({
					extra_args = { "--dialect", "snowflake" }, -- change to your dialect
				}),
				require("null-ls").builtins.formatting.terraform_fmt,
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
			{ "gd", "<CMD>Glance definitions<CR>", desc = "Glance definition" },
			{ "gr", "<CMD>Glance references<CR>", desc = "Glance references" },
			{ "gy", "<CMD>Glance type_definitions<CR>", desc = "Glance type definition" },
			{ "gm", "<CMD>Glance implementations<CR>", desc = "Glance implementations" },
		},
		event = "BufReadPost",
	}, -- Glance window for code
}
