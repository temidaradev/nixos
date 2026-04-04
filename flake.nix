{
  description = "NixOS Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
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

  outputs = inputs@{ self, nixpkgs, zen-browser, helium, caelestia-shell, rusic, noctalia, noctalia-qs, ... }:
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
          ./nixos/desktop/window-managers/hyrpland.nix
          (nixpkgs + "/nixos/modules/misc/nixpkgs/read-only.nix")
          { nixpkgs.pkgs = pkgs; }
        ];
        specialArgs = {
          inherit helium system zen-browser rusic noctalia noctalia-qs caelestia-shell;
          inputs = { inherit helium rusic noctalia noctalia-qs caelestia-shell; };
        };
      };
    };
  };
}
