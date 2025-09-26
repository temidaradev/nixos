{ config, pkgs, caelestia-shell, ... }:

{
  imports = [
    caelestia-shell.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
      environment = [
        "QT_QPA_PLATFORM=wayland"
        "QT_QPA_PLATFORMTHEME=gtk3"
      ];
    };
    settings = {
      paths.wallpaperDir = "~/Pictures/Wallpapers";
      
      osLogo = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      
      # Enable OSD (On-Screen Display) for volume/brightness
      osd = {
        enabled = true;
        hideDelay = 2000;
        enableBrightness = true;
        enableMicrophone = false;
      };
      
      # Enable notifications
      notifs = {
        expire = true;
        defaultExpireTimeout = 5000;
        actionOnClick = true;
        groupPreviewNum = 3;
      };
      
      # Enable dashboard with system info
      dashboard = {
        enabled = true;
        showOnHover = false;
        mediaUpdateInterval = 500;
      };
      
      # Enable utilities and toasts
      utilities = {
        enabled = true;
        maxToasts = 6;
        toasts = {
          configLoaded = true;
          chargingChanged = true;
          gameModeChanged = true;
          dndChanged = true;
          audioOutputChanged = true;
          audioInputChanged = true;
          capsLockChanged = false;
          numLockChanged = false;
        };
      };
      
      # Enhanced launcher with more features
      launcher = {
        enabled = true;
        enableDangerousActions = true;  # Allow shutdown/reboot/logout
        maxShown = 8;
        useFuzzy = {
          apps = true;
          actions = true;
          schemes = true;
          wallpapers = true;
        };
      };
      
      # Session menu configuration
      session = {
        enabled = true;
        vimKeybinds = false;
      };
      
      bar = {
        entries = [
          {
            id = "logo";
            enabled = true;
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          }
          {
            id = "workspaces";
            enabled = true;
          }
          {
            id = "spacer";
            enabled = true;
          }
          {
            id = "activeWindow";
            enabled = true;
          }
          {
            id = "spacer";
            enabled = true;
          }
          {
            id = "tray";
            enabled = true;
          }
          {
            id = "clock";
            enabled = true;
          }
          {
            id = "statusIcons";
            enabled = true;
          }
          {
            id = "power";
            enabled = true;
          }
        ];
        status = {
          showBattery = true;
          showNetwork = true;
          showBluetooth = true;
          showAudio = true;
          showMicrophone = true;
          showKbLayout = false;
          showLockStatus = true;
        };

        scrollActions = {
          workspaces = true;
          volume = true;
          brightness = true;
        };

        workspaces = {
          shown = 5;
          activeIndicator = true;
          occupiedBg = true;
          showWindows = true;
          activeTrail = true;
        };
      };
      general.apps = {
        terminal = ["kitty"];
        audio = ["pavucontrol"];
        explorer = ["dolphin"];
        browser = ["firefox"];
        editor = ["neovim"];
        calculator = ["qalculate-gtk"];
        imageViewer = ["gwenview"];
        videoPlayer = ["mpv"];
        musicPlayer = ["spotify"];
      };
    };
    cli = {
      enable = true;
      settings = {
        theme.enableGtk = false;
      };
    };
  };

  home.activation.createCaelestiaDirectories = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p /home/temidaradev/Pictures/Wallpapers
    mkdir -p /home/temidaradev/.config/caelestia
    mkdir -p /home/temidaradev/.local/share/icons/hicolor/scalable/apps
    
    ln -sf ${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg \
           /home/temidaradev/.local/share/icons/hicolor/scalable/apps/nix-snowflake.svg
    
    if [ ! -f /home/temidaradev/.face ]; then
      echo "Creating default profile picture..."
      touch /home/temidaradev/.face
    fi
  '';

  home.packages = with pkgs; [
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
    bibata-cursors
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
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
    GTK_ICON_THEME = "Papirus";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };
}
