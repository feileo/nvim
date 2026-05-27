require "nvchad.mappings"

local nomap = vim.keymap.del

nomap("n", "<C-n>")
nomap("i", "<C-e>")
nomap("n", "<C-s>")
nomap("n", "<C-c>")
nomap("t", "<C-x>")
nomap("n", "<A-i>")
nomap("t", "<A-i>")
nomap("n", "<leader>b")
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap("n", "<leader>/")
nomap("v", "<leader>/")
nomap("n", "<leader>e")
nomap("n", "<leader>n")
nomap("n", "<leader>wK")
nomap("n", "<leader>wk")
nomap("n", "<leader>rn")
nomap("n", "<leader>fm")
nomap("n", "<leader>ma")
nomap("n", "<leader>fz")
nomap("n", "<leader>cm")
nomap("n", "<leader>ds")
nomap("n", "<leader>gt")
nomap("n", "<leader>ch")
nomap("n", "<leader>pt")
nomap("n", "<leader>th")

local map = vim.keymap.set

map({ "n" }, "<C-i>", "<C-i>", { noremap = true, silent = true }) -- 恢复 <C-i> 的默认跳转行为
map({ "n" }, "q", "<nop>", { noremap = true, silent = true })
map({ "n" }, "@", "q", { desc = "macro recording start/stop", noremap = true, silent = true })
map({ "n" }, "Q", "@", { desc = "macro execute", noremap = true, silent = true })

map({ "x" }, "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "command dont copy replaced text" })

map({ "n", "i" }, "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map({ "n", "i" }, "<C-n>", "<End>", { desc = "move end of line" })
map({ "n" }, "<C-]>", "z4l", { desc = "move right 4 line" })
map({ "n" }, "<C-[>", "z4h", { desc = "move left 4 line" })
map({ "v" }, "<C-k>", ":move-2<CR>gv", { desc = "move lines up" })
map({ "v" }, "<C-j>", ":move'>+<CR>gv", { desc = "move lines down" })
map({ "v" }, "<C-h>", "<gv", { desc = "move lines left" })
map({ "v" }, "<C-l>", ">gv", { desc = "move lines right" })

map({ "n" }, ";", ":", { desc = "command enter command mode" })
map({ "n" }, "<C-q>", "<cmd>q<CR>", { desc = "command quit vim" })
map({ "n" }, "<C-c>", "<cmd>CloseWindow<CR>", { desc = "command close window" })
map({ "n" }, "<A-q>", "<cmd>ExitSafe<CR>", { desc = "command quit vim" })

-- map({ 'n' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map({ 'n' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true, silent = true })
map({ "n", "x" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true, silent = true })
map({ "n", "v" }, "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true, silent = true })
map({ "n", "v" }, "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true, silent = true })

-- buffers and windows
map("n", "<leader>w", "<cmd>update<CR>", { desc = "buffer save buffer" })
map("n", "<leader>W", "<cmd>wa<CR>", { desc = "buffer save all buffer" })
map("n", "<leader>x", function() require("nvchad.tabufline").close_buffer() end, { desc = "buffer close buffer" })
map("n", "<leader>X", function() require("nvchad.tabufline").closeAllBufs() end, { desc = "buffer close other" })
map("n", "<tab>", function() require("nvchad.tabufline").next() end, { desc = "buffer goto next" })
map("n", "<S-tab>", function() require("nvchad.tabufline").prev() end, { desc = "buffer goto prev" })
-- map("n", "<tab>", ":bnext<CR>", { desc = "buffer goto next", silent = true })
-- map("n", "<S-tab>", ":bprevious<CR>", { desc = "buffer goto prev", silent = true })
map("n", "<leader><tab>", "<cmd>Telescope buffers<CR>", { desc = "buffer list" })

-- nvimtree
map("n", "'", "<cmd>NvimTreeToggle<CR>", { desc = "toggle nvimtree window" })
-- map("n", "\"", "<cmd>NvimTreeFocus<CR>", { desc = "toggle focus nvimtree window" })
map("n", '"', "<cmd>NvimTreeFocus<CR>", { desc = "toggle focus nvimtree window" })

-- telescope
-- map("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "telescope find files" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "telescope find files" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "telescope find all files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "telescope find keymaps" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "telescope find commands" })
map("n", "<leader>ft", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "telescope find words" })

map("n", "<leader>ss", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>sw", ":<C-U><C-R>=printf('Telescope live_grep default_text=%s', expand('<cword>'))<CR><CR>", { desc = "telescope live grep cursor word" })
map("n", "<leader>sd", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "telescope find lsp document symbols" })

map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })

map("n", "<leader>th", function() require("nvchad.themes").open() end, { desc = "telescope nvchad themes" })

-- terminal
-- map("n", "<leader>h", function() require("nvchad.term").new { pos = "sp" } end, { desc = "terminal new horizontal term" })
-- map("n", "<leader>v", function() require("nvchad.term").new { pos = "vsp" } end, { desc = "terminal new vertical term" })
map({ "n", "t" }, "<A-m>", function() require("nvchad.term").toggle { pos = "float", id = "floatTerm" } end, { desc = "terminal toggle floating term" })
map({ "n", "t" }, "<A-s>", function() require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" } end, { desc = "terminal toggleable horizontal term" })
map({ "n", "t" }, "<A-v>", function() require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" } end, { desc = "terminal toggleable vertical term" })
-- map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("t", "<C-c>", "<C-d><cmd>q<CR>", { desc = "terminal close terminal" })

-- interestingwords
map("n", "<A-i>", "<cmd>Interestingwords --toggle<CR>", { desc = "interestingwords toggle" })
map("n", "<A-I>", "<cmd>Interestingwords --remove_all<CR>", { desc = "interestingwords remove all" })

-- translator
map("n", "<leader>t", function() return require("pantran").motion_translate() end, { expr = true, noremap = true, desc = "translate motion" })
map("n", "<leader>tt", function() return require("pantran").motion_translate() .. "_" end, { expr = true, noremap = true, desc = "translate line" })
map("x", "<leader>t", function() return require("pantran").motion_translate() end, { expr = true, noremap = true, desc = "translate selection" })

-- flash: toggle labels during native search (press <C-s> while in / search)
map("c", "<C-s>", function() require("flash").toggle() end, { desc = "flash toggle search" })
