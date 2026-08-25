require("config.remote_clipboard").setup()
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Números relativos: tornam os movimentos (5j, 3dd, d7k) legíveis de relance.
-- Combinado com number = true (default do LazyVim) dá "hybrid line numbers".
vim.opt.relativenumber = true

-- Permite que um projecto tenha o seu próprio .nvim.lua / .exrc.
-- `secure` impede que esse ficheiro corra shell commands ou autocmds.
vim.opt.exrc = true
vim.opt.secure = true

-- Formatação ao gravar (infra do LazyVim; alternar com <leader>uf / <leader>uF)
vim.g.autoformat = true
