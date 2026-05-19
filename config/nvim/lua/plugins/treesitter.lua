return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "jsonc",
        "yaml",
        "markdown",
        "markdown_inline",
        "bash",
        "html",
        "css",
        "toml",
        "rust",
        -- injection targets referenced by the above grammars' queries
        "c",
        "comment",
        "jsdoc",
        "luadoc",
        "luap",
        "printf",
        "query",
        "regex",
        "vim",
        "vimdoc",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
