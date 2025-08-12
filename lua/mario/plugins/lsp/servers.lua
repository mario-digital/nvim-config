return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Configure each LSP server
    local servers = {
      "ts_ls",
      "html",
      "cssls",
      "tailwindcss",
      "prismals",
      "pyright",
    }

    for _, server in ipairs(servers) do
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    end

    -- Special configurations for specific servers
    lspconfig.svelte.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end,
    })

    lspconfig.graphql.setup({
      capabilities = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      root_dir = function(fname)
        -- If it's a wezterm config, use the actual file location as root
        if fname:match("wezterm%.lua$") then
          local actual_path = vim.fn.resolve(fname)
          return vim.fn.fnamemodify(actual_path, ":h")
        end
        -- Otherwise use the default root pattern
        local util = require("lspconfig.util")
        return util.root_pattern(".luarc.json", ".git")(fname) or vim.fn.getcwd()
      end,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "wezterm" },  -- Added wezterm as global
          },
          completion = {
            callSnippet = "Replace",
          },
          workspace = {
            checkThirdParty = false,  -- This helps with symlink issues
            library = {},  -- Explicitly set empty library
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
}