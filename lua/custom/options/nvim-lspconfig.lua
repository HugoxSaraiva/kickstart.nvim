local M = {}

M.opts = {
  servers = {
    clangd = {
      keys = {
        { '<leader>grh', '<cmd>ClangdSwitchSourceHeader<cr>', desc = 'Switch Source/Header (C/C++)' },
      },
    },
  },
}

function M.config()
  -- Diagnostic Config
  -- See :help vim.diagnostic.Opts
  vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    } or {},
    virtual_text = {
      source = 'if_many',
      spacing = 2,
      format = function(diagnostic)
        local diagnostic_message = {
          [vim.diagnostic.severity.ERROR] = diagnostic.message,
          [vim.diagnostic.severity.WARN] = diagnostic.message,
          [vim.diagnostic.severity.INFO] = diagnostic.message,
          [vim.diagnostic.severity.HINT] = diagnostic.message,
        }
        return diagnostic_message[diagnostic.severity]
      end,
    },
  }
end

M.servers = {
  clangd = {
    root_markers = {
      'compile_commands.json',
      'compile_flags.txt',
      'configure.ac', -- AutoTools
      'Makefile',
      'configure.ac',
      'configure.in',
      'config.h.in',
      'meson.build',
      'meson_options.txt',
      'build.ninja',
      '.git',
      '.clangd',
      '.clang-tidy',
      '.clang-format',
    },
    capabilities = {
      offsetEncoding = { 'utf-8', 'utf-16' },
    },
    cmd = {
      'clangd',
      '--background-index',
      '--clang-tidy',
      '--header-insertion=iwyu',
      '--completion-style=detailed',
      '--function-arg-placeholders=0',
      '--fallback-style=llvm',
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
  },
}

M.ensure_installed = {
  'prettier',
  'prettierd',
  'clang-format',
  'tree-sitter-cli',
}

return M
