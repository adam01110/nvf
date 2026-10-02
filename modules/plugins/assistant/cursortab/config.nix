{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.dag) entryAnywhere;
  inherit (lib.nvim.lua) toLuaObject;

  cfg = config.vim.assistant.cursortab;
  copilotProvider = cfg.setupOpts.provider.type == "copilot";
in {
  config = mkIf cfg.enable {
    vim = {
      autocomplete.blink-cmp = mkIf cfg.setupOpts.blink.enabled {
        setupOpts.sources = {
          default = ["cursortab"];
          providers.cursortab = {
            name = "CursorTab";
            module = "cursortab.blink";
            async = true;
            score_offset = 50;
            timeout_ms = cfg.setupOpts.provider.completion_timeout or 5000;
          };
        };
      };

      lsp.copilot-lsp = mkIf copilotProvider {
        enable = true;
        nes.enable = false;
      };

      startPlugins = ["cursortab-nvim"];
      pluginRC.cursortab = entryAnywhere ''
        require("cursortab").setup(${toLuaObject cfg.setupOpts})
      '';
    };
  };
}
