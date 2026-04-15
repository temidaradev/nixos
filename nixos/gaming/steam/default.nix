{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extest.enable = true;
    gamescopeSession.enable = true;
    gamescopeSession.env = {
      STEAM_ALREADY_GAMESCOPED = "1";
      SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
      WINE_MOUSE_WARP_OVERRIDE = "force";
    };
    gamescopeSession.args = [
      "--fullscreen"
      "--force-grab-cursor"
    ];
    protontricks.enable = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  environment.systemPackages = [
    (pkgs.lib.hiPrio (pkgs.writeShellScriptBin "steam" ''
      REAL_STEAM="${config.programs.steam.package}/bin/steam"

      if [ -n "$STEAM_ALREADY_GAMESCOPED" ] || [ -n "$GAMESCOPE_WAYLAND_DISPLAY" ]; then
        exec "$REAL_STEAM" "$@"
      fi

      if [ "$STEAM_USE_GAMESCOPE" = "1" ] && command -v steam-gamescope >/dev/null 2>&1; then
        exec steam-gamescope "$@"
      fi

      exec "$REAL_STEAM" "$@"
    ''))
  ];

  hardware.steam-hardware.enable = true;
}
