# Plugins e ferramentas da shell

## oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
Tema: `agnoster` (vem com o oh-my-zsh, não precisa de instalação).

## Plugins externos (clonar para o custom do oh-my-zsh)
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Os restantes plugins da lista do `.zshrc` (`git fzf docker kubectl terraform aws
poetry uv`) são built-in do oh-my-zsh — não precisam de clone, mas os binários
correspondentes têm de existir.

## Binários que o .zshrc assume
Sem estes, o arranque da shell dá erros:

| comando | pacote | usado para |
|---|---|---|
| `fzf` | `fzf` | plugin fzf, alias `awsp`, `_fzf_comprun` |
| `eza` | `eza` | alias `ls`, previews do fzf |
| `bat` | `bat` | alias `cat`, previews do fzf |
| `zoxide` | `zoxide` | `eval "$(zoxide init zsh)"`, alias `cd` |
| `thefuck` | `thefuck` (AUR) | aliases `fuck` / `fk` |
| `spf` | `superfile` | função `spf`, alias `f` |
| `tmux` | `tmux` | alias `tx` |
| `uv` | `uv` | aliases `uv*` e auto-venv |
| `poetry` | `python-poetry` | auto-venv |
| `kubectl` `terraform` `aws` `docker` | vários | plugins e aliases |

## Extra
```bash
# esconder o nome da branch no prompt agnoster dentro de ~
git -C ~ config oh-my-zsh.hide-status 1
```

## PATHs assumidos pelo .zshrc
- `$HOME/.local/bin`
- `/usr/local/go/bin`
- `/opt/nvim-linux-x86_64/bin`  (instalação manual do Neovim, fora do pacman)
