-- ~/.config/nvim/init.lua

-- Add Lazy Neovim to runtime path
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/site/pack/packer/start/lazy.nvim")

-- Define plugins and Lazy Neovim setup
require("lazy").setup({
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    {
      "baliestri/aura-theme",
      lazy = false,
      priority = 1000,
      config = function(plugin)
        vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
        vim.cmd([[colorscheme aura-dark]])
      end
    }
})

-- Additional Neovim settings and key mappings