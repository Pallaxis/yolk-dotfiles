-- Misc binds
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" }) -- Diagnostic keymaps
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" }) -- For exiting terminal mode

-- Leader binds for copying/putting/deleting to system clipboard
-- Yank
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+y$', { desc = "[Y]ank to EOL to system clipboard" })
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "[Y]ank whole line to system clipboard" })
-- Put
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]ut from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "[P]ut from system clipboard" })
-- Delete
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "[D]elete to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d$", '"+D', { desc = "[D]elete to EOL to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>dd", '"+dd', { desc = "[D]elete to system clipboard" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Allows quick visual indenting
vim.keymap.set({ "v" }, "<", "<gv", { desc = "Keeps visual selection after quick indent" })
vim.keymap.set({ "v" }, ">", ">gv", { desc = "Keeps visual selection after quick indent" })

-- Allows moving entire selections
vim.keymap.set({ "v" }, "J", ":m '>+1<CR>gv=gv")
vim.keymap.set({ "v" }, "K", ":m '<-2<CR>gv=gv")

-- vim: ts=2 sts=2 sw=2 et
