# Atalhos

`<leader>` = **espaço**. Todos os atalhos abaixo foram extraídos da configuração
real (`:map`), não de documentação genérica.

> **Não decores isto.** Carrega em `<space>` e espera — o which-key mostra o
> menu. Esta página serve para consulta e para descobrires o que existe.
> `<space>sk` procura em todos os atalhos por nome.

## Essenciais do dia-a-dia

| Atalho | Acção |
|---|---|
| `<space><space>` | Procurar ficheiros (raiz do projecto) |
| `<space>/` | Grep no projecto |
| `<space>,` | Lista de buffers abertos |
| `<space>e` | Explorador de ficheiros |
| `<space>gg` | LazyGit |
| `<space>sk` | Procurar atalhos |
| `<space>?` | Atalhos do buffer actual |
| `<Ctrl-s>` | Gravar |
| `<Ctrl-/>` | Terminal |
| `<space>qq` | Sair de tudo |

## Ficheiros e pesquisa · `<space>f` e `<space>s`

| Atalho | Acção |
|---|---|
| `<space>ff` / `<space>fF` | Ficheiros na raiz / no cwd |
| `<space>fg` | Ficheiros versionados no git |
| `<space>fr` / `<space>fR` | Recentes (raiz / cwd) |
| `<space>fn` | Ficheiro novo |
| `<space>fp` | Projectos |
| `<space>fc` | Ficheiros de configuração do nvim |
| `<space>sg` / `<space>sG` | Grep (raiz / cwd) |
| `<space>sw` / `<space>sW` | Grep da palavra sob o cursor / selecção |
| `<space>sB` | Grep só nos buffers abertos |
| `<space>sb` | Procurar linhas no buffer actual |
| `<space>sr` | Procurar e substituir no projecto (grug-far) |
| `<space>sR` | Retomar a última pesquisa |
| `<space>sd` / `<space>sD` | Diagnósticos (projecto / buffer) |
| `<space>ss` / `<space>sS` | Símbolos LSP (documento / workspace) |
| `<space>sj` | Lista de saltos |
| `<space>su` | Árvore de undo |
| `<space>s"` | Registos (histórico de cópias) |
| `<space>sh` | Páginas de ajuda |

## Buffers e janelas · `<space>b` e `<space>w`

