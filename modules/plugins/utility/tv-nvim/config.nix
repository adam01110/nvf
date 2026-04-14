{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.dag) entryAnywhere;
  inherit (lib.nvim.lua) toLuaObject;

  cfg = config.vim.utility.tv-nvim;
in {
  config = mkIf cfg.enable {
    vim = {
      startPlugins = ["tv-nvim"];
      extraPackages = [cfg.package];

      pluginRC.tv-nvim = entryAnywhere ''
        -- Description of each option can be found in https://github.com/alexpasmantier/tv.nvim#configuration
        require("tv").setup(${toLuaObject cfg.setupOpts})
      '';
    };
  };
}
