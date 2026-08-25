-- Cliente HTTP dentro do nvim (equivalente ao REST Client / Thunder Client do VS Code).
-- Abre um ficheiro .http, põe o cursor num pedido e <leader>Rs para executar.
--
--   @baseUrl = http://127.0.0.1:8000
--
--   ### Criar item
--   POST {{baseUrl}}/items
--   Content-Type: application/json
--
--   { "name": "teste", "price": 9.99 }

return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    keys = {
      { "<leader>R", "", desc = "+rest/http", ft = { "http", "rest" } },
      { "<leader>Rs", function() require("kulala").run() end, desc = "Enviar pedido", ft = { "http", "rest" } },
      { "<leader>Ra", function() require("kulala").run_all() end, desc = "Enviar todos", ft = { "http", "rest" } },
      { "<leader>Rr", function() require("kulala").replay() end, desc = "Repetir último", ft = { "http", "rest" } },
      { "<leader>Rt", function() require("kulala").toggle_view() end, desc = "Alternar corpo/cabeçalhos", ft = { "http", "rest" } },
      { "<leader>Rc", function() require("kulala").copy() end, desc = "Copiar como curl", ft = { "http", "rest" } },
      { "<leader>Rn", function() require("kulala").jump_next() end, desc = "Pedido seguinte", ft = { "http", "rest" } },
      { "<leader>Rp", function() require("kulala").jump_prev() end, desc = "Pedido anterior", ft = { "http", "rest" } },
      -- Estes funcionam em qualquer ficheiro, não só .http:
      { "<leader>Ro", function() require("kulala").open() end, desc = "Abrir scratchpad HTTP" },
      { "<leader>RO", function() require("kulala").open_openapi_explorer() end, desc = "Explorar OpenAPI (FastAPI)" },
      { "<leader>Rf", function() require("kulala").search() end, desc = "Procurar pedido" },
      { "<leader>Ri", function() require("kulala").from_curl() end, desc = "Importar curl da clipboard" },
    },
    opts = {
      default_view = "body",
      default_env = "dev",
      -- Formata automaticamente as respostas JSON do FastAPI.
      contenttypes = {
        ["application/json"] = {
          ft = "json",
          formatter = { "jq", "." },
        },
      },
    },
  },
}
