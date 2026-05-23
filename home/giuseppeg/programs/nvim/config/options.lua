-- print the line number in front of each line
vim.opt.number = true;
-- show relative line number in front of each line
vim.opt.relativenumber = true;
-- take indent for new line from previous line
vim.opt.autoindent = true;
-- smart autoindenting for C programs
vim.opt.smartindent = true;
-- long lines wrap and continue on the next line
vim.opt.wrap = true;
-- GUI: settings for cursor shape and blinking
vim.opt.guicursor = "";
-- enable 24-bit RGB color in the TUI
vim.opt.termguicolors = true;
-- save undo information in a file
vim.opt.undofile = true;
-- where to store undo files
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir";
-- whether to use a swapfile for a buffer 
vim.opt.swapfile = false;
-- keep backup file after overwriting a file
vim.opt.backup = false;
-- highlight matches with last search pattern
vim.opt.hlsearch = false;
-- highlight match while typing search pattern
vim.opt.incsearch = true;
-- minimum nr. of lines above and below cursor
vim.opt.scrolloff = 8;
-- when and how to display the sign column
vim.opt.signcolumn = "yes";
-- columns to highlight
vim.opt.colorcolumn = "80";

