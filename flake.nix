{
  description = "Declarative Neovim setup with all external tooling";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        runtimeDeps = with pkgs; [
          git
          lazygit
          ripgrep
          fd
          nodejs_20
          nodePackages.prettier
          stylua
          python311
          python311Packages.yapf
          dioxus-cli
          gnumake
          gcc
          pkg-config
        ];

        configDir = pkgs.stdenvNoCC.mkDerivation {
          name = "gustav-nvim-config";
          src = self;
          installPhase = ''
            mkdir -p $out/config/nvim
            cp -r init.lua lazy-lock.json lua $out/config/nvim/
          '';
        };

        gustavNvim = pkgs.writeShellApplication {
          name = "gustav-nvim";
          runtimeInputs = runtimeDeps ++ [ pkgs.neovim ];
          text = ''
            export XDG_CONFIG_HOME=${configDir}/config
            exec nvim "$@"
          '';
        };
      in {
        packages = {
          default = gustavNvim;
          nvim = gustavNvim;
        };

        apps.default = flake-utils.lib.mkApp {
          drv = gustavNvim;
        };

        devShells.default = pkgs.mkShell {
          packages = runtimeDeps ++ [ pkgs.neovim ];
          shellHook = ''
            export NVIM_APPNAME=gustav
            echo "Dev shell ready. Symlink this repo to ~/.config/nvim or run 'nix run' for the wrapped build."
          '';
        };
      });
}
