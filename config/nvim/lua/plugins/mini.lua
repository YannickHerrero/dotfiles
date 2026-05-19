return {
  "echasnovski/mini.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.icons").setup()
    require("mini.statusline").setup({ use_icons = true })

    -- mini.statusline ships its own hardcoded cterm colors. Link every
    -- section to the standard StatusLine highlight so the statusline
    -- inherits the terminal theme like the rest of the editor.
    for _, name in ipairs({
      "MiniStatuslineModeNormal",
      "MiniStatuslineModeInsert",
      "MiniStatuslineModeVisual",
      "MiniStatuslineModeReplace",
      "MiniStatuslineModeCommand",
      "MiniStatuslineModeOther",
      "MiniStatuslineDevinfo",
      "MiniStatuslineFilename",
      "MiniStatuslineFileinfo",
      "MiniStatuslineInactive",
    }) do
      vim.api.nvim_set_hl(0, name, { link = "StatusLine" })
    end
  end,
}
