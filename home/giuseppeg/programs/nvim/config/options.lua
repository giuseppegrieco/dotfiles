local opt = vim.opt

-- shows the effects of |:substitute|, |:smagic|,
-- |:snomagic| and user commands with the |:command-preview| flag as you type.
-- Shows the effects of a command incrementally in the
-- buffer and partial off-screen results in a preview window.
opt.inccommand = "split" 
-- print the line number in front of each line
opt.number = true
-- show relative line number in front of each line
opt.relativenumber = true
-- take indent for new line from previous line
opt.autoindent = true
-- smart autoindenting for C programs
opt.smartindent = true
-- use real tab characters, not spaces
opt.expandtab = false
-- how many columns a <Tab> renders as
opt.tabstop = 4
-- columns inserted/removed by <Tab>/<BS> in insert mode
opt.softtabstop = 4
-- columns used by autoindent and >>, <<
opt.shiftwidth = 4
-- long lines wrap and continue on the next line
opt.wrap = true
-- GUI: settings for cursor shape and blinking
opt.guicursor = ""
-- enable 24-bit RGB color in the TUI
opt.termguicolors = true
-- save undo information in a file
opt.undofile = true
-- where to store undo files
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- whether to use a swapfile for a buffer 
opt.swapfile = false
-- keep backup file after overwriting a file
opt.backup = false
-- highlight matches with last search pattern
opt.hlsearch = false
-- highlight match while typing search pattern
opt.incsearch = true
-- minimum nr. of lines above and below cursor
opt.scrolloff = 8
-- when and how to display the sign column
opt.signcolumn = "yes"
-- columns to highlight
opt.colorcolumn = "80"
-- how automatic formatting is to be done 
opt.formatoptions:remove "o"
-- no ignore case when pattern has uppercase
opt.smartcase = true
-- ignore case in search patterns 
opt.ignorecase = true
-- new window from split is below the current one
opt.splitbelow = true
-- new window is put right of the current one 
opt.splitright = true
-- use the clipboard as the unnamed register
opt.clipboard = "unnamedplus"
