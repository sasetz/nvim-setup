-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- file find mappings
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sp', require('telescope').extensions.projects.projects, { desc = '[S]earch [P]rojects' })
vim.keymap.set('n', '<leader>st', ':TodoTelescope<cr>', { desc = '[S]earch [T]odo' })

-- display errors under cursor
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Diagnostics: Previous' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Diagnostics: Next' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostics' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- check cheatsheets
vim.keymap.set('n', '<leader>cs', ':Cheatsheet<cr>', { desc = 'Open cheatsheet', silent = true, noremap = true })

-- align items by characters
vim.keymap.set({ 'n', 'v' }, '<leader>tt', ':Tabularize /=<cr>',
  { desc = '[T]abularize by = signs', silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>ts', ':Tabularize /\zs<cr>',
  { desc = '[T]abularize by first [S]pace signs', silent = true, noremap = true })

-- TODO: add binds for managing multiple windows and tabs
-- switch tabs
vim.keymap.set('n', '<C-Tab>', ':tabn<cr>',
  { desc = 'Next tab', silent = true, noremap = true })
vim.keymap.set('n', '<C-S-Tab>', ':tabp<cr>',
  { desc = 'Previous tab', silent = true, noremap = true })

-- open tab
vim.keymap.set('n', '<leader>ot', ':tab split<cr>',
  { desc = '[O]pen new [T]ab', silent = true, noremap = true })

-- [[ PANELS AND USEFUL STUFF ]]

-- 1. open file broswer
vim.keymap.set('n', '<M-1>', ':NvimTreeToggle<cr>',
  { desc = 'Open file browser pane', silent = true, noremap = true })

-- 2. open diagnostics
vim.keymap.set('n', '<M-2>', ':TroubleToggle<cr>',
  { desc = 'Open diagnostics pane', silent = true, noremap = true })

-- 3. open layout pane
vim.keymap.set('n', '<M-3>', ':AerialToggle<cr>',
  { desc = 'Open layout pane', silent = true, noremap = true })
-- TODO: add tasks pane
-- 4. open tasks pane

-- TODO: add binds for moving lines up and down

-- vim: ts=2 sts=2 sw=2 et
