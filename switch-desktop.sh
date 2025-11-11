#!/usr/bin/env bash
# Script to easily switch between desktop environments

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAKE_DIR="$SCRIPT_DIR"

case "$1" in
    hyprland)
        echo "Switching to Hyprland..."
        sudo nixos-rebuild switch --flake "$FLAKE_DIR#temidaradev"
        home-manager switch --flake "$FLAKE_DIR#temidaradev"
        echo "✓ Switched to Hyprland. Please log out and log back in."
        ;;
    plasma)
        echo "Switching to Plasma KDE..."
        sudo nixos-rebuild switch --flake "$FLAKE_DIR#temidaradev-plasma"
        home-manager switch --flake "$FLAKE_DIR#temidaradev-plasma"
        echo "✓ Switched to Plasma KDE. Please log out and log back in."
        ;;
    *)
        echo "Usage: $0 {hyprland|plasma}"
        echo ""
        echo "Examples:"
        echo "  $0 hyprland    # Switch to Hyprland"
        echo "  $0 plasma      # Switch to Plasma KDE"
        exit 1
        ;;
esac
