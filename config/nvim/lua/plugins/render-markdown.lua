return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.nvim", -- provides mini.icons, already configured
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    heading = {
      -- empty list disables the per-line background highlight on headings
      backgrounds = {},
    },
  },
}
