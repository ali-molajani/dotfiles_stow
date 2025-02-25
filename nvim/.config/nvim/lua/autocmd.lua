-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- Remember cursor position between sessions
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local line = vim.fn.line
    local last_pos = line '\'"'
    if last_pos > 0 and last_pos <= line '$' then
      -- Check if the file type is valid and not a commit message
      local filetype = vim.bo.filetype
      if filetype ~= 'gitcommit' and filetype ~= 'gitrebase' then
        vim.cmd 'normal! g`"'
      end
    end
  end,
  pattern = '*',
  desc = 'Remember cursor position when reopening a file',
})
