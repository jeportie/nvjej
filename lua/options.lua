require "nvchad.options"

local o = vim.o

-------------------------------------- options ------------------------------------------

o.cursorlineopt ='both'

-- Indenting
o.expandtab = false
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = true

-- UI
o.scrolloff=8

-- Key mappings for setting the colorcolumn
vim.keymap.set("n", "<Leader>cc", ":set colorcolumn=80<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>ncc", ":set colorcolumn-=80<CR>", { noremap = true, silent = true })
