return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'VeryLazy',
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobekjcts.scm
              ['am'] = { query = '@function.outer', desc = 'Select [a]round part of [m]ethod' },
              ['im'] = { query = '@function.inner', desc = 'Select [i]nner part of [m]ethod' },
              ['ac'] = { query = '@class.outer', desc = 'Select [a]round part of a [c]lass region' },
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ['ic'] = { query = '@class.inner', desc = 'Select [i]nner part of a [c]lass region' },
              -- You can also use captures from other query groups like ``
              -- Assignments
              ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
              ['=a'] = { query = '@assignment.outer', desc = 'Select [a]round part of an assignment [=]' },
              ['=i'] = { query = '@assignment.inner', desc = 'Select [i]nner part of an assignment [=]' },
              ['=l'] = { query = '@assignment.lhs', desc = 'Select [l]eft part of an assignment [=]' },
              ['=r'] = { query = '@assignment.rhs', desc = 'Select [r]ight part of an assignment [=]' },

              -- Parameters
              ['ap'] = { query = '@parameter.outer', desc = 'Select [a]round part of a [p]arameter/argument' },
              ['ip'] = { query = '@parameter.inner', desc = 'Select [i]nner part of a [p]arameter/argument' },

              -- Conditionals
              ['ai'] = { query = '@conditional.outer', desc = 'Select [a]round part of a conditional ([i]f statement)' },
              ['ii'] = { query = '@conditional.inner', desc = 'Select [i]nner part of a conditional ([i]f statement)' },

              -- Loops
              ['al'] = { query = '@loop.outer', desc = 'Select [a]round part of a loop' },
              ['il'] = { query = '@loop.inner', desc = 'Select [i]nner part of a loop' },

              -- Function calls
              ['af'] = { query = '@call.outer', desc = 'Select [a]round part of a [f]unction call' },
              ['if'] = { query = '@call.inner', desc = 'Select [i]nner part of a [f]unction call' },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobect is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>np'] = '@parameter.inner',
              ['<leader>nm'] = '@function.outer',
            },
            swap_previous = {
              ['<leader>pp'] = '@parameter.inner',
              ['<leader>pm'] = '@function.outer',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']f'] = { query = '@call.outer', desc = 'Next [f]unction call start' },
              [']m'] = { query = '@function.outer', desc = 'Next [m]ethod def start' },
              [']c'] = { query = '@class.outer', desc = 'Next [c]lass start' },
              [']i'] = { query = '@conditional.outer', desc = 'Next conditional start ([i]f statement)' },
              [']l'] = { query = '@loop.outer', desc = 'Next [l]oop start' },
              --
              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
              [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
            },
            goto_next_end = {
              [']F'] = { query = '@call.outer', desc = 'Next [f]unction call end' },
              [']M'] = { query = '@function.outer', desc = 'Next [m]ethod def end' },
              [']C'] = { query = '@class.outer', desc = 'Next [c]lass end' },
              [']I'] = { query = '@conditional.outer', desc = 'Next conditional end ([i]f statement)' },
              [']L'] = { query = '@loop.outer', desc = 'Next [l]oop end' },
            },
            goto_previous_start = {
              ['[f'] = { query = '@call.outer', desc = 'Prev [f]unction call start' },
              ['[m'] = { query = '@function.outer', desc = 'Prev [m]ethod def start' },
              ['[c'] = { query = '@class.outer', desc = 'Prev [c]lass start' },
              ['[i'] = { query = '@conditional.outer', desc = 'Prev conditional start ([i]f statement)' },
              ['[l'] = { query = '@loop.outer', desc = 'Prev [l]oop start' },
            },
            goto_previous_end = {
              ['[F'] = { query = '@call.outer', desc = 'Prev [f]unction call end' },
              ['[M'] = { query = '@function.outer', desc = 'Prev [m]ethod def end' },
              ['[C'] = { query = '@class.outer', desc = 'Prev [c]lass end' },
              ['[I'] = { query = '@conditional.outer', desc = 'Prev conditional end ([i]f statement)' },
              ['[L'] = { query = '@loop.outer', desc = 'Prev [l]oop end' },
            },
          },
        },
      }

      local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

      -- Repeat movement with ; and ,
      -- ensure ; goes forward and , goes backward regardless of the last direction
      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

      -- vim way: ; goes to the direction you were moving.
      -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
    end,
  },
}
