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
        "PATH=/run/wrappers/bin:${config.home.profileDirectory}/bin:/run/current-system/sw/bin"
      ];
    };
    settings = {
      paths = {
        wallpaperDir = "~/Pictures/Wallpapers";
        screenshotDir = "~/Pictures";
        recordDir = "~/Videos";
        mediaGif = "root:/assets/bongocat.gif";
        sessionGif = "root:/assets/kurukuru.gif";
      };
      
      general = {
        apps = {
          terminal = ["kitty"];
          audio = ["pavucontrol"];
          explorer = ["dolphin"];
          browser = ["firefox"];
          editor = ["neovim"];
          calculator = ["qalculate-gtk"];
          playback = ["mpv"];
        };
        idle = {
          lockBeforeSleep = false;
          inhibitWhenAudio = true;
          timeouts = [];
        };
        battery = {
          warnLevels = [
            {
              level = 20;
              title = "Low battery";
              message = "You might want to plug in a charger";
              icon = "battery_android_frame_2";
            }
            {
              level = 10;
              title = "Critical battery level";
              message = "Please plug in a charger now";
              icon = "battery_android_frame_1";
            }
          ];
          criticalLevel = 5;
        };
      };
      
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
        expandThreshold = 20;
        clearThreshold = 0.3;
      };
      
      dashboard = {
        enabled = true;
        showOnHover = false;
        mediaUpdateInterval = 500;
        dragThreshold = 50;
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
        maxWallpapers = 9;
        dragThreshold = 50;
        vimKeybinds = false;
        actionPrefix = ">";
        specialPrefix = "@";
        showOnHover = false;
        useFuzzy = {
          apps = true;
          actions = true;
          schemes = true;
          wallpapers = true;
          variants = true;
        };
        hiddenApps = [];
        actions = [
          {
            name = "Calculator";
            icon = "calculate";
            description = "Do simple math equations (powered by Qalc)";
            command = ["autocomplete" "calc"];
            enabled = true;
            dangerous = false;
          }
          {
            name = "Scheme";
            icon = "palette";
            description = "Change the current colour scheme";
            command = ["autocomplete" "scheme"];
            enabled = true;
            dangerous = false;
          }
          {
            name = "Wallpaper";
            icon = "image";
            description = "Change the current wallpaper";
            command = ["autocomplete" "wallpaper"];
            enabled = true;
            dangerous = false;
          }
          {
            name = "Random";
            icon = "casino";
            description = "Switch to a random wallpaper";
            command = ["caelestia" "wallpaper" "-r"];
            enabled = true;
            dangerous = false;
          }
          {
            name = "Light";
            icon = "light_mode";
            description = "Change the scheme to light mode";
            command = ["setMode" "light"];
            enabled = true;
            dangerous = false;
          }
          {
            name = "Dark";
            icon = "dark_mode";
            description = "Change the scheme to dark mode";
            command = ["setMode" "dark"];
            enabled = true;
            dangerous = false;
          }
        ];
      };
      
      session = {
        enabled = true;
        vimKeybinds = false;
        dragThreshold = 30;
        commands = {
          logout = ["loginctl" "terminate-user" ""];
          shutdown = ["systemctl" "poweroff"];
          hibernate = ["systemctl" "hibernate"];
          reboot = ["systemctl" "reboot"];
        };
      };
      
      sidebar = {
        enabled = true;
        dragThreshold = 80;
      };
      
      lock = {
        recolourLogo = false;
      };
      
      background = {
        enabled = true;
        desktopClock = {
          enabled = false;
        };
        visualiser = {
          enabled = false;
          autoHide = true;
          rounding = 1;
          spacing = 1;
        };
      };
      
      border = {
        rounding = 25;
        thickness = 10;
      };
      
      services = {
        audioIncrement = 0.1;
        defaultPlayer = "Spotify";
        gpuType = "";
        playerAliases = [
          {
            from = "com.github.th_ch.youtube_music";
            to = "YT Music";
          }
        ];
        weatherLocation = "";
        useFahrenheit = false;
        useTwelveHourClock = false;
        smartScheme = true;
        visualiserBars = 45;
      };
      
      appearance = {
        anim = {
          durations = {
            scale = 1;
          };
        };
        font = {
          family = {
            material = "Material Symbols Rounded";
            mono = "CaskaydiaCove NF";
            sans = "Rubik";
          };
          size = {
            scale = 1;
          };
        };
        padding = {
          scale = 1;
        };
        rounding = {
          scale = 1;
        };
        spacing = {
          scale = 1;
        };
        transparency = {
          enabled = false;
          base = 0.85;
          layers = 0.4;
        };
      };
      
      bar = {
        persistent = true;
        showOnHover = true;
        dragThreshold = 20;
        clock = {
          showIcon = true;
        };
        entries = [
          {
            id = "logo";
            enabled = true;
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
          showLockStatus = false;
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
          activeLabel = "󰮯";
          label = "⏺";
          occupiedLabel = "󰮯";
          perMonitorWorkspaces = true;
        };
        tray = {
          background = false;
          compact = false;
          iconSubs = [];
          recolour = false;
        };
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
    mkdir -p /home/temidaradev/Pictures
    mkdir -p /home/temidaradev/Videos
    mkdir -p /home/temidaradev/.config/caelestia
    
    if [ ! -f /home/temidaradev/.face ]; then
      echo "Creating default profile picture..."
      touch /home/temidaradev/.face
    fi
  '';

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
