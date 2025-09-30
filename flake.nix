{
  description = "NixOS Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    hyprland.url = "github:hyprwm/Hyprland";
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager, hyprland, caelestia-shell, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      temidaradev = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./hosts/temidaradev/machine.nix
          hyprland.nixosModules.default
        ];
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
          inherit hyprland caelestia-shell;
        };
      };
    };
  };
}
