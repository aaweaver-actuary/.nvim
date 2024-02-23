-- Auto-install packer if not exists
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- Auto-install nvim-tree if not exists
local tree_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/nvim-tree.lua'
if vim.fn.empty(vim.fn.glob(tree_path)) > 0 then
  vim.fn.execute('!gh repo clone nvim-tree/nvim-tree.lua ' .. tree_path)
  vim.cmd [[packadd nvim-tree.lua]]
end

-- Auto-install feline if not exists
local feline_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/feline.nvim'
if vim.fn.empty(vim.fn.glob(feline_path)) > 0 then
  vim.fn.execute('!gh repo clone feline-nvim/feline.nvim ' .. feline_path)
  vim.cmd [[packadd feline.nvim]]
end

-- Auto-install ALE if not exists
local ale_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/ale'
if vim.fn.empty(vim.fn.glob(ale_path)) > 0 then
  vim.fn.execute('!gh repo clone dense-analysis/ale ' .. ale_path)
  vim.cmd [[packadd ale]]
end

-- Auto-install copilot if not exists
local copilot_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/copilot.vim'
if vim.fn.empty(vim.fn.glob(copilot_path)) > 0 then
  vim.fn.execute('!gh repo clone github/copilot.vim ' .. copilot_path)
  vim.cmd [[packadd copilot.vim]]
end

-- Auto-install nvim-lspconfig if not exists
local lspconfig_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/nvim-lspconfig'
if vim.fn.empty(vim.fn.glob(lspconfig_path)) > 0 then
  vim.fn.execute('!gh repo clone neovim/nvim-lspconfig ' .. lspconfig_path)
  vim.cmd [[packadd nvim-lspconfig]]
end
