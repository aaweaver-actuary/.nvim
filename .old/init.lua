-- init.lua configuration for Neovim
-- Load auto_install.lua, plugins.lua, and settings.lua
require('plugins')
require('auto_install')
require('settings')
require('feline')

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- NERDTree alternative in Lua
  use 'nvim-tree/nvim-tree.lua'

  -- ALE for linting and formatting
  use 'dense-analysis/ale'

  -- GitHub Copilot
  use 'github/copilot.vim'

  -- Feline statusline in Lua
  use 'feline-nvim/feline.nvim'
end)

-- Nvim-tree setup
require('nvim-tree').setup()

-- Other configurations translated to Lua
vim.o.laststatus = 2
vim.g.python3_host_prog = '/usr/src/app/.venv/bin/python'
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.tabstop = 4
