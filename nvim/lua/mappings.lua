-- leader
vim.g.mapleader = " "

-- wq
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true })
vim.keymap.set("n", "<C-q>", ":q!<CR>", { noremap = true })

-- motion
vim.keymap.set("n", "<C-u>", "5<C-y>", { noremap = true })
vim.keymap.set("n", "<C-d>", "5<C-e>", { noremap = true })
vim.keymap.set("n", "<C-e>", "5j", { noremap = true })
vim.keymap.set("n", "<C-y>", "5k", { noremap = true })

-- window move
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })

-- highlight
vim.keymap.set("n", "<ESC>", "<ESC>:nohl<CR>")

-- convert \n
vim.api.nvim_set_keymap("n", "<leader>cn", [[:%s/\\n/\r/g<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ct", [[:%s/\\t/\t/g<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cx", [[:%s/,\n\s*/,/g<CR>]], { noremap = true, silent = true })

-- no macro
-- vim.api.nvim_set_keymap("n", "q", "<Nop>", { noremap = true, silent = true })

-- compare with master
vim.api.nvim_set_keymap("n", "<leader>cm", "<ESC>:DiffviewOpen origin/master<CR>", { noremap = true, silent = true })
