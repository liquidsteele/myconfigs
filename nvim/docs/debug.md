# Debug

Motor: `nvim-dap` + `debugpy`, com interface `dap-ui`. O equivalente ao painel
Run and Debug do VS Code.

## O ciclo mínimo

1. `<space>db` numa linha — põe um breakpoint (aparece um ponto na margem)
2. `<space>dc` — abre a lista de configurações, escolhe uma
3. O código pára no breakpoint e o painel de debug abre sozinho
4. `<space>dO` passa à linha seguinte, `<space>di` entra na função
5. `<space>dt` termina

## Configurações disponíveis

`<space>dc` mostra:

| Configuração | Para quê |
|---|---|
| **FastAPI: uvicorn --reload** | Levantar a API em modo debug |
| **Python: ficheiro actual** | Correr e debugar o ficheiro aberto |
| `file` | O mesmo, versão do dap-python |
| `file:args` | Ficheiro actual, a pedir argumentos |
| `attach` | Ligar a um processo Python já a correr |
| `file:doctest` | Doctests do ficheiro |

## Debugar uma API FastAPI

`<space>dc` → **FastAPI: uvicorn --reload** → pergunta o módulo da app.

O valor por omissão é `app.main:app`. Ajusta ao teu projecto — no `janus` seria
`janus.api:app`. É o mesmo argumento que passarias ao `uvicorn` na linha de
comando.

A API sobe em `127.0.0.1:8000`. Põe um breakpoint dentro de um endpoint, faz um
pedido (browser, `curl`, ou um ficheiro `.http` com `<space>Rs` — ver
[testes-e-http.md](testes-e-http.md)) e o editor pára lá.

> **Sobre o `--reload`:** cria um processo filho para o servidor. Sem
> `subProcess = true` na configuração, os breakpoints nunca disparavam porque o
> debugger ficava agarrado ao processo pai. Já está tratado — é a razão de a
> configuração existir em vez de usares a genérica.

Para alterar a porta ou o host, edita `lua/plugins/python.lua` na entrada
`"FastAPI: uvicorn --reload"`.

## Ler o estado

`<space>du` abre/fecha o painel. Tem quatro zonas:

- **Scopes** — variáveis locais e globais no ponto onde parou. Editáveis: põe o
  cursor num valor, `<Enter>`, escreve outro.
- **Breakpoints** — todos os que tens
- **Stack** — a cadeia de chamadas. `<Enter>` numa linha salta para lá.
- **Watches** — expressões que queres seguir

Fora do painel:

| Atalho | Acção |
|---|---|
| `<space>dw` | Valor da variável sob o cursor, numa janela flutuante |
| `<space>de` | Avaliar expressão (em visual, avalia a selecção) |
| `<space>dr` | Consola REPL no contexto onde parou |

O `<space>de` em modo visual é o mais útil: selecciona `req.headers.get("x")`,
`<space>de`, e vês o valor real.

Há ainda texto virtual ao lado das variáveis com o valor actual, sem precisares
de abrir nada.

## Controlar a execução

| Atalho | Acção |
|---|---|
| `<space>dc` | Continuar até ao próximo breakpoint |
| `<space>dO` | Step over — executa a linha |
| `<space>di` | Step into — entra na função |
| `<space>do` | Step out — sai da função |
| `<space>dC` | Corre até à linha do cursor |
| `<space>dj` / `<space>dk` | Descer / subir na stack |
| `<space>dP` | Pausar |
| `<space>dt` | Terminar |
| `<space>dl` | Repetir a última sessão sem escolher outra vez |

`<space>dl` poupa muito tempo: depois da primeira vez, é o teu `F5`.

## Breakpoints condicionais

`<space>dB` pede uma condição. Só pára se for verdadeira:

```
item_id == 42
user.role == "admin"
len(results) == 0
```

Essencial em loops sobre listas grandes.

## Debugar testes

| Atalho | Acção |
|---|---|
| `<space>td` | Debug do teste sob o cursor |
| `<space>dPt` | Debug do método de teste |
| `<space>dPc` | Debug da classe de teste |

Põe o breakpoint no código de produção (não no teste), `<space>td` no teste que
falha, e vês exactamente o estado no momento da falha. É o fluxo mais eficaz
para bugs difíceis.

## Ligar a um processo a correr

Útil quando a API já está a correr num contentor ou noutro terminal. No lado do
processo:

```bash
python -m debugpy --listen 5678 --wait-for-client -m uvicorn app.main:app
```

No nvim: `<space>dc` → `attach` → porta `5678`.

## Resolver problemas

**Os breakpoints não disparam com `--reload`** — usa a configuração
`FastAPI: uvicorn --reload`, não a genérica. Se escreveste a tua, garante
`subProcess = true`.

**"Cannot find a debug adapter"** — falta o debugpy:

```vim
:MasonInstall debugpy
```

**Pára em código de bibliotecas que não te interessa** — as configurações têm
`justMyCode = false` para poderes entrar no código do FastAPI/starlette quando
queres. Se preferires o contrário, muda para `true` em
`lua/plugins/python.lua`.

**O interpretador errado** — as configurações usam o mesmo resolvedor do LSP.
Confirma com `:lua print(require("util.python").path())` e vê
[python-ambientes.md](python-ambientes.md).

**O painel não abre** — `<space>du`. Abre e fecha sozinho no início e fim da
sessão, mas podes forçar.

## `breakpoint()` continua a funcionar

Se preferires, o `breakpoint()` do Python funciona normalmente quando corres a
app num terminal (`<Ctrl-/>`). Dá-te o `pdb` em vez do painel gráfico —
mais rápido para uma verificação pontual.
