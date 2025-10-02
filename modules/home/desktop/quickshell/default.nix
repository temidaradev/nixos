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
      
      osd = {
        enabled = true;
        hideDelay = 2000;
        enableBrightness = true;
        enableMicrophone = false;
      };
      
      notifs = {
        expire = true;
        defaultExpireTimeout = 5000;
        actionOnClick = true;
        groupPreviewNum = 3;
      };
      
      dashboard = {
        enabled = true;
        showOnHover = false;
        mediaUpdateInterval = 500;
      };
      
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
      
      launcher = {
        enabled = true;
        enableDangerousActions = true;
        maxShown = 8;
        useFuzzy = {
          apps = true;
          actions = true;
          schemes = true;
          wallpapers = true;
        };
      };
      
      session = {
        enabled = false;
        vimKeybinds = false;
      };

      idleInhibitor = {
        enabled = true;
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

  systemd.user.services.caelestia-idle-inhibitor = {
    Unit = {
      Description = "Enable Caelestia idle inhibitor to prevent auto-lock";
      After = [ "caelestia.service" ];
      Wants = [ "caelestia.service" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 3 && caelestia shell idleInhibitor enable'";
      RemainAfterExit = true;
    };
    Install = {
      WantedBy = [ "hyprland-session.target" ];
    };
  };

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
