return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  opts = {
    keymaps = {
      accept_suggestion = "<Tab>",
      clear_suggestion = "<C-]>",
      accept_word = "<C-j>",
    },
    -- Inline ghost-text suggestions; blink.cmp keeps handling the popup menu.
    disable_inline_completion = false,
    disable_keymaps = false,
  },
}
