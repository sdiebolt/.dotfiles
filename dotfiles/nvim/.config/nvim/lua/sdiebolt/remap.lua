vim.g.mapleader = " "

-- Exit terminal mode
vim.keymap.set("t", "<leader><ESC>", "<C-\\><C-n>")

-- Move lines up and down in visual mode.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in place when joining lines.
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in place when moving up/down using C-d/C-u.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in place when searching forward/backward.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without replacing the register.
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Delete without replacing the register.
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Yank to clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Avoid repetitions.
vim.keymap.set("n", "Q", "<nop>")

-- Move faster in quickfix.
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Interactive search and replace.
vim.keymap.set("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace interactively" })

-- Save file.
vim.keymap.set("n", "<leader>w", ":w<CR>")
