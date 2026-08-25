# Configuração Neovim — Python / FastAPI

Configuração baseada em [LazyVim](https://lazyvim.org), afinada para trabalho
diário em Python com FastAPI: `basedpyright` + `ruff` como LSP, `pytest` via
neotest, debug com `debugpy` (incluindo uvicorn com `--reload`), detecção
automática de virtualenv para `uv` e `poetry`, e cliente HTTP integrado.

Última revisão: 2026-08-25 · Neovim 0.12.5

## Instalar noutra máquina

```bash
# 1. Dependências do sistema (Arch)
sudo pacman -S neovim git ripgrep fd curl jq lazygit python python-pip

# 2. A configuração
git clone <este-repo> ~/myconfigs
cp -r ~/myconfigs/nvim ~/.config/nvim

# 3. Primeiro arranque: o lazy.nvim instala tudo sozinho
nvim
```

No primeiro arranque o Mason descarrega `basedpyright`, `ruff` e `debugpy`.
Confirma com `:Mason` e `:checkhealth`.

> **Nota sobre temas:** o `lua/plugins/theme.lua` da máquina original é um
> symlink para `~/.local/state/omarchy/current/theme/neovim.lua` (gerido pelo
> Omarchy) e por isso não está aqui. Sem Omarchy, define o tema no
> `lua/plugins/all-themes.lua`.

## Documentação

Lê por esta ordem se estás a vir do VS Code:

| # | Documento | O que cobre |
|---|---|---|
| 1 | [Do VS Code para o Neovim](docs/vscode-para-nvim.md) | Tabela de equivalências, o modelo mental, os primeiros 3 dias |
| 2 | [Navegação](docs/navegacao.md) | Modos, movimentos, ficheiros, buffers, janelas, saltos LSP |
| 3 | [Atalhos](docs/atalhos.md) | Referência completa, extraída da configuração real |
| 4 | [Ambientes Python](docs/python-ambientes.md) | `uv`, `poetry`, `venv` — como o nvim encontra o interpretador |
| 5 | [Debug](docs/debug.md) | Breakpoints, uvicorn com `--reload`, inspeccionar variáveis |
| 6 | [Testes e HTTP](docs/testes-e-http.md) | `pytest` a partir do buffer, testar endpoints em `.http` |

## Estrutura

```
nvim/
├── init.lua                     Leader + globais do Python (têm de vir 1º)
├── lazyvim.json                 Extras LazyVim activos
├── lazy-lock.json               Versões exactas dos plugins (reprodutível)
├── lua/
│   ├── config/
│   │   ├── lazy.lua             Bootstrap do gestor de plugins
│   │   ├── options.lua          Opções globais do editor
│   │   ├── keymaps.lua          Atalhos próprios (vazio — usa os do LazyVim)
│   │   ├── autocmds.lua         Autocomandos próprios
│   │   └── remote_clipboard.lua Clipboard sobre SSH (OSC 52)
│   ├── util/
│   │   └── python.lua           Resolvedor de interpretador (uv/poetry/venv)
│   └── plugins/
│       ├── python.lua           LSP, formatação, debug, testes
│       ├── http.lua             Cliente HTTP (kulala)
│       └── ...                  Temas e ajustes de interface
└── docs/                        Esta documentação
```

## Decisões desta configuração

**`basedpyright` em `typeCheckingMode = "basic"`** — o modo `recommended` do
basedpyright marca quase todo o código FastAPI idiomático como erro. `basic`
apanha erros reais sem ruído.

**`ruff` como LSP, não só como formatador** — dá diagnósticos enquanto escreves,
não apenas ao gravar. O `hoverProvider` está desligado para não competir com o
basedpyright na documentação sob o cursor.

**`ruff` substitui `black` + `isort`** — faz formatação e ordenação de imports,
uma ordem de grandeza mais rápido.

**Formatação ao gravar** está ligada (`vim.g.autoformat`). Alterna globalmente
com `<leader>uf`, ou só no buffer actual com `<leader>uF`.

**`lua/util/python.lua` em vez do `before_init` habitual** — a versão comum
(`vim.fn.finddir(".venv", cwd)` + `vim.fn.system("poetry env info")`) procura a
partir do *cwd* em vez da raiz do projecto e bloqueia o editor à espera do
poetry. Aqui: raiz por marcadores, poetry com timeout e cache por projecto.
