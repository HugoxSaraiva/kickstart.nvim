return {
  {
    'ej-shafran/compile-mode.nvim',
    branch = 'latest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- if you want to enable coloring of ANSI escape codes in
      -- compilation output, add:
      -- { "m00qek/baleia.nvim", tag = "v1.3.0" },
    },
    keys = {
      { '<leader>r', ':below Recompile<cr>', mode = 'n', desc = '[R]ecompile command' },
      { '<leader>R', ':below Compile<cr>', mode = 'n', desc = 'Compile command' },
    },
    config = function()
      ---@type CompileModeOpts
      vim.g.compile_mode = {
        -- if you use something like `nvim-cmp` or `blink.cmp` for completion,
        -- set this to fix tab completion in command mode:
        input_word_completion = true,

        -- to add ANSI escape code support, add:
        -- baleia_setup = true,

        -- to make `:Compile` replace special characters (e.g. `%`) in
        -- the command (and behave more like `:!`), add:
        bang_expansion = true,
        recompile_no_fail = true,
        default_command = {
          c = 'cc % -o main && ./main ',
        },
      }
    end,
  },
}
