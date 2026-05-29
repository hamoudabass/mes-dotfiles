-- 1. MAPLEADER EN PREMIER (avant tout le reste)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 2. Options (style Lua recommandé)
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.o.relativenumber = true

-- 3. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 4. Setup lazy.nvim
require("lazy").setup({
  spec = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

    -- Telescope
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    

    -- Treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      build = ':TSUpdate',
      opts = {
        ensure_installed = {
          "lua", "vim", "c", "python",
          "javascript", "typescript", "html", "css",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      },
    },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

vim.cmd.colorscheme("catppuccin")

-- Raccourcis Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Chercher fichiers" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Chercher dans fichiers" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Chercher buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Chercher aide" })

