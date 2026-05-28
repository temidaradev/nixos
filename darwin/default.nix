{ ... }:

{
  imports = [
    ../shared/git.nix
    ./homebrew
    ./system
    ./users
  ];
}
