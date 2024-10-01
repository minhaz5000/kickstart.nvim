return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = 'Format buffer',
    },
    {
      -- Customize or remove this keymap to your liking
      '<leader>ae',
      function()
        vim.b.disable_autoformat = false
      end,
      mode = '',
      desc = 'Enable autoformat-on-save for this buffer',
    },
    {
      -- Autoformat Disable
      '<leader>ad',
      function()
        vim.b.disable_autoformat = true
      end,
      mode = '',
      desc = 'Disable autoformat-on-save for this buffer',
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    notify_on_error = false,
    -- Define your formatters
    formatters_by_ft = {
      lua = { 'stylua' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      python = { 'isort', 'black' },
    },
    -- Set up format-on-save
    format_on_save = function(bufnr)
      -- Disable autoformat on certain filetypes
      local ignore_filetypes = { 'sql', 'java', 'c', 'cpp' }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
      end
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match '/node_modules/' then
        return
      end
      -- ...additional logic...
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
  },

  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
