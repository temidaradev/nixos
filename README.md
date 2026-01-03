# NixOS Configuration

This repository contains a NixOS configuration flake. It provides a complete desktop environment with Hyprland or Plasma KDE, development tools, gaming support, and various utilities for a productive Linux setup.

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
   sudo nixos-rebuild switch --flake .#temidaradev
   # or for Plasma
   sudo nixos-rebuild switch --flake .#temidaradev-plasma
   ```

4. Apply Home Manager configuration:
   ```bash
   home-manager switch --flake .#temidaradev
   # or for Plasma
   home-manager switch --flake .#temidaradev-plasma
   ```

## Hosts

| Host                 | Desktop      | Description                             |
| -------------------- | ------------ | --------------------------------------- |
| `temidaradev`        | Hyprland     | Wayland compositor with Caelestia shell |
| `temidaradev-plasma` | KDE Plasma 6 | Full-featured Plasma desktop with SDDM  |

## Features

### Desktop Environments

- **Hyprland**: Wayland compositor with Caelestia shell, Waybar, Rofi, and Wofi
- **Plasma KDE 6**: Full-featured desktop with KDE Connect, Spectacle, Kate, and Konsole

### Hardware Support

- **Graphics**: AMD GPU with Mesa, RADV Vulkan, ROCm OpenCL, and hardware video acceleration
- **CPU**: AMD processor optimizations with performance governor
- **Bluetooth**: BlueZ integration
- **Drawing Tablet**: OpenTabletDriver support
- **Sensors**: LM Sensors for hardware monitoring
- **Brightness**: DDC control and brightnessctl for display management

### Development Tools

- **Editors**: Neovim, VS Code, Helix, Zed, Cursor, JetBrains IDEs (Rust Rover, GoLand, CLion)
- **Languages**: Rust, Go, Zig, Python, Lua, Haskell, Odin, GCC
- **Tools**: Git, Make, UV (Python package manager), Arduino IDE, Docker, Cargo Tauri, Dioxus CLI

### Applications

- **Browsers**: Firefox, Librewolf, Zen Browser
- **Communication**: Discord, Slack, Telegram, Thunderbird, WhatsApp
- **Media**: MPV, Blender, YouTube Music, Jellyfin Media Player, Cava
- **Terminals**: Kitty, Ghostty, Konsole
- **File Managers**: Dolphin, Double Commander
- **Utilities**: qBittorrent, LocalSend, Nextcloud, Sioyek (PDF viewer)

### Gaming

- Steam with Proton support
- Lunar Client (Minecraft)
- osu!lazer
- Heroic Games Launcher
- Wine for Windows compatibility

### Services

- **VPN**: Mullvad VPN, ProtonVPN, Cloudflare WARP
- **Virtualization**: Docker, VMware Workstation
- **Database**: PostgreSQL
- **Crypto**: Monero node (pruned blockchain)
- **Other**: Flatpak, SSH, CUPS printing, fwupd firmware updates

### Audio

- PipeWire with PulseAudio and ALSA compatibility
- 32-bit audio support for games

## Structure

```
.
├── flake.nix                 # Flake definition with inputs and outputs
├── hosts/
│   ├── packages.nix          # Shared packages for all hosts
│   ├── temidaradev/          # Hyprland configuration
│   │   ├── machine.nix       # NixOS system configuration
│   │   ├── home.nix          # Home Manager configuration
│   │   ├── packages.nix      # Host-specific packages
│   │   └── hardware/         # Hardware configuration
│   └── temidaradev-plasma/   # Plasma configuration
│       ├── machine.nix
│       ├── home.nix
│       ├── packages.nix
│       └── hardware/
└── modules/
    ├── home/                 # Home Manager modules
    │   ├── desktop/          # Desktop environment configs
    │   ├── development/      # Development tools
    │   ├── fonts/            # Font configuration
    │   └── programs/         # Program configs (git, etc.)
    └── nixos/                # NixOS system modules
        ├── boot/             # Bootloader configuration
        ├── desktop/          # Display, audio, window managers
        ├── gaming/           # Steam and gaming support
        ├── hardware/         # Graphics, bluetooth, peripherals
        ├── networking/       # Network manager, VPN
        ├── services/         # System services
        ├── system/           # Locale, power, nix settings
        ├── users/            # User configuration
        └── virtualization/   # Docker, VMware
```

## Customization

### Host-Specific Configuration

Edit `hosts/yourhostname/` for your machine:

- `machine.nix`: NixOS system configuration
- `home.nix`: Home Manager user configuration
- `packages.nix`: Host-specific packages
- `hardware/hardware.nix`: Hardware settings (graphics driver, kernel modules, filesystems)

### Adding Packages

Add packages to `hosts/packages.nix` for shared packages, or `hosts/yourhostname/packages.nix` for host-specific ones:

```nix
{
  system = [ /* system-wide packages */ ];
  home = [ /* user packages */ ];
}
```

### Graphics Driver

Set in your `hardware/hardware.nix`:

```nix
temidaradev.hardware.graphics.driver = "amd";  # or "nvidia"
```

## Usage

### Switching Desktop Environments

```bash
# Switch to Hyprland
sudo nixos-rebuild switch --flake ~/.dotfiles#temidaradev
home-manager switch --flake ~/.dotfiles#temidaradev

# Switch to Plasma KDE
sudo nixos-rebuild switch --flake ~/.dotfiles#temidaradev-plasma
home-manager switch --flake ~/.dotfiles#temidaradev-plasma
```

After switching, log out and back in to use the new desktop environment.

### Updating the System

```bash
cd ~/.dotfiles
nix flake update
sudo nixos-rebuild switch --flake .#yourhostname
home-manager switch --flake .#yourhostname
```

### Garbage Collection

```bash
sudo nix-collect-garbage -d
```

## Flake Inputs

| Input             | Description                         |
| ----------------- | ----------------------------------- |
| `nixpkgs`         | NixOS unstable channel              |
| `home-manager`    | Home Manager for user configuration |
| `hyprland`        | Hyprland Wayland compositor         |
| `zen-browser`     | Zen Browser flake                   |
| `helium`          | Helium utilities                    |
| `caelestia-shell` | Caelestia shell for Hyprland        |

## Troubleshooting

- **Performance issues**: Check `modules/nixos/hardware/graphics/amd.nix` for GPU settings
- **Display issues**: Verify graphics configuration and check kernel parameters
- **Audio problems**: Ensure PipeWire is running: `systemctl --user status pipewire`
- **Permissions**: Ensure your user is in correct groups (`docker`, `video`, `render`, `wheel`)

## License

This configuration is provided as-is. Modify and distribute as needed.
