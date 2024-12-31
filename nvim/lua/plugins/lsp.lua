-- local Language configurations
-- available lsp server :
-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers

-- <language,lsp>
local lanlspMap = {
	py = {
		lsp = "pyright",
		lsp_setup = function()
			require("lspconfig").pyright.setup({})
		end,
	},
	java = {
		lsp = "jdtls",
		lsp_setup = function()
			require("lspconfig").jdtls.setup({ filetypes = { "java" } })
		end,
	},
	js = {
		lsp = "volar",
		lsp_setup = function()
			require("lspconfig").volar.setup({
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				init_options = {
					vue = {
						hybridMode = false,
					},
				},
			})
		end,
	},
	vue = {
		lsp = "volar",
		lsp_setup = function()
			require("lspconfig").volar.setup({
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				init_options = {
					vue = {
						hybridMode = false,
					},
				},
			})
		end,
	},
	lua = {
		lsp = "lua_ls",
		lsp_setup = function()
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	},
	sh = {
		lsp = "bashls",
		lsp_setup = function()
			require("lspconfig").bashls.setup({})
		end,
	},
	go = {
		lsp = "gopls",
		lsp_setup = function()
			require("lspconfig").gopls.setup({})
		end,
	},
	cpp = {
		lsp = "clangd",
		lsp_setup = function()
			require("lspconfig").clangd.setup({})
		end,
	},
	json = {
		lsp = "jsonls",
		lsp_setup = function()
			require("lspconfig").jsonls.setup({})
		end,
	},
	thrift = {
		lsp = "thrift",
		lsp_setup = function()
			require("lspconfig").thriftls.setup({})
		end,
	},
	sql = {
		lsp = "sqlls",
		lsp_setup = function()
			require("lspconfig").sqlls.setup({})
		end,
	},
}

-- setup lsp function
local trees_done = false
local setup_done = {} -- Set to track setup status
function setup_lsp(language)
	local lang = lanlspMap[language]
	if not setup_done[lang.lsp] then
		-- lsp
		lang.lsp_setup()
		if not trees_done then
			-- treesitter
			require("nvim-treesitter.configs").setup({})
			-- lint
			require("null-ls")
			trees_done = true
		end
		setup_done[lang.lsp] = true
	end
end

-- auto setup lsp for language
for language, _ in pairs(lanlspMap) do -- Iterate over keys
	local autocmd = string.format("autocmd BufNewFile,BufReadPre *.%s lua setup_lsp('%s')", language, language)
	vim.cmd(autocmd)
end

-- LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- icon
		local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		-- options
		-- vim.lsp.buf.format({ timeout_ms = 100 })
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- keymapping
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "<space>d", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", function()
			require("telescope.builtin").lsp_references()
		end, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
			-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		end, opts)
	end,
})

return {
	{
		-- lsp manger
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {},
	},
	{
		-- lspconfig
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	{
		-- format
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			return {
				null_ls.setup({
					sources = {
						-- supports format :
						-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
						null_ls.builtins.formatting.gofmt,
						null_ls.builtins.formatting.goimports,
						null_ls.builtins.formatting.jq.with({
							extra_args = { "--tab-width", "4", "--use-tabs", "false" },
						}),
						null_ls.builtins.formatting.clang_format.with({
							extra_args = {
								"--style",
								"{BasedOnStyle: llvm, IndentWidth: 4, TabWidth: 4, UseTab: Never, BreakBeforeBraces: Attach, AllowShortFunctionsOnASingleLine: None}",
							},
						}),
						null_ls.builtins.formatting.stylua,
						null_ls.builtins.formatting.shfmt,
						-- null_ls.builtins.diagnostics.cspell.with({ filetypes = { "go" }, }),
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
		end,
	},
}
