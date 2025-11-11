# Desktop Environment Switching Aliases for NixOS
# Add these to your ~/.zshrc or shell configuration

# Quick desktop environment switching
alias switch-hyprland='~/.dotfiles/switch-desktop.sh hyprland'
alias switch-plasma='~/.dotfiles/switch-desktop.sh plasma'
alias switch-kde='~/.dotfiles/switch-desktop.sh plasma'

# Manual switching (if you prefer more control)
alias rebuild-hyprland='sudo nixos-rebuild switch --flake ~/.dotfiles#temidaradev && home-manager switch --flake ~/.dotfiles#temidaradev'
alias rebuild-plasma='sudo nixos-rebuild switch --flake ~/.dotfiles#temidaradev-plasma && home-manager switch --flake ~/.dotfiles#temidaradev-plasma'

# Test configurations without switching (build only)
alias test-hyprland='sudo nixos-rebuild test --flake ~/.dotfiles#temidaradev'
alias test-plasma='sudo nixos-rebuild test --flake ~/.dotfiles#temidaradev-plasma'
