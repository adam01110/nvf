{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption mkPackageOption;
  inherit (lib.nvim.types) mkPluginSetupOption;
in {
  options.vim.utility.tv-nvim = {
    enable = mkEnableOption ''
      Neovim integration for the television fuzzy finder [tv-nvim]
    '';

    package = mkPackageOption pkgs "television" {
      default = ["television"];
    };

    setupOpts = mkPluginSetupOption "tv-nvim" {};
  };
}
