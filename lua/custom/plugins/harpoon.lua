return {

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      -- basic telescope configuration
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      -- vim.keymap.set('n', '<C-e>', function() toggle_telescope(harpoon:list()) end, { desc = 'Open harpoon window' })

      local function harpoon_desc(idx)
        local item = harpoon:list().items[idx]
        if not item then return 'empty' end
        return vim.fn.fnamemodify(item.value, ':t')
      end

      local function set_harpoon_kemaps()
        for i = 1, 6 do
          vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon -> ' .. harpoon_desc(i) })
        end
      end

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
        set_harpoon_kemaps()
      end, { desc = 'Add file to harpoon' })

      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
        set_harpoon_kemaps()
      end, { desc = 'Toggle Harpoon' })
      set_harpoon_kemaps()

      vim.keymap.set('n', '<leader>n', function() harpoon:list():next() end, { desc = 'Harpoon Next' })
      vim.keymap.set('n', '<leader>p', function() harpoon:list():prev() end, { desc = 'Harpoon Prev' })

      -- vim.keymap.set('n', '<leader>hd', function()
      --   harpoon:list():remove()
      --   set_harpoon_kemaps()
      -- end, { desc = 'Harpoon Remove File' })
      --
      -- vim.keymap.set('n', '<leader>hc', function()
      --   harpoon:list():clear()
      --   set_harpoon_kemaps()
      -- end, { desc = 'Harpoon Clear All' })
    end,
  },
}
