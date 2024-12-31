local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- refresh
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- lazy
vim.api.nvim_set_keymap("n", "<leader>lz", ":Lazy<CR>", { noremap = true, silent = true })

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
	local lnum = vim.fn.line(".")
	local start = math.max(1, lnum)
	local finish = math.min(vim.fn.line("$"), lnum + 10)
	local cmd = string.format("!git blame -L%d,%d %s", start, finish, vim.fn.expand("%"))
	vim.api.nvim_command(cmd)
end

vim.api.nvim_set_keymap(
	"n",
	"<leader>gb",
	":lua GitBlameCurrentAndFollowingLines()<CR>",
	{ noremap = true, silent = true }
)

-- neo-tree focus
local firstTime = true
function NeotreeWithCtrlL()
	-- cuz first time foucs bug? must foucs twice on first can work
	if firstTime then
		vim.api.nvim_input(":Neotree action=focus reveal_force_cwd=true<CR>")
		vim.api.nvim_input("<C-l>")
		firstTime = false
	end
	vim.api.nvim_input(":Neotree action=focus reveal_force_cwd=true<CR>")
end

vim.keymap.set("n", "<leader>o", ":lua NeotreeWithCtrlL()<CR>")

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
-- vim.api.nvim_create_augroup("neotree_autoopen", { clear = true })
-- vim.api.nvim_create_autocmd("BufRead", {
--   desc = "Open neo-tree on enter",
--   group = "neotree_autoopen",
--   callback = function()
-- 	if not vim.g.neotree_opened then
-- 	  vim.cmd "Neotree show"
-- 	  vim.g.neotree_opened = true
-- 	end
--   end,
-- })

-- if insert init auto pair with cmp once
local setup_autopairs_called = false
function setup_autopairs()
	if not setup_autopairs_called then
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		setup_autopairs_called = true
	end
end

vim.cmd("autocmd InsertEnter * lua setup_autopairs()")

-- create Function to convert snake_case to CamelCase func
local function snake_to_camel_case()
	local word = vim.fn.expand("<cword>")
	local parts = vim.split(word, "_")
	for i, part in ipairs(parts) do
		parts[i] = part:sub(1, 1):upper() .. part:sub(2)
	end
	local camel = table.concat(parts)
	vim.api.nvim_command("normal! ciw" .. camel)
end
vim.api.nvim_create_user_command("SnakeToCamel", snake_to_camel_case, {})
vim.api.nvim_set_keymap("n", "<leader>tc", ":SnakeToCamel<CR>", { noremap = true, silent = true })

-- create Function to convert CamelCase to snake_case func
local function pascal_to_snake(word)
	local snake = word:gsub("(%u)", "_%1"):lower()
	return snake:gsub("^_", "")
end
local function replace_word_under_cursor()
	local current_word = vim.fn.expand("<cword>")
	local snake_case_word = pascal_to_snake(current_word)
	vim.cmd("normal! ciw" .. snake_case_word)
end
vim.api.nvim_create_user_command("PascalToSnake", replace_word_under_cursor, {})
vim.api.nvim_set_keymap("n", "<leader>ts", ":PascalToSnake<CR>", { noremap = true, silent = true })

-- 自动插入 C++ 模板
vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.cpp",
	callback = function()
		local template_path = vim.fn.expand("~/.config/nvim/templates/cpp_template.cpp")
		local template_content = vim.fn.readfile(template_path)
		if template_content then
			vim.api.nvim_buf_set_lines(0, 0, -1, false, template_content)
			vim.api.nvim_win_set_cursor(0, { 9, 5 })
		else
			print("Error: Could not read template file.")
		end
	end,
})

-- 为 go 文件设置 <F2> 键映射 run main.go
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "<F2>", "<ESC>:term go run *.go<CR>", { noremap = true, silent = true })
	end,
})

-- 为 cpp 文件设置 <F2> 键映射 run a.cpp
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<F2>",
			"<ESC>:term g++ -std=c++11 -g -o a a.cpp && ./a<CR>i",
			{ noremap = true, silent = true }
		)
	end,
})
