{
  description = "NixOS Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rusic.url = "github:temidaradev/rusic";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
        ];
      };
    in {
    nixosConfigurations = {
      temidaradev = lib.nixosSystem {
        modules = [
          ./machine.nix
          ./nixos/desktop/window-managers/niri.nix
          (nixpkgs + "/nixos/modules/misc/nixpkgs/read-only.nix")
          inputs.noctalia.nixosModules.default
          { services.noctalia-shell.enable = true; }
          { nixpkgs.pkgs = pkgs; }
        ];
        specialArgs = {
          inherit system inputs;
        };
      };
    };
  };
}
