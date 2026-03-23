local M = {}

function M.setup()
  local lga_actions = require 'telescope-live-grep-args.actions'
  return {
    extensions = {
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        mappings = { -- extend mappings
          i = {
            ['<C-k>'] = lga_actions.quote_prompt(),
            ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
            ['<C-t>'] = lga_actions.quote_prompt { postfix = ' --type ' },
            -- freeze the current list and start a fuzzy search in the frozen list
            ['<C-space>'] = lga_actions.to_fuzzy_refine,
          },
        },
        -- ... also accepts theme settings, for example:
        -- theme = "dropdown", -- use dropdown theme
        -- theme = { }, -- use own theme spec
        -- layout_config = { mirror=true }, -- mirror preview pane
      },
    },
  }
end

function M.load_extensions() pcall(require('telescope').load_extension, 'live_grep_args') end

function M.keymaps()
  vim.keymap.set(
    'n',
    '<leader>sg',
    ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
    { desc = '[S]earch by [G]rep (with live args / iglob support)' }
  )
end

return M
