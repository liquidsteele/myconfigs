# Backup de configurações — Omarchy 4

Snapshot das configurações desta máquina depois do upgrade para **Omarchy 4.0.1**
(hyprlang `.conf` → Lua). Gerado a **2026-08-25**.

O que está aqui é só configuração e listas de instalação. Nada disto é aplicado
automaticamente — cada secção abaixo diz para onde copiar.

> **Antes de restaurar seja o que for**, faz um snapshot:
> `omarchy snapshot create`

---

## Onde vai cada coisa

| deste repo | copiar para |
|---|---|
| `shell/zshrc` | `~/.zshrc` |
| `hypr/*.lua`, `hypr/*.conf`, `hypr/.luarc.json` | `~/.config/hypr/` |
| `omarchy/shell.json` | `~/.config/omarchy/shell.json` |
| `omarchy/extensions/omarchy-menu.jsonc` | `~/.config/omarchy/extensions/` |
| `omarchy/hooks/post-update.d/setup-agent.hook` | `~/.config/omarchy/hooks/post-update.d/` |
| `omarchy/themed/alacritty.toml.tpl.sample` | `~/.config/omarchy/themed/` |
| `terminals/alacritty.toml` | `~/.config/alacritty/alacritty.toml` |
| `terminals/kitty.conf` | `~/.config/kitty/kitty.conf` |
| `tools/btop.conf` | `~/.config/btop/btop.conf` |
| `tools/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `tools/git-config` | `~/.config/git/config` |
| `tools/superfile/*` | `~/.config/superfile/` |
| `hypr/legacy-omarchy3/` | **não copiar** — só referência, ver abaixo |

Restauro completo de uma vez:

```bash
cd ~/myconfigs/omarchy4
cp shell/zshrc                          ~/.zshrc
cp hypr/*.lua hypr/*.conf hypr/.luarc.json ~/.config/hypr/
mkdir -p ~/.config/omarchy/{extensions,themed,hooks/post-update.d}
cp omarchy/shell.json                   ~/.config/omarchy/
cp omarchy/extensions/*.jsonc           ~/.config/omarchy/extensions/
cp omarchy/hooks/post-update.d/*.hook   ~/.config/omarchy/hooks/post-update.d/
cp omarchy/themed/*.sample              ~/.config/omarchy/themed/
cp terminals/alacritty.toml             ~/.config/alacritty/
cp terminals/kitty.conf                 ~/.config/kitty/
cp tools/btop.conf                      ~/.config/btop/
cp tools/tmux.conf                      ~/.config/tmux/
cp tools/git-config                     ~/.config/git/config
cp tools/superfile/*.toml               ~/.config/superfile/

hyprctl reload && hyprctl configerrors   # tem de vir vazio
omarchy restart shell
omarchy restart terminal
exec zsh
```

---

## ⚠️ Segredos

O `shell/zshrc` **não** tem a `OPENROUTER_API_KEY` — foi removida porque este
repo vai para o GitHub. A linha original está comentada no sítio onde estava.

A chave que estava no `~/.zshrc` desta máquina **já esteve exposta** (o próprio
comentário no ficheiro dizia isso). Roda-a em
<https://openrouter.ai/settings/keys> e passa a guardá-la fora do repo:

```bash
mkdir -p ~/.config/zsh
echo 'export OPENROUTER_API_KEY="sk-or-v1-..."' > ~/.config/zsh/secrets.zsh
chmod 600 ~/.config/zsh/secrets.zsh
```

E no `~/.zshrc`, no lugar da linha antiga:

```bash
[[ -f ~/.config/zsh/secrets.zsh ]] && source ~/.config/zsh/secrets.zsh
```

Assim o `.zshrc` continua versionável e a chave nunca entra no git.

---

## Shell

`shell/zshrc` é o `.zshrc` completo: oh-my-zsh com tema `agnoster`, auto-venv
para uv/poetry, aliases (`k`, `t`, `awsp`, `pa`, `ls`→eza, `cat`→bat, `cd`→z,
`f`→superfile) e a integração do fzf/zoxide/thefuck.

**`shell/zsh-plugins.md`** tem os comandos de instalação do oh-my-zsh, dos dois
plugins externos (`zsh-autosuggestions`, `zsh-syntax-highlighting`) e a tabela
de binários que o `.zshrc` assume — sem eles a shell arranca com erros.

---

## Hyprland

`hypr/` tem os ficheiros **Lua** que estão ativos no Omarchy 4:
`hyprland.lua`, `monitors.lua`, `input.lua`, `bindings.lua`, `looknfeel.lua`,
`autostart.lua`, mais `hyprsunset.conf` e `xdph.conf` (estes dois continuam em
formato `.conf` porque são lidos por outros processos).

Os defaults do Omarchy **já não vivem no `~/.config`** — estão em
`/usr/share/omarchy/` (propriedade do pacote, só de leitura). Os ficheiros do
`~/.config/hypr/` são carregados *depois* dos defaults, por isso só precisam de
declarar o que muda.

Depois de restaurar: `hyprctl reload && hyprctl configerrors` (tem de vir vazio).

### `hypr/legacy-omarchy3/` — não restaurar

São os `.conf` do Omarchy 3, guardados só como referência do que ainda falta
portar para Lua:

- `monitors.conf` — o setup dos dois ecrãs (eDP-1 + AOC CU34G4 por `desc:`)
- `bindings.conf` — as 26 keybindings antigas; **24 passaram a default no
  Omarchy 4**, só faltam duas: btop em `SUPER+SHIFT+T` e Typora em
  `SUPER+SHIFT+W` (esta exige `hl.unbind` antes, porque o 4.0 usa-a para o
  Omawrite)
- `input.conf` — layout `pt`, repeat 40/600, numlock, `scroll_factor` 0.4
- `hyprlock.conf` / `hypridle.conf` — **sem caminho de conversão.** Os pacotes
  `hyprlock` e `hypridle` deixaram de existir no Omarchy 4; o lock passou a ser
  um plugin do omarchy-shell e o idle configura-se em
  `~/.config/omarchy/shell.json` (`idle.screensaver`, `idle.lock`)
- `lua-preview/` — conversão já preparada dos `.conf` acima para Lua, validada
  contra a API da v4.0.0. Copiar por cima dos `hypr/*.lua` quando quiseres o
  setup antigo de volta

---

## Omarchy

`omarchy/shell.json` é a config da barra e do idle (screensaver a 900s = 15 min,
lock a 1200s = 20 min, posição no topo). Hot-reload ao gravar; se não pegar,
`omarchy restart shell`.

Os dois valores de idle contam **desde o mesmo instante** (o início do idle), não
são encadeados: o `lock` tem de ser sempre maior que o `screensaver`, senão o
ecrã bloqueia antes de o screensaver chegar a aparecer.

### Temas

Os temas instalados são clones git (~1.5 GB) — **não estão neste repo**, só a
lista em `omarchy/themes.tsv` com o nome e o URL de origem de cada um.

```bash
bash omarchy/reinstall-themes.sh     # reinstala os 21 via omarchy theme install
```

Tema ativo quando isto foi gerado: **kanagawa** (stock, não precisa de clone).

```bash
omarchy theme set kanagawa
omarchy theme extras     # lista os temas instalados por git clone
omarchy theme update     # atualiza-os
```

---

## Pacotes

```bash
# repositórios oficiais (217 pacotes explícitos)
sudo pacman -S --needed - < packages/pacman-explicit.txt

# AUR (6 pacotes) — precisa de yay/paru
yay -S --needed - < packages/aur-foreign.txt

# extensões do VS Code (32)
cat packages/vscode-extensions.txt | xargs -L1 code --install-extension
```

A lista do pacman é o estado *depois* do upgrade para a 4.0.1, por isso já não
inclui o que o Omarchy 4 retirou (waybar, mako, walker/elephant, hypridle,
hyprlock, swayosd, iwd, etc.).

**Nota:** o Neovim desta máquina está instalado à mão em
`/opt/nvim-linux-x86_64/` (fora do pacman) e o `.zshrc` põe isso no PATH.
A config do Neovim está na pasta `../nvim/` deste mesmo repo.

---

## Se o setup se perder por completo

1. Instalar Omarchy de raiz (ISO) — já vem na versão 4.x
2. `sudo pacman -S --needed - < packages/pacman-explicit.txt`
3. Instalar o yay e depois os pacotes AUR
4. oh-my-zsh + os dois plugins (`shell/zsh-plugins.md`)
5. Restaurar os ficheiros com o bloco de comandos do topo
6. `bash omarchy/reinstall-themes.sh` e `omarchy theme set kanagawa`
7. Recriar `~/.config/zsh/secrets.zsh` com a chave nova (secção Segredos)
8. Reboot
