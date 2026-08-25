-- Equivalente Lua de ~/.config/hypr/monitors.conf
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

hl.env("GDK_SCALE", "1")

-- Monitor da Esquerda (Laptop - posição zero)
hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1 })

-- Monitor da Direita (AOC - à direita do laptop, fisicamente à direita do utilizador)
-- AOC CU34G4: ultrawide curvo 34", nativa 3440x1440 (não 3840x2160)
-- Usar desc: em vez do porto (DP-4/DP-5 muda entre boots/docks)
hl.monitor({
  output = "desc:AOC CU34G4 2SES4HA008623",
  mode = "3440x1440@100",
  position = "1920x0",
  scale = 1,
})

-- Nota: o monitors.lua stock do Omarchy traz um catch-all
--   hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
-- O teu .conf não tinha equivalente, por isso não o incluí. Descomenta se
-- quiseres que um terceiro ecrã (dock, projetor) se configure sozinho:
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- Fixa os workspaces a cada monitor para não haver confusão nas chamadas
hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "desc:AOC CU34G4 2SES4HA008623" })
