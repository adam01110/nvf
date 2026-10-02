{
  lib,
  pins,
  fetchFromGitHub,
  buildGoModule,
  vimUtils,
}: let
  pin = pins.cursortab-nvim;
  version = lib.removePrefix "v" pin.version;
  src = fetchFromGitHub {
    inherit (pin.repository) owner repo;
    rev = pin.revision;
    hash = pin.hash;
  };

  cursortab-server = buildGoModule {
    pname = "cursortab";
    inherit version src;
    modRoot = "server";
    subPackages = ["."];
    vendorHash = "sha256-4S14Vm2Ju084uxB2Zlku4z5AmIZkNZkQpiNgYrcqIbg=";

    # Recognize the native Neovim client supplied by copilot-lsp.
    postPatch = ''
      substituteInPlace server/buffer/buffer.go --replace-fail 'clients = vim.lsp.get_clients({name = "GitHub Copilot"})' 'clients = vim.lsp.get_clients({name = "copilot_ls"})
      if #clients > 0 then return clients[1] end
      clients = vim.lsp.get_clients({name = "GitHub Copilot"})'
    '';

    meta.mainProgram = "cursortab";
  };
in
  vimUtils.buildVimPlugin {
    pname = "cursortab-nvim";
    inherit version src;

    postInstall = ''
      ln -s ${lib.getExe cursortab-server} "$out/server/cursortab"
    '';

    meta = {
      description = "Edit completions and cursor predictions for Neovim";
      homepage = "https://github.com/cursortab/cursortab.nvim";
      license = lib.licenses.mit;
    };
  }
