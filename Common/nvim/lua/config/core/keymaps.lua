vim.g.mapleader = " "

local keymap = vim.keymap
keymap.set("n", "<Leader>ch", ":nohl<CR>", { desc = "Clear search highlights" })

-- System Clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]], { desc = "Copy Selection to System Clipboard" })
vim.keymap.set("n", "<Leader>Y", [["+Y]], { desc = "Copy Line to System Clipboard" })
vim.keymap.set("n", "<Leader>p", [["+p]], { desc = "Paste from System Clipboard" })

-- Move Block
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", { desc = "Move Block Up" })
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", { desc = "Move Block Down" })

-- Improve Page Navigation
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join Current line with Previous Line" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump Down by Half-page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump Up by a Half-page" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Find next match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Find previous match" })
vim.keymap.set("n", "*", "*zzv", { desc = "Find next match" })
vim.keymap.set("n", "#", "#zzv", { desc = "Find previous match" })

-- Improve Quickfix Navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Split Management
keymap.set("n", "<Leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<Leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<Leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<Leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase Horizontal Split Size" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease Horizontal Split Size" })
keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", { desc = "Increase Vertical Split Size" })
keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", { desc = "Descrease Vertical Split Size" })

-- Tab Mangemenet
keymap.set("n", "<Leader>to", "<cmd>tabnew<CR>", { desc = "Open new Tab" })
keymap.set("n", "<Leader>tx", "<cmd>tabclose<CR>", { desc = "Close Current Tab" })
keymap.set("n", "<Leader>tn", "<cmd>tabn<CR>", { desc = "Go to next Tab" })
keymap.set("n", "<Leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous Tab" })
keymap.set("n", "<Leader>tf", "<cmd>tabnew %<CR>", { desc = "Open Current file in new Tab" })

vim.keymap.set("n", "<S-q>", "<NOP>")
