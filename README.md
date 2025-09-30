# NixOS Configuration

This repository contains a NixOS configuration flake. It provides a complete desktop environment with Hyprland window manager, development tools, and various utilities for a productive Linux setup.

## Requirements

- NixOS (unstable channel recommended)
- Git
- Basic understanding of Nix and NixOS

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/temidaradev/nixos.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Update the flake inputs:

   ```bash
   nix flake update
   ```

3. Build and switch to the NixOS configuration:

   ```bash
   sudo nixos-rebuild switch --flake .#yourhostname
   ```

4. Apply Home Manager configuration:
   ```bash
   home-manager switch --flake .#yourhostname
   ```

## Features

### Hardware

- **Graphics**: AMD GPU support with Mesa drivers
- **Bluetooth**: Enabled with BlueZ
- **Sensors**: LM Sensors for hardware monitoring
- **Brightness**: DDC control and brightnessctl for display management
- **Udev Rules**: Custom rules for hardware devices

### Development Tools

- **Editors**: Neovim, VS Code, Helix, Zed, JetBrains IDEs (Rust Rover, GoLand, CLion)
- **Languages**: Python, Go, Zig, Haskell, Odin, Lua
- **Tools**: Git, Make, UV (Python package manager), Arduino IDE, Godot

### Applications

- **Browsers**: Firefox
- **Communication**: Slack, Discord, Telegram, Thunderbird
- **Media**: MPV, Blender, YouTube Music
- **Utilities**: Kitty terminal, Dolphin file manager, Rofi launcher

### Gaming

- Steam integration
- Lunar Client
- Wine for Windows compatibility

### Virtualization

- Docker
- VMware Workstation

## Customization

### Host-Specific Configuration

Edit `hosts/yourhostname/` for your machine:

- `machine.nix`: NixOS system configuration
- `home.nix`: Home Manager user configuration
- `packages.nix`: System and user packages
- `hardware/hardware.nix`: Hardware-specific settings (e.g., kernel modules, firmware)

### Modules

Modify modules in `modules/`:

- `modules/nixos/`: System-level modules
- `modules/home/`: User-level modules

### Adding Packages

Add packages to `hosts/yourhostname/packages.nix` under `system` or `home` lists.

## Usage

### Updating the System

```bash
sudo nixos-rebuild switch --flake ~/.dotfiles#yourhostname
home-manager switch --flake ~/.dotfiles#yourhostname
```

### Updating Flake Inputs

```bash
cd ~/.dotfiles
nix flake update
```

### Garbage Collection

```bash
sudo nix-collect-garbage -d
```

## Troubleshooting

- If you encounter issues with hardware, check `hardware/hardware.nix`
- For display issues, verify AMD graphics configuration in display modules
- Ensure your user is in the correct groups (e.g., `docker`, `wheel`)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `nixos-rebuild build --flake .#yourhostname`
5. Submit a pull request

## License

This configuration is provided as-is. Modify and distribute as needed.
