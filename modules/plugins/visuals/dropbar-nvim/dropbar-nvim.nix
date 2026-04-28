{lib, ...}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.nvim.types) mkPluginSetupOption;
in {
  options.vim.visuals.dropbar-nvim = {
    enable = mkEnableOption "IDE-like breadcrumbs, out of the box [dropbar.nvim]";

    setupOpts = mkPluginSetupOption "dropbar.nvim" {};
  };
}
