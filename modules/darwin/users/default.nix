{ pkgs, ... }:

{
  users.users.lidldev = {
    name = "lidldev";
    home = "/Users/lidldev";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  environment.systemPackages = [ pkgs.nh ];

  environment.variables.NH_FLAKE = "/Users/lidldev/Projects/nix-config";
}