| Atalho | Acção |
|---|---|
| `<Shift-h>` / `<Shift-l>` | Buffer anterior / seguinte |
| `<space>bb` ou `` <space>` `` | Alternar com o buffer anterior |
| `<space>bd` | Fechar buffer (mantém a janela) |
| `<space>bD` | Fechar buffer e janela |
| `<space>bo` | Fechar todos os outros |
| `<space>bp` / `<space>bP` | Fixar buffer / fechar os não fixados |
| `<space>bl` / `<space>br` | Fechar os da esquerda / direita |
| `<space>-` / `<space>\|` | Dividir horizontal / vertical |
| `<Ctrl-w>` seguido de `h/j/k/l` | Mover entre janelas |
| `<Ctrl-w>` (e esperar) | Modo hydra: navega e redimensiona sem largar |
| `<Ctrl-Setas>` | Redimensionar janela |
| `<space>wd` | Fechar janela |
| `<space>wm` ou `<space>uZ` | Maximizar/restaurar (zoom) |
| `<space><Tab><Tab>` | Novo separador (tab) |
| `<space><Tab>]` / `[` | Separador seguinte / anterior |

## Código e LSP · `<space>c`

| Atalho | Acção |
|---|---|
| `gd` | Ir para definição |
| `gr` | Referências |
| `gI` | Implementações |
| `gy` | Definição do tipo |
| `gD` | Declaração |
| `K` | Documentação sob o cursor (hover) |
| `gK` | Assinatura da função |
| `gai` / `gao` | Chamadas a entrar / a sair (call hierarchy) |
| `<space>ca` | Code action / quick fix |
| `<space>cr` | Renomear símbolo |
| `<space>cR` | Renomear ficheiro (actualiza imports) |
| `<space>co` | Organizar imports |
| `<space>cd` | Diagnóstico da linha |
| `<space>cf` | Formatar agora |
| `<space>cs` / `<space>cS` | Símbolos / referências no Trouble |
| `<space>cl` | Estado dos servidores LSP |
| `<space>cm` | Mason (gestor de LSPs e ferramentas) |
| `<space>cv` | **Escolher virtualenv** |
| `<space>xx` / `<space>xX` | Painel de diagnósticos (projecto / buffer) |
| `]d` / `[d` | Diagnóstico seguinte / anterior |
| `]e` / `[e` | Erro seguinte / anterior (ignora avisos) |
| `]w` / `[w` | Aviso seguinte / anterior |
| `]]` / `[[` | Ocorrência seguinte / anterior do símbolo sob o cursor |
| `<M-n>` / `<M-p>` | O mesmo, em qualquer modo |

## Debug · `<space>d`

| Atalho | Acção |
|---|---|
| `<space>db` | Breakpoint on/off |
| `<space>dB` | Breakpoint condicional |
| `<space>dc` | Correr / continuar (escolhe a configuração) |
| `<space>da` | Correr com argumentos |
| `<space>dC` | Correr até ao cursor |
| `<space>dO` | Step over |
| `<space>di` | Step into |
| `<space>do` | Step out |
| `<space>dt` | Terminar sessão |
| `<space>dl` | Repetir a última sessão |
| `<space>du` | Painel de debug (dap-ui) |
| `<space>de` | Avaliar expressão (também em modo visual) |
| `<space>dw` | Inspeccionar valor sob o cursor |
| `<space>dr` | Consola REPL |
| `<space>dj` / `<space>dk` | Descer / subir na stack |
| `<space>dPt` / `<space>dPc` | Debug do método / da classe (Python) |

Ver [debug.md](debug.md) para o fluxo completo com FastAPI.

## Testes · `<space>t`

| Atalho | Acção |
|---|---|
| `<space>tr` | Correr o teste sob o cursor |
| `<space>tt` | Correr o ficheiro |
| `<space>tT` | Correr todos os testes |
| `<space>tl` | Repetir o último |
| `<space>td` | **Debug** do teste sob o cursor |
| `<space>ts` | Painel-resumo (navegável) |
| `<space>to` / `<space>tO` | Saída do teste / painel de saída |
| `<space>tw` | Modo watch (re-corre ao gravar) |
| `<space>tS` | Parar |

## Git · `<space>g`

| Atalho | Acção |
|---|---|
| `<space>gg` | LazyGit (raiz do repo) |
| `<space>gs` | Estado |
| `<space>gl` | Log |
| `<space>gd` / `<space>gD` | Diff dos hunks / contra a origin |
| `<space>gb` | Blame da linha |
| `<space>gf` | Histórico do ficheiro actual |
| `<space>gB` / `<space>gY` | Abrir / copiar link do browser |
| `<space>ghs` / `<space>ghr` | Stage / reset do hunk |
| `<space>ghS` / `<space>ghR` | Stage / reset do buffer |
| `<space>ghp` | Pré-visualizar hunk |
| `<space>ghu` | Desfazer stage |
| `]h` / `[h` | Hunk seguinte / anterior |

## HTTP · `<space>R` (em ficheiros `.http`)

| Atalho | Acção |
|---|---|
| `<space>Rs` | Enviar o pedido sob o cursor |
| `<space>Ra` | Enviar todos |
| `<space>Rr` | Repetir o último |
| `<space>Rt` | Alternar corpo / cabeçalhos |
| `<space>Rc` | Copiar como comando `curl` |
| `<space>Rn` / `<space>Rp` | Pedido seguinte / anterior |

Em qualquer ficheiro:

| Atalho | Acção |
|---|---|
| `<space>Ro` | Scratchpad HTTP |
| `<space>RO` | Explorador OpenAPI (lê o esquema do FastAPI) |
| `<space>Rf` | Procurar pedidos |
| `<space>Ri` | Importar `curl` da clipboard |

Ver [testes-e-http.md](testes-e-http.md).

## Interruptores · `<space>u`

| Atalho | Acção |
|---|---|
| `<space>uf` / `<space>uF` | Formatação ao gravar (global / buffer) |
| `<space>ud` | Diagnósticos on/off |
| `<space>uh` | Inlay hints (tipos inferidos) on/off |
| `<space>ul` / `<space>uL` | Números / números relativos |
| `<space>uw` | Quebra de linha |
| `<space>uz` / `<space>uZ` | Modo zen / zoom |
| `<space>ub` | Fundo claro/escuro |
| `<space>uC` | Trocar de tema |
| `<space>ur` | Limpar realce da pesquisa |
| `<space>ug` | Guias de indentação |

## Sessões · `<space>q`

| Atalho | Acção |
|---|---|
| `<space>qs` | Restaurar a sessão desta pasta |
| `<space>ql` | Restaurar a última sessão |
| `<space>qS` | Escolher sessão |
| `<space>qd` | Não gravar esta sessão |
| `<space>qq` | Sair de tudo |

Abre o nvim na pasta do projecto e faz `<space>qs` — volta tudo como estava
(buffers, janelas, posição do cursor).

## Movimento e edição (sem leader)

| Atalho | Acção |
|---|---|
| `s` | Flash — escreve 2 letras e salta para qualquer sítio no ecrã |
| `S` | Flash treesitter — selecciona blocos de código |
| `<Ctrl-Space>` | Alargar selecção pela árvore sintáctica |
| `gcc` / `gc` | Comentar linha / selecção |
| `<Ctrl-f>` / `<Ctrl-b>` | Página abaixo / acima |
| `<Ctrl-d>` / `<Ctrl-u>` | Meia página abaixo / acima |
| `<Ctrl-o>` / `<Ctrl-i>` | Voltar / avançar no histórico de saltos |
| `]i` / `[i` | Fim / início do bloco indentado actual |
| `]t` / `[t` | Comentário TODO seguinte / anterior |
| `]<space>` / `[<space>` | Inserir linha vazia abaixo / acima |
| `[%` / `]%` | Início / fim do bloco delimitado |
| `gx` | Abrir URL/ficheiro sob o cursor |
| `<` / `>` (visual) | Indentar mantendo a selecção |

Ver [navegacao.md](navegacao.md) para os movimentos base do vim.
