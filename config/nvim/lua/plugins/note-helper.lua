return {
  "YannickHerrero/nvim-note-helper",
  main = "note_helper",
  cmd = "Note",
  ft = "markdown",
  opts = {},
  keys = {
    -- Normal mode: operate on the whole buffer.
    { "<leader>nf", "<cmd>Note format<cr>", desc = "Note: format" },
    { "<leader>nt", "<cmd>Note typos<cr>", desc = "Note: fix typos" },
    { "<leader>ns", "<cmd>Note summarize<cr>", desc = "Note: summarize" },
    { "<leader>nd", "<cmd>Note todos<cr>", desc = "Note: extract TODOs" },
    -- Visual mode: ':' auto-inserts the selection range so only it is processed.
    { "<leader>nf", ":Note format<cr>", mode = "x", desc = "Note: format selection" },
    { "<leader>nt", ":Note typos<cr>", mode = "x", desc = "Note: fix typos in selection" },
  },
}
