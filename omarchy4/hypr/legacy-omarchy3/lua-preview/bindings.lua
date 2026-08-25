-- Equivalente Lua de ~/.config/hypr/bindings.conf
--
-- IMPORTANTE: no Omarchy 4.0 a esmagadora maioria dos teus bindds passou a ser
-- default (default/hypr/bindings/applications.lua). Redeclará-los aqui só cria
-- ruído. Verifiquei um a um contra os defaults do v4.0.0 e sobram DOIS deltas.
--
-- Já default no 4.0 (não precisas de nada): SUPER+RETURN, SUPER+ALT+RETURN,
-- SUPER+SHIFT+{RETURN,F,B,M,N,D,G,O,SLASH,A,C,E,Y,P,X}, SUPER+ALT+SHIFT+F,
-- SUPER+SHIFT+ALT+{B,M,A,G,X}, SUPER+SHIFT+CTRL+G.
--
-- Ver bindings atuais: omarchy menu keybindings --print

-- [DELTA 1] btop em SUPER+SHIFT+T.
-- Verifiquei: nenhum default do 4.0 usa SUPER+SHIFT+T, logo não é preciso unbind.
o.bind("SUPER + SHIFT + T", "Activity", { tui = "btop" })

-- [DELTA 2] Typora em SUPER+SHIFT+W.
-- CONFLITO: o 4.0 mapeia SUPER+SHIFT+W para o Omawrite
-- (default/hypr/bindings/applications.lua:19), por isso é obrigatório
-- desfazer o binding antes de o reclamar.
hl.unbind("SUPER + SHIFT + W")
o.bind("SUPER + SHIFT + W", "Typora", { launch = "typora --enable-wayland-ime" })

-- Nota: o 4.0 acrescenta bindings que ainda não tens, entre eles
-- SUPER+SHIFT+S (Google Maps) e SUPER+CTRL+RETURN (Herdr). Se colidirem com
-- hábitos teus, desfaz com hl.unbind("SUPER + SHIFT + S").
