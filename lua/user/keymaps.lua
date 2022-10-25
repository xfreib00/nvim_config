-- Mode guide:
--      normal mode = "n",
--      visual mode = "v",
--      visual block mode = "x"
--      insert mode = "i",
--      terminal mode = "t",
--      command mode = "c"

-- set options
local opts = { noremap = true, silent = true }

-- set terminal options
local term_opts = { silent = true }

-- alias for mapping function
local keymap = vim.api.nvim_set_keymap

-- remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NORMAL MODE
-- remap window hopping keys
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resize window
keymap("n", "<M-j>", ":resize -2<CR>", opts)
keymap("n", "<M-k>", ":resize +2<CR>", opts)
keymap("n", "<M-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<M-l>", ":vertical resize +2<CR>", opts)

-- enable/disable spellcheck
keymap("n", "<leader>s", ":set spell!", opts)

-- enable tree
keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Fix spelling for current word
keymap("n", "<leader>f", "1z=", opts)

-- switch buffers
keymap("n", "<TAB>", ":bnext<CR>", opts)
keymap("n", "<S-TAB>", ":bprevious<CR>", opts)

-- INSERT MODE
-- use jk combination instead of escape
keymap("i", "jk", "<Esc>", opts)

-- VISUAL MODE
-- keep selection while tabbing
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move up and down selected text
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- keep clipboard buffer after paste
keymap("v", "p", '"_dP', opts)

-- VISUAL BLOCK
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)