return {
	"aduros/ai.vim",
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "saadparwaiz1/cmp_luasnip" },
			}, -- Snippet Engine and Snippet Expansion
		},
		config = function()
			-- nvim-cmp setup
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			local lspkind = require("lspkind")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
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
					-- ['<CR>'] = cmp.mapping.confirm {
					-- behavior = cmp.ConfirmBehavior.Replace,
					-- select = true,
					-- },
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({
								behavior = cmp.ConfirmBehavior.Replace,
								select = false,
							})
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					-- ['<ESC>'] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.abort()
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, { 'i', 's' })
				}),
				sources = {
					{ name = "nvim_lsp", priority = 3 },
					-- { name = "copilot", group_index = 2 },
					-- { name = "luasnip" },
					{ name = "buffer", priority = 1 },
					{ name = "path", priority = 2 },
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
					{ name = "path", priority = 2 },
					{ name = "buffer", priority = 1 },
				},
			})
		end,
	}, -- Autocompletion
}
