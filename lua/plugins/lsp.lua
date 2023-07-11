local M = {}

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
end


function M.dap()
	local dap = require('dap')
	require('dap-go').setup()
	require('jester').setup({
		path_to_jest_run = "./node_modules/jest/bin/jest.js",
		path_to_jest_debug = "./node_modules/jest/bin/jest.js",
		terminal_cmd = ":split | terminal",
	})
	vim.keymap.set("n", "<leader>jr", function() require "jester".run() end, { desc = "Jester run nearest" })
	vim.keymap.set("n", "<leader>jR", function() require "jester".run_last() end, { desc = "Jester rerun last" })
	vim.keymap.set("n", "<leader>jf", function() require "jester".run_file() end, { desc = "Jester run file" })
	vim.keymap.set("n", "<leader>jd", function() require "jester".debug_file() end, { desc = "Jester debug nearest" })

	vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Continue debug adapter" })
	vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
end

function M.dap_ui()
	local dapui = require('dapui')
	dapui.setup()
	vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Open debugger UI" })
end

return {


}
