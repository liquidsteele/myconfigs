# Navegação

## Os modos

Metade da confusão inicial vem de não saber em que modo estás. A barra de baixo
diz-te sempre.

| Modo | Entra com | Serve para |
|---|---|---|
| **Normal** | `<Esc>` | Mover e dar comandos. É onde estás por omissão |
| **Inserção** | `i` `a` `o` `I` `A` `O` | Escrever texto |
| **Visual** | `v` `V` `<Ctrl-v>` | Seleccionar |
| **Comando** | `:` | Comandos `:w`, `:q`, `:help` |

Na dúvida: `<Esc>` volta sempre ao normal.

As variantes de entrada em inserção poupam muito tempo:
`i` antes do cursor · `a` depois · `I` início da linha · `A` fim da linha ·
`o` linha nova abaixo · `O` linha nova acima.

## Mover dentro do ficheiro

**Base:** `h` esquerda · `j` baixo · `k` cima · `l` direita

**Por palavra:** `w` palavra seguinte · `b` anterior · `e` fim da palavra ·
`W`/`B`/`E` iguais mas ignoram pontuação (útil em `self.repo.get_by_id`)

**Na linha:** `0` coluna 0 · `^` primeiro caractere · `$` fim ·
`f<letra>` salta para a letra · `t<letra>` até antes dela · `;` repete

**No ficheiro:** `gg` topo · `G` fundo · `42G` linha 42 ·
`<Ctrl-d>`/`<Ctrl-u>` meia página · `<Ctrl-f>`/`<Ctrl-b>` página ·
`{`/`}` parágrafo (bloco de código) · `%` salta para o parêntese/chaveta par

**Reposicionar a vista:** `zz` centra a linha actual · `zt` põe no topo ·
`zb` no fundo

**Flash (o mais rápido):** `s` seguido de duas letras salta para qualquer
ocorrência visível no ecrã. É quase sempre melhor do que contar linhas.

## Números relativos

A coluna da esquerda mostra a distância até cada linha. Vês `3` à esquerda de
uma linha? `3j` leva-te lá, `d3j` apaga até lá, `y3j` copia até lá. A linha
actual mostra o número absoluto.

Desligar: `<space>uL`.

## Voltar atrás

| Atalho | Acção |
|---|---|
| `<Ctrl-o>` | Volta ao sítio anterior (funciona através de ficheiros) |
| `<Ctrl-i>` | Avança outra vez |
| `` `` `` | Alterna entre a posição actual e a anterior |
| `` `. `` | Vai para a última alteração |
| `<space>sj` | Lista de saltos, navegável |

`<Ctrl-o>` é o teu `Alt+←` do VS Code. Depois de um `gd` que te levou para
dentro de uma biblioteca, `<Ctrl-o>` traz-te de volta.

## Entre ficheiros

| Atalho | Acção |
|---|---|
| `<space><space>` | Procurar ficheiro por nome |
| `<space>fr` | Ficheiros recentes |
| `<space>,` | Buffers abertos |
| `<Shift-h>` / `<Shift-l>` | Buffer anterior / seguinte |
| `` <space>` `` | Alternar com o último buffer |
| `<space>e` | Árvore de ficheiros |
| `gf` | Abrir o ficheiro cujo caminho está sob o cursor |

**Buffer ≠ separador.** Um buffer é um ficheiro em memória. Podes ter 30
buffers abertos e uma só janela. `<space>,` mostra-os todos; `<space>bd` fecha
o actual sem fechar a janela.

No explorador (`<space>e`): `a` cria · `d` apaga · `r` renomeia · `c` copia ·
`x` corta · `p` cola · `q` fecha.

## Janelas

| Atalho | Acção |
|---|---|
| `<space>-` / `<space>\|` | Dividir horizontal / vertical |
| `<Ctrl-w>` + `h/j/k/l` | Mover para a janela nessa direcção |
| `<Ctrl-w>` (e esperar) | Menu hydra: navega e redimensiona sem largar a tecla |
| `<Ctrl-Setas>` | Redimensionar |
| `<space>wd` | Fechar janela |
| `<space>wm` | Maximizar / restaurar |

Padrão útil em FastAPI: abre o router à esquerda, `<space>\|`, e o teste ou o
schema à direita.

## Navegar código com o LSP

| Atalho | Acção |
|---|---|
| `gd` | Definição |
| `gr` | Referências (quem chama isto) |
| `gI` | Implementações |
| `gy` | Definição do tipo |
| `K` | Documentação sob o cursor |
| `gK` | Assinatura, com o argumento actual destacado |
| `gai` / `gao` | Hierarquia de chamadas, a entrar / a sair |
| `<space>ss` | Símbolos do ficheiro (saltar para uma função pelo nome) |
| `<space>sS` | Símbolos do projecto inteiro |
| `]]` / `[[` | Ocorrência seguinte / anterior do símbolo sob o cursor |

`K` duas vezes entra dentro da janela flutuante para poderes fazer scroll.

## Diagnósticos

| Atalho | Acção |
|---|---|
| `]d` / `[d` | Diagnóstico seguinte / anterior |
| `]e` / `[e` | Só erros |
| `]w` / `[w` | Só avisos |
| `<space>cd` | Mensagem completa da linha |
| `<space>xx` | Painel com todos os do projecto |
| `<space>xX` | Só os deste ficheiro |
| `<space>ca` | Code action — resolve muitos automaticamente |

Com o `ruff` como LSP, os avisos aparecem enquanto escreves. Muitos têm fix
automático em `<space>ca`.

## Pesquisa

**No ficheiro:** `/texto` para a frente, `?texto` para trás, `n`/`N` seguinte e
anterior, `*` procura a palavra sob o cursor. `<space>ur` limpa o realce.

**No projecto:** `<space>sg` faz grep, `<space>sw` procura a palavra sob o
cursor, `<space>sr` abre procurar-e-substituir em todos os ficheiros.

## Blocos e indentação

Python vive de indentação, e há objectos de texto para isso:

| Gesto | Efeito |
|---|---|
| `]i` / `[i` | Fim / início do bloco indentado actual |
| `vii` | Selecciona o bloco indentado |
| `vai` | Bloco indentado + a linha do `def`/`if` |
| `>>` / `<<` | Indenta / desindenta a linha |
| `>` / `<` em visual | Indenta a selecção (mantém-na seleccionada) |
| `<Ctrl-Space>` | Alarga a selecção pela árvore sintáctica, passo a passo |

`<Ctrl-Space>` repetido é a forma mais fiável de seleccionar exactamente o
bloco que queres: começa na palavra, depois a expressão, depois a linha, depois
o bloco, depois a função.

## Sessões

`<space>qs` na pasta do projecto restaura tudo como estava: buffers, divisões,
posição do cursor. Vale a pena habituares-te a abrir assim.
