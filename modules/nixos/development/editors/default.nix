{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim
    helix
    vscode
    zed-editor
    jetbrains.rust-rover
    jetbrains.goland
    jetbrains.clion
  ];
}
