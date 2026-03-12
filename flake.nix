{
  description = "NixOS Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rusic.url = "github:temidaradev/rusic";

    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, hyprland, zen-browser, helium, caelestia-shell, rusic, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            hyprland = prev.hyprland.overrideAttrs (old: {
              nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ prev.git ];
            });
          })
        ];
      };
    in {
    nixosConfigurations = {
      temidaradev = lib.nixosSystem {
        modules = [ 
          ./machine.nix
          hyprland.nixosModules.default
          (nixpkgs + "/nixos/modules/misc/nixpkgs/read-only.nix")
          { nixpkgs.pkgs = pkgs; }
        ];
        specialArgs = {
          inherit helium system zen-browser caelestia-shell rusic;
          inputs = { inherit helium rusic; };
        };
      };
    };
  };
}
