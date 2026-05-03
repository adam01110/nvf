{lib, ...}: let
  inherit (lib.modules) mkRemovedOptionModule;
in {
  imports = [
    (mkRemovedOptionModule ["vim" "visuals" "enable"] ''
      As top-level toggles are being deprecated, you are encouraged to handle plugin
      toggles under individual options.
    '')

    ./blink-indent
    ./cellular-automaton
    ./cinnamon-nvim
    ./dropbar-nvim
    ./fidget-nvim
    ./highlight-undo
    ./hlargs-nvim
    ./indent-blankline
    ./neoscroll-nvim
    ./nvim-cursorline
    ./nvim-scrollbar
    ./nvim-web-devicons
    ./rainbow-delimiters
    ./satellite-nvim
    ./twilight-nvim
    ./tiny-devicons-auto-colors
    ./syntax-gaslighting
  ];
}
