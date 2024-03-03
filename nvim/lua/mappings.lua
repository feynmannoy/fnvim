-- leader
vim.g.mapleader = " "

-- wq
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true })
vim.keymap.set("n", "<C-q>", ":q!<CR>", { noremap = true })

-- motion
vim.keymap.set("n", "<C-u>", "10<C-y>", { noremap = true })
vim.keymap.set("n", "<C-d>", "10<C-e>", { noremap = true })

-- window move
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })

-- lsp
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- highlight
vim.keymap.set('n', '<ESC>', '<ESC>:nohl<CR>')

