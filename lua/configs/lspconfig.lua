-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {},
  cssls = {},
  bashls = {},
  clangd = {},
  gopls = {
    filetypes = { "go", "gomod" },
    settings = {
      gopls = {
        -- 关闭语义标记，使用 Tree-sitter 方案
        semanticTokens = false,
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
      },
    },
    init_options = {
      usePlaceholders = false,
    },
  },
  pyright = {
    before_init = function(_, config)
      local cwd = vim.fn.getcwd()
      -- prefer .venv in project root
      local venv_python = cwd .. "/.venv/bin/python"
      if vim.fn.executable(venv_python) == 1 then
        config.settings.python.pythonPath = venv_python
        return
      end
      -- fallback to .python-version (pyenv)
      local version_file = vim.fn.findfile(".python-version", cwd .. ";")
      if version_file ~= "" then
        local version = vim.trim(vim.fn.readfile(version_file)[1])
        local pyenv_python = vim.fn.expand("~/.pyenv/versions/" .. version .. "/bin/python")
        if vim.fn.executable(pyenv_python) == 1 then
          config.settings.python.pythonPath = pyenv_python
        end
      end
    end,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },
}

local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

-- lsps with config
for name, opts in pairs(servers) do
  opts.on_init = nvlsp.on_init
  opts.on_attach = nvlsp.on_attach
  opts.capabilities = nvlsp.capabilities

  lspconfig[name].setup(opts)
end

-- local servers = { "html", "cssls" }
-- vim.lsp.enable(servers)
