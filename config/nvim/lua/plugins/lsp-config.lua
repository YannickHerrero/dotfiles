return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "tailwindcss" },
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configure LSP servers using vim.lsp.config (Neovim 0.11+)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })
      vim.lsp.config("tailwindcss", {
        capabilities = capabilities,
      })

      -- Enable configured servers
      vim.lsp.enable({ "lua_ls", "ts_ls", "tailwindcss" })

      require("fidget").setup()

      -- Completion options
      vim.o.completeopt = "menuone,noinsert,noselect"
      vim.opt.shortmess = vim.opt.shortmess + "c"

      -- Diagnostics config
      vim.diagnostic.config({
        virtual_text = true,
        float = { border = "rounded" },
      })

      -- Show diagnostics on hover
      vim.o.updatetime = 250
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        callback = function()
          vim.diagnostic.open_float(nil, { focus = false })
        end,
      })

      -- Bordered hover and signature help
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
