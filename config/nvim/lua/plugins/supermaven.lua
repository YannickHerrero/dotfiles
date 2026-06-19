return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-l>",
      },
      -- Inline ghost-text suggestions; blink.cmp keeps handling the popup menu.
      disable_inline_completion = false,
      disable_keymaps = false,
    })

    -- Accept the whole suggestion with <C-j> too, in addition to <Tab>.
    local preview = require("supermaven-nvim.completion_preview")
    vim.keymap.set("i", "<C-j>", preview.on_accept_suggestion, { desc = "Supermaven: accept suggestion" })
  end,
}
