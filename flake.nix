{
  description = "NixOS Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
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

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = {self, nixpkgs, home-manager, hyprland, zen-browser, helium, caelestia-shell, ... }:
    let
      system = "x86_64-linux";

      overlays = [
        (final: prev: {
          hyprland = prev.hyprland.overrideAttrs (old: {
            nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ final.git ];
          });
        })
      ];
      pkgs = import nixpkgs { inherit system; overlays = overlays; };
      lib = pkgs.lib;
    in {
    nixosConfigurations = {
      temidaradev = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./hosts/temidaradev/machine.nix
          hyprland.nixosModules.default
        ];
        specialArgs = {
          inherit helium system;
          inputs = { inherit helium; };
        };
      };
      temidaradev-plasma = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./hosts/temidaradev-plasma/machine.nix
        ];
        specialArgs = {
          inherit helium system;
          inputs = { inherit helium; };
        };
      };
    };
    homeConfigurations = {
      temidaradev = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./hosts/temidaradev/home.nix
          hyprland.homeManagerModules.default
        ];
        extraSpecialArgs = {
          inherit hyprland caelestia-shell zen-browser helium;
        };
      };
      temidaradev-plasma = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./hosts/temidaradev-plasma/home.nix
        ];
        extraSpecialArgs = {
          inherit zen-browser helium;
        };
      };
    };
  };
}
