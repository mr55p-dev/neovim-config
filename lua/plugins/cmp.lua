local M = {}

function M.setup()
	-- nvim-cmp setup
	local cmp = require 'cmp'
	local luasnip = require 'luasnip'
	local lspkind = require('lspkind')
	local cmp_autopairs = require('nvim-autopairs.completion.cmp')

	cmp.setup {
	snippet = {
		expand = function(args)
		luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		-- ['<C-Space>'] = cmp.mapping.complete {},
		['<C-Space>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.abort()
			elseif cmp.visible then
				cmp.complete()
			else
				fallback()
			end
		end, { 'i', 's' }),
		-- ['<CR>'] = cmp.mapping.confirm {
		-- behavior = cmp.ConfirmBehavior.Replace,
		-- select = true,
		-- },
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm { select = true }
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		-- ['<ESC>'] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.abort()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { 'i', 's' })
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		-- { name = "buffer" },
		-- { name = "path" },
	},
	formatting = {
			format = lspkind.cmp_format{
				mode = 'symbol', -- show only symbol annotations
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

				-- The function below will be called before any actual modifications from lspkind
				-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
				-- before = function (entry, vim_item)
				-- 	...
				-- 	return vim_item
				-- end
			}
	}
	}

	cmp.event:on(
		'confirm_done',
		cmp_autopairs.on_confirm_done()
	)

	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})

end

return M