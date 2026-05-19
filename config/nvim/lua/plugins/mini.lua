return {
  "echasnovski/mini.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.icons").setup()
    require("mini.statusline").setup({ use_icons = true })
    require("mini.tabline").setup()

    -- Drop mini.statusline's hardcoded colors and Neovim's default
    -- StatusLine reverse attribute. Statusline blends with the editor
    -- (terminal default bg/fg), bold text marks the bar.
    local hl = { ctermbg = "NONE", ctermfg = "NONE", cterm = { bold = true } }
    local groups = {
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
      "StatusLine",
      "StatusLineNC",
    }
    local function apply()
      for _, name in ipairs(groups) do
        vim.api.nvim_set_hl(0, name, hl)
      end
    end
    apply()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("statusline-terminal-theme", { clear = true }),
      callback = apply,
    })
  end,
}
