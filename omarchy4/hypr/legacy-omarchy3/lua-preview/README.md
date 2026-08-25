# Preview da migração hyprlang → Lua (Omarchy 4.0)

Nada aqui está ativo. O Hyprland só lê `~/.config/hypr/hyprland.lua` (raiz);
ficheiros dentro desta subpasta são ignorados. Os teus `.conf` continuam a
mandar.

Gerado a 2026-08-17 contra a tag `v4.0.0` do Omarchy e os stubs oficiais da API
em `/usr/share/hypr/stubs/hl.meta.lua` (Hyprland 0.56.2). Todos os ficheiros
passaram `luac -p`.

## Como usar no dia do upgrade

Depois de o Omarchy 4.0 pôr os `.lua` stock em `~/.config/hypr/` (e mandar os
teus `.conf` para `.bak.<timestamp>`):

| deste ficheiro | copia para |
|---|---|
| `monitors.lua` | `~/.config/hypr/monitors.lua` (substitui) |
| `input.lua` | `~/.config/hypr/input.lua` (substitui) |
| `looknfeel.lua` | `~/.config/hypr/looknfeel.lua` (substitui) |
| `bindings.lua` | `~/.config/hypr/bindings.lua` (substitui) |
| `autostart.lua` | `~/.config/hypr/autostart.lua` (substitui) |
| `hyprland.lua.snippet` | **não substituir** — colar o bloco no fim do `hyprland.lua` do Omarchy |

O `hyprland.lua` é o entrypoint do Omarchy e não deve ser substituído: no 4.0
ele faz `dofile` do bootstrap e `require("default.hypr.omarchy")` antes de
carregar os teus ficheiros. Substituí-lo parte tudo.

Depois: `hyprctl reload` e confirmar com `hyprctl monitors`.

## Equivalências usadas

| hyprlang | Lua |
|---|---|
| `env = GDK_SCALE,1` | `hl.env("GDK_SCALE", "1")` |
| `monitor = X, mode, pos, scale` | `hl.monitor({ output=, mode=, position=, scale= })` |
| `workspace = 1, monitor:eDP-1` | `hl.workspace_rule({ workspace="1", monitor="eDP-1" })` |
| `input { ... }` | `hl.config({ input = { ... } })` |
| `general { ... }` | `hl.config({ general = { ... } })` |
| `misc { ... }` | `hl.config({ misc = { ... } })` |
| `windowrule = match:class X, rule v` | `o.window("X", { rule = v })` |
| `bindd = MOD, KEY, Desc, exec, uwsm-app -- cmd` | `o.bind("MOD + KEY", "Desc", { launch = "cmd" })` |
| `... omarchy-launch-webapp URL` | `{ webapp = "URL" }` (com `focus = true` para or-focus) |
| `... omarchy-launch-tui X` | `{ tui = "X" }` (com `focus = true` para or-focus) |
| `... omarchy-launch-Y` | `{ omarchy = "Y" }` |
| `unbind = MOD, KEY` | `hl.unbind("MOD + KEY")` |

O selector `desc:` mantém-se igual — `output` é uma string e aceita a mesma
sintaxe do hyprlang (`HL.MonitorSpec.output: string`).

## Ressalvas

- A `v4.0.0` é uma tag de pré-lançamento que ainda não chegou ao canal stable.
  A API pode mudar até lá — revalida antes de aplicar.
- Os stubs são do Hyprland 0.56.2 instalado; o Omarchy 4.0 pode exigir um
  Hyprland mais recente.
- Nada disto foi executado. É conversão verificada contra a API, não testada
  em runtime.
