{lib, ...}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) bool either enum str;
  inherit (lib.nvim.types) mkPluginSetupOption;

  keymapType = either str (enum [false]);
in {
  options.vim.assistant.cursortab = {
    enable = mkEnableOption "cursortab.nvim AI edit completions and cursor predictions";

    setupOpts = mkPluginSetupOption "cursortab.nvim" {
      blink = {
        enabled = mkOption {
          type = bool;
          default = false;
          description = ''
            Enable native Blink completion integration and add the CursorTab
            provider to its default sources. Enable
            {option}`vim.autocomplete.blink-cmp.enable` separately.
          '';
        };

        ghost_text = mkOption {
          type = bool;
          default = true;
          description = "Show CursorTab ghost text alongside Blink completions.";
        };
      };

      keymaps = {
        accept = mkOption {
          type = keymapType;
          default = "<Tab>";
          description = ''
            Key to accept completions or cursor predictions. Set to `false`
            to disable the mapping.
          '';
        };

        partial_accept = mkOption {
          type = keymapType;
          default = "<S-Tab>";
          description = ''
            Key to accept completions word-by-word or line-by-line in insert
            mode. Set to `false` to disable the mapping.
          '';
        };

        trigger = mkOption {
          type = keymapType;
          default = false;
          example = "<C-Space>";
          description = ''
            Key to manually trigger a completion. Set to `false` to disable
            the mapping.
          '';
        };
      };

      provider = {
        type = mkOption {
          type = enum [
            "inline"
            "fim"
            "sweep"
            "zeta-2"
            "zeta"
            "copilot"
            "mercuryapi"
          ];
          default = "inline";
          example = "zeta-2";
          description = ''
            AI provider backend. `copilot` automatically enables
            {option}`vim.lsp.copilot-lsp.enable` and disables its next edit
            suggestion UI. Uses Copilot.lua's client when enabled; otherwise
            requires permission to use the unfree `copilot-language-server`
            package. Requires a Copilot subscription.
          '';
        };

        api_key_env = mkOption {
          type = str;
          default = "";
          example = "MERCURY_AI_TOKEN";
          description = ''
            Environment variable containing the provider API key. Leave empty
            for unauthenticated providers; restart the daemon after changes.
          '';
        };
      };
    };
  };
}
