{ pkgs, lib, ... }:

let
  base = ''
    [user]
    	name = temidaradev
    	email = temidaradev@proton.me
    	signingkey = CF0CCF7E9AD5BD9D
    [commit]
    	gpgsign = true
    [tag]
    	gpgsign = true
  '';

  darwinExtra = ''
    [credential]
    	helper = osxkeychain
  '';

  gitconfig = pkgs.writeText "gitconfig"
    (base + lib.optionalString pkgs.stdenv.isDarwin darwinExtra);
in
{
  environment.variables.GIT_CONFIG_SYSTEM = "${gitconfig}";
}
