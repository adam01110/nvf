{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.meta) getExe;
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.dag) entryAfter;

  cfg = config.vim.lsp.copilot-lsp;
  upstream = field: mkDefault (mkLuaInline "vim.lsp.config.copilot_ls.${field}");
in {
  config = mkIf cfg.enable {
    vim = {
      lazy.plugins.copilot-lsp = {
        package = "copilot-lsp";
        setupModule = "copilot-lsp";
        inherit (cfg) setupOpts;
        lazy = mkIf cfg.server.enable false;

        event = {
          event = "User";
          pattern = "LazyFile";
        };
      };

      luaConfigRC.lsp-servers = mkIf cfg.server.enable (entryAfter ["lazyConfigs"] "");

      lsp.servers.copilot_ls = mkIf cfg.server.enable {
        enable = true;
        cmd = [(getExe pkgs.copilot-language-server) "--stdio"];
        init_options = upstream "init_options";
        settings = upstream "settings";
        handlers = upstream "handlers";
        root_dir = upstream "root_dir";
        # An omitted callback would restore the plugin's NES UI on merge.
        on_init =
          if cfg.nes.enable
          then upstream "on_init"
          else mkLuaInline "function() end";
      };
    };
  };
}
