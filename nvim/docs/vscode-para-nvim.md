# Do VS Code para o Neovim

## O modelo mental

No VS Code carregas numa tecla e algo acontece. No Neovim **compões uma frase**:

```
   d       i       w
 verbo  modific.  objecto
"apaga"  "dentro"  "palavra"
```

`diw` = apaga a palavra inteira sob o cursor. Troca o verbo e a frase muda:
`ciw` muda a palavra, `yiw` copia-a, `viw` selecciona-a.

Os verbos principais são `d` (delete), `c` (change), `y` (yank/copiar) e
`v` (visual/seleccionar). Os objectos mais úteis em Python:

| Objecto | Significado | Exemplo |
|---|---|---|
| `iw` / `aw` | palavra (interior / com espaço) | `diw` |
| `i"` / `a"` | dentro / incluindo aspas | `ci"` muda uma string |
| `i(` / `a(` | dentro / incluindo parênteses | `di(` esvazia argumentos |
| `ip` / `ap` | parágrafo (bloco sem linhas vazias) | `dap` |
| `if` / `af` | função (via treesitter) | `vaf` selecciona a função toda |
| `ic` / `ac` | classe (via treesitter) | `dac` apaga a classe |

`vaf` dentro de uma rota FastAPI selecciona a função toda. O decorador
`@app.get(...)` fica de fora — para o incluir, depois do `vaf` carrega em `o`
(salta para o outro extremo da selecção) e `k` (estende uma linha para cima).
É o movimento que mais vais usar.

## O número antes repete

`3j` desce 3 linhas. `5dd` apaga 5 linhas. `d7k` apaga 7 linhas para cima.
É por isso que os números relativos estão ligados nesta configuração: a coluna
da esquerda diz-te exactamente que número escrever.

## Equivalências directas

| VS Code | Neovim | Notas |
|---|---|---|
| `Ctrl+P` | `<space>ff` | Ficheiros na raiz do projecto |
| `Ctrl+Shift+F` | `<space>sg` | Grep no projecto |
| `Ctrl+Shift+P` | `<space>sC` | Paleta de comandos |
| `Ctrl+B` | `<space>e` | Explorador de ficheiros |
| `Ctrl+`` ` | `<Ctrl-/>` | Terminal |
| `F12` | `gd` | Ir para definição |
| `Shift+F12` | `gr` | Referências |
| `F2` | `<space>cr` | Renomear símbolo |
| `Ctrl+.` | `<space>ca` | Code action / quick fix |
| `Ctrl+Space` | automático | Completação aparece sozinha |
| `Hover` | `K` | Documentação sob o cursor |
| `F9` | `<space>db` | Toggle breakpoint |
| `F5` | `<space>dc` | Começar debug |
| `F10` / `F11` | `<space>dO` / `<space>di` | Step over / step into |
| `Ctrl+Tab` | `<Shift-h>` / `<Shift-l>` | Buffer anterior / seguinte |
| `Ctrl+W` | `<space>bd` | Fechar buffer |
| `Ctrl+S` | `<Ctrl-s>` ou `:w` | A formatação corre ao gravar |
| `Ctrl+Z` | `u` | Desfazer (`<Ctrl-r>` refazer) |
| Problems | `<space>xx` | Painel Trouble |
| Source Control | `<space>gg` | LazyGit |

## A tecla que resolve tudo

**Carrega em `<space>` e espera.** Aparece um menu (which-key) com tudo o que
podes fazer a seguir. Não precisas de decorar nada — navega pelo menu até o
gesto ficar automático. O mesmo funciona a meio: `<space>g` mostra só as coisas
de git.

`<space>sk` procura em todos os atalhos por nome.

## Os primeiros três dias

**Dia 1 — não tentes ser rápido.** Usa as setas se precisares. Foca-te só em:
`i` para escrever, `<Esc>` para sair, `:w` gravar, `:q` sair,
`<space>ff` abrir ficheiro, `<space>sg` procurar. Nada mais.

**Dia 2 — movimento.** Troca as setas por `hjkl`. Aprende `w` (palavra à
frente), `b` (palavra atrás), `0` (início da linha), `$` (fim), `gg` (topo do
ficheiro), `G` (fundo). E `<space>` + `s` (flash): escreve duas letras e salta
para qualquer sítio visível no ecrã.

**Dia 3 — edição.** `ciw`, `ci"`, `dd`, `yy`, `p`. E `.` — repete a última
alteração. `ciw` numa variável, `<Esc>`, depois `n` e `.` renomeia ocorrência a
ocorrência.

Depois disso, acrescenta um gesto novo por dia. A armadilha é tentar decorar
tudo na primeira semana e desistir.

## Sair de sarilhos

| Situação | Solução |
|---|---|
| Não sei em que modo estou | `<Esc>` duas vezes — volta sempre a normal |
| Escrevi `:` sem querer | `<Esc>` |
| Estou preso e nada responde | `<Ctrl-c>` |
| Bloqueou tudo depois de `<Ctrl-s>` | `<Ctrl-q>` (era o flow control do terminal) |
| Fiz asneira no ficheiro | `u` até voltar atrás; `:e!` recarrega do disco |
| Quero sair sem gravar | `:q!` |
| Quero gravar e sair | `:wq` ou `ZZ` |
| Abri um ficheiro em read-only | `:w !sudo tee %` |

## Aprendizagem guiada

`:Tutor` — 30 minutos, dentro do próprio editor. Vale a pena mesmo tendo já
usado o modo vim do VS Code, porque cobre os objectos de texto, que é o que o
plugin do VS Code nunca ensinou.
