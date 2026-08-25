# Testes e pedidos HTTP

## pytest dentro do editor

O `neotest` corre o `pytest` com o interpretador do projecto (o mesmo que o
LSP usa — ver [python-ambientes.md](python-ambientes.md)) e mostra os
resultados na margem: ✔ passou, ✘ falhou.

| Atalho | Acção |
|---|---|
| `<space>tr` | Correr o teste sob o cursor |
| `<space>tt` | Correr o ficheiro |
| `<space>tT` | Correr todos |
| `<space>tl` | Repetir o último |
| `<space>td` | **Debug** do teste sob o cursor |
| `<space>ts` | Painel-resumo, navegável |
| `<space>to` | Saída do teste que falhou |
| `<space>tO` | Painel de saída, fixo |
| `<space>tw` | Watch — re-corre sozinho ao gravar |
| `<space>tS` | Parar |

**O fluxo que compensa:** `<space>ts` abre o resumo à esquerda com a árvore de
testes. Navegas com `j`/`k`, `<Enter>` corre, `<Enter>` num que falhou mostra a
saída. Com `<space>tw` ligado, gravas o ficheiro e os testes correm sozinhos.

Quando um teste falha, `<space>td` no mesmo teste entra em debug com um
breakpoint onde quiseres. Ver [debug.md](debug.md).

O `pytest` é invocado com `-vv` para as diferenças ficarem legíveis. Muda em
`lua/plugins/python.lua` se preferires.

### Testar FastAPI

Testes de endpoints com o `TestClient` correm como testes normais:

```python
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_read_item():
    r = client.get("/items/42")
    assert r.status_code == 200
    assert r.json() == {"i": 42}
```

Para código `async`, precisas do `pytest-asyncio` e do `httpx`:

```bash
uv add --dev pytest pytest-asyncio httpx      # ou: poetry add --group dev ...
```

```toml
# pyproject.toml
[tool.pytest.ini_options]
asyncio_mode = "auto"
```

## Cliente HTTP — ficheiros `.http`

Substitui o REST Client / Thunder Client do VS Code. Cria um `api.http` na raiz
do projecto, põe o cursor num pedido e `<space>Rs`.

| Atalho | Acção |
|---|---|
| `<space>Rs` | Enviar o pedido sob o cursor |
| `<space>Ra` | Enviar todos |
| `<space>Rr` | Repetir o último |
| `<space>Rt` | Alternar entre corpo e cabeçalhos |
| `<space>Rc` | Copiar como comando `curl` |
| `<space>Rn` / `<space>Rp` | Pedido seguinte / anterior |

E estes funcionam em qualquer ficheiro, não só nos `.http`:

| Atalho | Acção |
|---|---|
| `<space>Ro` | Scratchpad HTTP — pedido rápido sem criar ficheiro |
| `<space>RO` | **Explorador OpenAPI** — lê o `/openapi.json` da tua API e lista os endpoints |
| `<space>Rf` | Procurar entre todos os pedidos do projecto |
| `<space>Ri` | Importar um comando `curl` da clipboard e convertê-lo em pedido |

As respostas JSON são formatadas com o `jq`.

O `<space>RO` é o que mais rende com FastAPI: o FastAPI publica o esquema
OpenAPI sozinho, e o explorador transforma-o na lista de endpoints reais da tua
API, já com os parâmetros. Com a API a correr, é mais rápido do que escrever os
pedidos à mão.

### Exemplo

```http
@baseUrl = http://127.0.0.1:8000

### Health check
GET {{baseUrl}}/health

### Listar items
GET {{baseUrl}}/items?limit=10
Accept: application/json

### Criar item
POST {{baseUrl}}/items
Content-Type: application/json

{
  "name": "teste",
  "price": 9.99
}

### Com autenticação
GET {{baseUrl}}/me
Authorization: Bearer {{token}}
```

`###` separa pedidos. O texto a seguir é o nome que aparece na saída.

### Variáveis de ambiente

Cria um `http-client.env.json` ao lado do `.http`:

```json
{
  "dev": {
    "baseUrl": "http://127.0.0.1:8000",
    "token": "dev-token-local"
  },
  "staging": {
    "baseUrl": "https://staging.interno/api",
    "token": "..."
  }
}
```

O ambiente por omissão é `dev`. Trocas com `:lua require("kulala").set_selected_env("staging")`.

Para segredos, usa um segundo ficheiro `http-client.private.env.json` — o
kulala lê-o e sobrepõe-no ao primeiro. Versiona o `http-client.env.json` com
valores de exemplo e acrescenta a versão `private` ao `.gitignore`:

```gitignore
http-client.private.env.json
```

### Encadear pedidos

Podes guardar valores da resposta e usá-los no pedido seguinte:

```http
### Login
# @name login
POST {{baseUrl}}/auth/token
Content-Type: application/json

{ "user": "jorge", "password": "..." }

> {%
  client.global.set("token", response.body.access_token)
%}

### Usar o token
GET {{baseUrl}}/me
Authorization: Bearer {{token}}
```

## O ciclo completo

O padrão que vais repetir todos os dias:

1. `<space>|` divide o ecrã — router à esquerda, `api.http` à direita
2. `<space>dc` → **FastAPI: uvicorn --reload** levanta a API em debug
3. `<space>db` põe um breakpoint no endpoint
4. `<space>Rs` no `.http` dispara o pedido
5. O editor pára no breakpoint; `<space>dw` e `<space>de` inspeccionam
6. `<space>dt` termina, corrige, `<space>tr` corre o teste

Tudo sem sair do editor e sem browser.
