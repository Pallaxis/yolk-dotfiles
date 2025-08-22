-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- TODO: Not working, afaik it's supposed to remove the inline nags from linters and let you hover instead
-- vim.diagnostic.config({
--   virtual_text = false,
--   signs = true,
--   float = { border = "single" },
-- })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Leader binds for copying/putting/deleting to system clipboard
-- Yank
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "[Y]ank to EOL to system clipboard" })
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "[Y]ank whole line to system clipboard" })
-- Put
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]ut from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "[P]ut from system clipboard" })
-- Delete
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "[D]elete to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>D", '"+D', { desc = "[D]elete to EOL to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>dd", '"+dd', { desc = "[D]elete to system clipboard" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Some terminals have coliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- vim: ts=2 sts=2 sw=2 et
