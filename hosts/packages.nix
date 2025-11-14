{ pkgs }:

with pkgs; {
  system = [
    # Gaming
    lunar-client
    osu-lazer

    # Networking
    cloudflare-warp
    protonvpn-gui
    nicotine-plus

    # Hardware
    kdePackages.qtmultimedia
    qt6Packages.qtbase
    qt6Packages.qttools
    qt6Packages.qtsvg
    qt6Packages.qtdeclarative
    qt6Packages.qtwayland
    qt6Packages.qtwebsockets
    mesa
    cava

    # MTP support for Android devices
    libmtp
    mtpfs
    jmtpfs
    doublecmd
    rar

    # Virtualization
    vmware-workstation
    docker

    # Desktop
    bibata-cursors
    flatpak
    xdg-desktop-portal
    kdePackages.xdg-desktop-portal-kde
    fwupd
    whatsapp-electron

    # Development tools
    git
    alsa-lib
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
    openssl
    android-studio
    aubio
    docker-compose
    pipewire
    postgresql
    swappy
    cargo-tauri
    trunk
    libqalculate
    material-symbols
    nerd-fonts.caskaydia-cove
    kitty
    discord
    slack
    dioxus-cli

    # Editors
    vim
    neovim
    helix
    vscode
    zed-editor
    code-cursor
    jetbrains.rust-rover
    jetbrains.goland
    jetbrains.clion

    # Languages
    (python312.withPackages (ps: with ps; [ websockets ]))
    uv
    pkg-config
    openssl.dev
    odin
    ghc
    cabal-install
    go
    cargo
    rustc
    gcc
    libGL
    wget
    glm
    glib
    zlib
    rustup
    zig
    lua
  ];

  home = [
    # Desktop tools
    anime-downloader
    wl-clipboard
    grim
    slurp
    wf-recorder
    imagemagick
    gpu-screen-recorder
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
    kdePackages.dolphin
    wine
  ];
}
