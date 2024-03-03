-- Language configurations
local languages = {
	{
		language = "go",
		setup_done = false,
		lsp_setup = function()
			local lspconfig = require('lspconfig')
			lspconfig.gopls.setup {}
			require("nvim-treesitter.configs").setup {}
			require("null-ls")
		end
	},
	{
		language = "cpp",
		setup_done = false,
		lsp_setup = function()
			local lspconfig = require('lspconfig')
			lspconfig.clangd.setup {}
			require("nvim-treesitter.configs").setup {}
			require("null-ls")
		end
	},
}

-- setup LSP for each language
function setup_lsp(language)
	for _, lang in ipairs(languages) do
		if lang.language == language and not lang.setup_done then
			lang.lsp_setup()
			lang.setup_done = true
		end
	end
end
for _, lang in ipairs(languages) do
	local autocmd = string.format("autocmd BufReadPre *.%s lua setup_lsp('%s')", lang.language, lang.language)
	vim.cmd(autocmd)
end

-- lsp config 
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
	-- icon    
	local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
	for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
	-- keymapping
	vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
	local opts = { buffer = ev.buf }
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
	vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', 'gr', function() require("telescope.builtin").lsp_references() end , opts)
	vim.keymap.set('n', '<space>f', function()
	vim.lsp.buf.format { async = true }
	end, opts)
  end,
})

return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			-- format
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			return {
				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.gofmt,
						null_ls.builtins.formatting.goimports,
					},
					on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false }) 
							end,
						})
					end
					end,
				}),
			}
		end
	}
}
