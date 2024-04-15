return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>af",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
    {
      -- Customize or remove this keymap to your liking
      "<leader>ae",
      function()
        vim.b.disable_autoformat = false
      end,
      mode = "",
      desc = "Enable autoformat-on-save for this buffer",
    },
    {
      -- Autoformat Disable
      "<leader>ad",
      function()
        vim.b.disable_autoformat = true
      end,
      mode = "",
      desc = "Disable autoformat-on-save for this buffer",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    notify_on_error = false,
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      -- python = { "isort", "black" },
      -- javascript = { { "prettierd", "prettier" } },
    },
    -- Set up format-on-save
    format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
      local disable_filetypes = { c = true, cpp = true }
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype], }
    end,
    formatters_by_ft = {
        lua = { 'stylua' },
        -- cpp = { 'clang_format' }
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
  },

  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,

}