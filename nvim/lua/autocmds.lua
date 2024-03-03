local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- refresh 
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- lazy 
vim.api.nvim_set_keymap('n', '<leader>lz', ':Lazy<CR>', {noremap = true, silent = true})

-- undo dir
vim.cmd([[
silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set ul=2000
	set undofile
	set undodir=$HOME/.config/nvim/tmp/undo,.
endif
]])

-- git blame
function GitBlameCurrentAndFollowingLines()
    local lnum = vim.fn.line('.')
    local start = math.max(1, lnum - 10)
    local finish = math.min(vim.fn.line('$'), lnum + 10)
    local cmd = string.format("!git blame -L%d,%d %s", start, finish, vim.fn.expand('%'))
    vim.api.nvim_command(cmd)
end
vim.api.nvim_set_keymap('n', '<leader>gb', ':lua GitBlameCurrentAndFollowingLines()<CR>', {noremap = true, silent = true})


-- neo-tree focus
local firstTime = true
function NeotreeWithCtrlL()
	-- cuz first time foucs bug? must foucs twice on first can work
    if firstTime then
    	vim.api.nvim_input(':Neotree action=focus reveal_force_cwd=true<CR>')
        vim.api.nvim_input('<C-l>')
        firstTime = false
    end
    vim.api.nvim_input(':Neotree action=focus reveal_force_cwd=true<CR>')
end
vim.keymap.set('n', '<leader>o', ':lua NeotreeWithCtrlL()<CR>')


-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- auto open neo-tree
vim.api.nvim_create_augroup("neotree_autoopen", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
  desc = "Open neo-tree on enter",
  group = "neotree_autoopen",
  callback = function()
	if not vim.g.neotree_opened then
	  vim.cmd "Neotree show"
	  vim.g.neotree_opened = true
	end
  end,
})


-- if insert init auto pair with cmp once
local setup_autopairs_called = false
function setup_autopairs()
  if not setup_autopairs_called then
	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	local cmp = require('cmp')
	cmp.event:on(
  		'confirm_done',
  	cmp_autopairs.on_confirm_done()
	)
    setup_autopairs_called = true
  end
end
vim.cmd('autocmd InsertEnter * lua setup_autopairs()')

