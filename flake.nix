{
  description = "NixOS Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager, hyprland, zen-browser, caelestia-shell, ... }:
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
          inherit hyprland caelestia-shell zen-browser;
        };
      };
    };
  };
}
