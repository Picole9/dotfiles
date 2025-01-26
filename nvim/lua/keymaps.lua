-- quit
vim.keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "[W]rite [Q]uit" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "[W]rite" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "[Q]uit" })
vim.keymap.set("n", "<leader>q!", ":q!<CR>", { desc = "[Q]uit without save" })
vim.keymap.set("n", "<leader>q1", ":q!<CR>", { desc = "[Q]uit without save" })
-- abbrev
vim.cmd("cnoreabbrev Q q")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev WQ wq")
-- back to normal mode
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
-- file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "[File] [N]ew" })
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "[S]ave file" })
-- number
vim.keymap.set("n", "<F5>", ":set number! relativenumber!<CR>")
-- tab visual mode
vim.keymap.set("v", "<Tab>", ">gv", { desc = "tab right" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "tab left" })
-- Move to window
vim.keymap.set({ "n", "t" }, "<C-Left>", "<cmd>wincmd h<cr>", { desc = "Go to left window", remap = true })
vim.keymap.set({ "n", "t" }, "<C-Down>", "<cmd>wincmd j<cr>", { desc = "Go to lower window", remap = true })
vim.keymap.set({ "n", "t" }, "<C-Up>", "<cmd>wincmd k<cr>", { desc = "Go to upper window", remap = true })
vim.keymap.set({ "n", "t" }, "<C-Right>", "<cmd>wincmd l<cr>", { desc = "Go to right window", remap = true })
-- Resize window
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
-- buffers
vim.keymap.set("n", "<S-Left>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-Right>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
-- IDE-view
vim.keymap.set("n", "<F2>", function()
	require("codewindow").toggle_minimap()
	vim.cmd("Neotree toggle")
	vim.cmd("Trouble diagnostics toggle")
	vim.cmd("TagbarToggle")
end, { desc = "IDE-View" })
