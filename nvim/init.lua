-- bootstrap lazy.nvim apenas se NÃO estivermos no VS Code (opcional)
if not vim.g.vscode then
    require("config.lazy")
end

-- Definir o Leader como Space (essencial estar no topo)
vim.g.mapleader = " "

-- Bloco específico para VS Code
if vim.g.vscode then
    local vscode = require('vscode-neovim')

    -- Atalhos de Navegação (Buffers/Tabs no VS Code)
    vim.keymap.set('n', '<S-h>', function() vscode.action('workbench.action.previousEditor') end)
    vim.keymap.set('n', '<S-l>', function() vscode.action('workbench.action.nextEditor') end)

    -- Splits (v e s)
    vim.keymap.set('n', '<leader>v', function() vscode.action('workbench.action.splitEditor') end)
    vim.keymap.set('n', '<leader>s', function() vscode.action('workbench.action.splitEditorDown') end)

    -- Mudar entre Panes (Focus)
    vim.keymap.set('n', '<leader>h', function() vscode.action('workbench.action.focusLeftGroup') end)
    vim.keymap.set('n', '<leader>j', function() vscode.action('workbench.action.focusBelowGroup') end)
    vim.keymap.set('n', '<leader>k', function() vscode.action('workbench.action.focusAboveGroup') end)
    vim.keymap.set('n', '<leader>l', function() vscode.action('workbench.action.focusRightGroup') end)

    -- Comandos Rápidos (Usando as funções nativas do VS Code)
    vim.keymap.set('n', '<leader>w', function() vscode.action('workbench.action.files.save') end)
    vim.keymap.set('n', '<leader>q', function() vscode.action('workbench.action.closeActiveEditor') end)

    -- QuickOpen e Formatação
    vim.keymap.set('n', '<leader>f', function() vscode.action('workbench.action.quickOpen') end)
    vim.keymap.set('n', '<leader>p', function() vscode.action('editor.action.formatDocument') end)

    -- Visual Mode: Manter seleção ao indentar
    vim.keymap.set('v', '<', '<gv')
    vim.keymap.set('v', '>', '>gv')

    -- Comentários
    vim.keymap.set('v', '<leader>c', function() vscode.action('editor.action.commentLine') end)
end
