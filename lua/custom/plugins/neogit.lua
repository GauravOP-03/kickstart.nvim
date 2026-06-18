return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = true,
  keys = {
    { '<leader>gg', function() require('neogit').open() end, desc = 'Neogit Status' },
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview Open' },
  },
}
