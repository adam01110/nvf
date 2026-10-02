{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.copilot-language-server;
in {
  options.vim.lsp.presets.copilot-language-server = {
    enable = mkLspPresetEnableOption {
      option = "copilot_ls";
      display = "GitHub Copilot";
      extra = ''
        Requires Copilot access and permission to use the unfree
        `copilot-language-server` package.
      '';
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.copilot-lsp.enable = true;
  };
}
