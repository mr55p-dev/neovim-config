local M = {}

function M.mason()
	require("mason").setup({
		ui = {
			border = "single",
		},
	})

	vim.keymap.set("n", "<Leader>lm", "<cmd>:Mason<CR>", { silent = true, desc = "Open mason" })
end

function M.mason_lspconfig()
	require("mason-lspconfig").setup({
		ensure_installed = { "clangd", "rust_analyzer", "pyright", "html", "cssls", "tsserver", "lua_ls", "sqlls" },
		automatic_installation = true,
	})
end

function M.lspconfig()
	-- Mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

	vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { silent = true, noremap = true, desc = "Code action" })
	vim.keymap.set("n", "<C-.>", function()
		vim.cmd([[CodeActionMenu]])
	end, { silent = true, noremap = true, desc = "Code action" })
	vim.keymap.set("n", "<Leader>lf", function()
		vim.lsp.buf.format({
			filter = function(client)
				return client.name ~= "volar"
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

	--Enable (broadcasting) snippet capability for completion
	local css_capabilities = vim.lsp.protocol.make_client_capabilities()
	css_capabilities.textDocument.completion.completionItem.snippetSupport = true

	require("lspconfig")["cssls"].setup({
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = css_capabilities,
	})
end

function M.signature()
end

function M.null_ls()
	local null_ls = require("null-ls")

	null_ls.setup({
		sources = {
			null_ls.builtins.completion.spell,

			null_ls.builtins.code_actions.eslint_d,
			null_ls.builtins.code_actions.refactoring,
			null_ls.builtins.code_actions.gitsigns,

			null_ls.builtins.diagnostics.checkmake,
			null_ls.builtins.diagnostics.commitlint,
			null_ls.builtins.diagnostics.eslint_d,
			null_ls.builtins.diagnostics.jsonlint,
			null_ls.builtins.diagnostics.sqlfluff.with({
				extra_args = { "--dialect", "snowflake" }, -- change to your dialect
			}),
			null_ls.builtins.diagnostics.yamllint,

			null_ls.builtins.formatting.eslint_d,
			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.codespell,
			null_ls.builtins.formatting.prettier.with({
				filetypes = {
					"vue",
					"css",
					"scss",
					"less",
					"html",
					"json",
					"jsonc",
					"yaml",
					"markdown",
					"markdown.mdx",
					"graphql",
					"handlebars",
				},
			}),
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.sqlfluff.with({
				extra_args = { "--dialect", "snowflake" }, -- change to your dialect
			}),
			null_ls.builtins.formatting.terraform_fmt,
		},
	})
end

function M.action_menu()
	vim.keymap.set({ "n", "i" }, "<C-.>", function()
		vim.cmd([[CodeActionMenu]])
	end, { desc = "Code actions" })
end

return M
