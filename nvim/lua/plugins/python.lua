-- Python / FastAPI.
--
-- A base (ruff LSP, basedpyright, neotest-python, dap-python, venv-selector)
-- vem do extra `lazyvim.plugins.extras.lang.python`, activo em lazyvim.json.
-- O LSP escolhido é definido por vim.g.lazyvim_python_lsp no init.lua.
-- Este ficheiro só afina o que o extra deixa por decidir.

local py = require("util.python")

return {
  -- Ferramentas: basedpyright/ruff são instalados pelo extra via mason-lspconfig;
  -- o debugpy é preciso para o nvim-dap-python.
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "debugpy" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              -- "basic" em vez do "recommended" do basedpyright: este último
              -- marca quase todo o código FastAPI real como erro.
              analysis = {
                typeCheckingMode = "basic",
                diagnosticMode = "openFilesOnly",
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                inlayHints = {
                  variableTypes = true,
                  functionReturnTypes = true,
                  callArgumentNames = true,
                },
              },
            },
          },
          before_init = function(_, config)
            config.settings = config.settings or {}
            config.settings.python = config.settings.python or {}
            config.settings.python.pythonPath = py.path(config.root_dir)
          end,
        },
      },
    },
  },

  -- Formatação: o ruff faz import-sort + fixes + format (substitui black/isort).
  -- Sem format_on_save aqui: quem trata disso é o LazyVim (vim.g.autoformat),
  -- alternável por buffer com <leader>uf.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" },
      },
    },
  },

  -- pytest a partir do buffer, com o interpretador do projecto.
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = {
      adapters = {
        ["neotest-python"] = {
          runner = "pytest",
          python = function()
            return py.path()
          end,
          args = { "-vv" },
        },
      },
    },
  },

  -- Debugger: além do que o extra dá, uma config para levantar o uvicorn
  -- em modo debug e parar em breakpoints dentro dos endpoints.
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      dap.configurations.python = dap.configurations.python or {}

      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "FastAPI: uvicorn --reload",
        module = "uvicorn",
        args = function()
          local app = vim.fn.input("Módulo da app (ex: app.main:app): ", "app.main:app")
          return { app, "--reload", "--host", "127.0.0.1", "--port", "8000" }
        end,
        cwd = function()
          return py.root()
        end,
        python = function()
          return py.path()
        end,
        -- --reload cria um subprocesso; sem isto os breakpoints não pegam.
        subProcess = true,
        justMyCode = false,
        console = "integratedTerminal",
      })

      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Python: ficheiro actual",
        program = "${file}",
        cwd = function()
          return py.root()
        end,
        python = function()
          return py.path()
        end,
        justMyCode = false,
        console = "integratedTerminal",
      })
    end,
  },

  -- Saltar entre funções/classes e seleccioná-las com movimentos de texto.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python", "toml", "yaml", "sql", "http" } },
  },
}
