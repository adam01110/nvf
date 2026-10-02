{lib, ...}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) bool;
  inherit (lib.nvim.types) mkPluginSetupOption;
in {
  options.vim.lsp.copilot-lsp = {
    enable = mkEnableOption "Copilot LSP integration";

    server.enable = mkOption {
      type = bool;
      default = true;
      description = ''
        Start the unfree `copilot-language-server` package.
        Disabled by Copilot.lua, which manages its own client.
      '';
    };

    nes.enable = mkOption {
      type = bool;
      default = true;
      description = "Enable next edit suggestion UI.";
    };

    setupOpts = mkPluginSetupOption "copilot-lsp" {};
  };
}
