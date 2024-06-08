return {
  {
    'mistricky/codesnap.nvim',
    build = 'make',
    keys = {
      { '<leader>cs', '<Esc><cmd>CodeSnap<cr>', mode = 'x', desc = 'Save [C]ode [S]napshot into clipboard' },
    },
    opts = {
      watermark = '',
      title = '',
      bg_theme = 'peach',
    },
  },
}
