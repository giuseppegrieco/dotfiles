vim.g.mapleader = " "
vim.g.maplocalleader = " "

local set = vim.keymap.set

-- open netwr
set("n", "<leader>pv", vim.cmd.Ex)
-- move to the left split
set("n", "<c-j>", "<c-w><c-j>")
-- move to the split below
set("n", "<c-k>", "<c-w><c-k>")
-- move to the split above
set("n", "<c-l>", "<c-w><c-l>")
-- move to the right split
set("n", "<c-h>", "<c-w><c-h>")
-- go to previous tab
set("n", "<left>", "gT")
-- go to next tab
set("n", "<right>", "gt")
-- jump to next error
set("n", "]d", vim.diagnostic.goto_next)
-- jump to previous error
set("n", "[d", vim.diagnostic.goto_prev)
-- decrease window width
set("n", "<M-,>", "<c-w>5<")
-- increase window width
set("n", "<M-.>", "<c-w>5>")
-- decrease window height
set("n", "<M-t>", "<C-W>+")
-- increase window height
set("n", "<M-s>", "<C-W>-")
-- move to the left split
set("n", "<c-j>", "<c-w><c-j>")
