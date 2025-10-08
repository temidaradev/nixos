{ pkgs }:

with pkgs; {
  system = [
    # Gaming
    lunar-client

    # Networking
    cloudflare-warp
    protonvpn-gui

    # Hardware
    qt6.full

    # Virtualization
    vmware-workstation
    docker

    # Desktop
    bibata-cursors

    # Development tools
    git
    gnumake
    unzip
    btop
    fastfetch
    arduino-ide
    ddcutil
    brightnessctl
    networkmanager
    lm_sensors
    fish
    android-studio
    aubio
    pipewire
    swappy
    libqalculate
    material-symbols
    nerd-fonts.caskaydia-cove
    kitty
    discord
    slack

    # Editors
    vim
    neovim
    helix
    vscode
    zed-editor
    jetbrains.rust-rover
    jetbrains.goland
    jetbrains.clion

    # Languages
    python312
    uv
    odin
    ghc
    cabal-install
    go
    zig
    lua
  ];

  home = [
    # Desktop tools
    wl-clipboard
    grim
    slurp
    imagemagick
    nixos-icons
    papirus-icon-theme
    adwaita-icon-theme
    gnome-icon-theme
    hicolor-icon-theme
    pantheon.elementary-icon-theme
    tango-icon-theme
    arc-icon-theme
    gtk3
    shared-mime-info
    qalculate-gtk
    kdePackages.gwenview
    mpv
    pavucontrol
    playerctl
    brightnessctl
    pulseaudio
    pamixer
    alsa-utils
    libnotify
    dunst

    # Hyprland
    rofi

    # Fonts
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono

    # Applications
    thunderbird
    firefox
    librewolf
    telegram-desktop
    youtube-music
    blender
    godot
    kitty
    ghostty
    waybar
    kdePackages.dolphin
    wofi
    wine
  ];
}
