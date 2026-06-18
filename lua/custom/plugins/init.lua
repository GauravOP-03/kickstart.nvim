-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        json = { 'prettier' },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

      -- optional but nice
      vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
      vim.opt.undofile = true
    end,
  },

  {

    -- -- ysiw" → surround word with quotes
    -- ysiw<div> → wrap word in a <div> tag
    -- cs"' → change surrounding " to '
    -- ds" → delete surrounding quotes
    -- yss<div> → wrap entire line in a tag

    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        AARRGGBB = true,
        css = true,
        css_fn = true,
        tailwind = true,
      },
    },
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      {
        on_attach = function(client, bufnr)
          -- don't attach inside diff/special buffers
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          if bufname:match '^diffview://' or bufname:match '^fugitive://' then
            client.stop()
            return
          end
        end,
      },
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = 'all',
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    },
  },
}
