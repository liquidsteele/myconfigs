# Ambientes Python — uv, poetry, venv

O ponto crítico: **o `basedpyright` só sabe resolver os teus imports se souber
qual é o interpretador do projecto.** Se abrires um projecto e vires
`Import "fastapi" could not be resolved`, é sempre isto.

## Como esta configuração descobre o interpretador

O `lua/util/python.lua` corre quando o LSP arranca e tenta, por esta ordem:

| # | Fonte | Quando ganha |
|---|---|---|
| 1 | `$VIRTUAL_ENV` | Já tinhas o ambiente activo na shell onde lançaste o `nvim` |
| 2 | `<raiz>/.venv/bin/python`, depois `venv/`, `.env/` | `uv`, `python -m venv`, poetry in-project |
| 3 | `poetry env info --executable` | Há `pyproject.toml` e o poetry guarda o venv fora da árvore |
| 4 | `python3` do sistema | Nada encontrado (vais ver erros de import — é o sinal) |

A **raiz** não é o `cwd`: é a pasta mais próxima acima do ficheiro que contenha
`pyproject.toml`, `setup.py`, `setup.cfg`, `requirements.txt`, `Pipfile`,
`pyrightconfig.json` ou `.git`. Isto significa que podes abrir o nvim de
qualquer sítio — `nvim ~/code/projecto/app/routers/x.py` — que ele acerta.

O passo 3 tem timeout de 3 segundos e o resultado fica em cache por projecto,
por isso o poetry só é invocado uma vez por sessão.

## Confirmar qual está a ser usado

```vim
:lua print(require("util.python").path())
```

Ou `<space>cl` (LSP Info) e vê o `pythonPath` do `basedpyright`.

Exemplos reais:

```
~/code/wtt/noc/phpipam-dasboard  →  .../phpipam-dasboard/.venv/bin/python   (uv)
~/code/wtt/noc/janus             →  ~/.cache/pypoetry/virtualenvs/janus-FUVqkS5u-py3.14/bin/python
```

## Fluxo com `uv`

O `uv` cria o venv dentro do projecto — detecção automática, não tens de fazer
nada.

```bash
cd ~/code/projecto
uv venv                        # cria .venv/
uv add fastapi uvicorn         # instala e regista no pyproject.toml
uv add --dev pytest httpx      # dependências de desenvolvimento
nvim .
```

Correr coisas sem activar o ambiente:

```bash
uv run uvicorn app.main:app --reload
uv run pytest
```

## Fluxo com `poetry`

O poetry guarda o venv em `~/.cache/pypoetry/virtualenvs/` por omissão — daí o
passo 3 do resolvedor.

```bash
cd ~/code/projecto
poetry install
poetry add fastapi uvicorn
poetry add --group dev pytest httpx
nvim .
```

**Recomendação:** força o poetry a criar o venv dentro do projecto. Fica mais
rápido de detectar, e alinha com o comportamento do `uv`:

```bash
poetry config virtualenvs.in-project true    # global, uma vez
# nos projectos que já existem:
poetry env remove --all && poetry install
```

## Fluxo com `venv` simples

```bash
python -m venv .venv
source .venv/bin/activate
pip install fastapi uvicorn
nvim .
```

## Trocar de ambiente sem sair do editor

`<space>cv` abre o selector de virtualenvs (venv-selector). Procura venvs no
projecto e nas pastas de cache do poetry/pipenv, e reinicia o LSP com o
interpretador escolhido.

Usa-o quando:
- tens vários venvs no mesmo projecto (ex.: py3.11 e py3.13)
- criaste o venv **depois** de abrir o nvim
- o resolvedor caiu no `python3` do sistema

## Depois de instalar um pacote novo

O `basedpyright` não vê pacotes novos sem reiniciar. Duas opções:

```vim
:LspRestart
```

ou, se criaste um venv de raiz durante a sessão:

```vim
:lua require("util.python").clear()
:LspRestart
```

## Resolver problemas

**`Import "fastapi" could not be resolved`**

```vim
:lua print(require("util.python").path())
```

Se devolver `/usr/bin/python3`, o resolvedor não encontrou o venv. Verifica se
existe (`ls .venv/bin/python`), se o `pyproject.toml` está na raiz que esperas,
e usa `<space>cv` para escolher à mão.

**O LSP não arranca de todo** — `<space>cl` mostra o estado. Se o
`basedpyright` não aparecer, confirma no `:Mason` que está instalado.

**Diagnósticos a mais** — o basedpyright está em `typeCheckingMode = "basic"`.
Para um projecto específico, cria um `pyrightconfig.json` na raiz:

```json
{
  "typeCheckingMode": "off",
  "reportMissingImports": true
}
```

**Ruff a queixar-se de regras que não queres** — o ruff lê o `pyproject.toml`
do projecto. Configura lá, não no nvim:

```toml
[tool.ruff]
line-length = 100
target-version = "py313"

[tool.ruff.lint]
select = ["E", "F", "I", "UP", "B"]
ignore = ["E501"]
```

`I` activa a ordenação de imports (substitui o isort) e é aplicada ao gravar.

**Monorepo / vários pacotes no mesmo repo** — o resolvedor pára no primeiro
marcador que encontra a subir. Se cada serviço tem o seu `pyproject.toml` e o
seu `.venv`, funciona sozinho e cada ficheiro usa o venv do seu serviço. Se em
vez disso há um venv único na raiz e os serviços só têm código, apaga os
`pyproject.toml` intermédios ou aponta o interpretador à mão com `<space>cv`.

## Formatação ao gravar

Está ligada. Ao gravar corre `ruff_fix` (corrige o que é auto-corrigível,
incluindo ordenar imports) e depois `ruff_format`.

- `<space>uf` — desliga/liga globalmente
- `<space>uF` — desliga/liga só neste buffer
- `<space>cf` — formatar agora, sem gravar

Se um projecto da equipa usar `black`, muda o `formatters_by_ft` em
`lua/plugins/python.lua` para `{ "black" }` e instala-o com `:Mason`.
