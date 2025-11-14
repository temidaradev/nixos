{ config, pkgs, ... }:

{
  # Plasma-specific home-manager configuration
  # Performance optimizations for KDE Plasma
  
  home.sessionVariables = {
    # Force Wayland backend for Qt applications
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_FORCE_DPI = "physical";
    # Enable GPU acceleration
    QT_XCB_GL_INTEGRATION = "xcb_egl";
    # Reduce memory usage
    QT_QUICK_CONTROLS_STYLE = "org.kde.desktop";
    # Better scaling
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
  };
  
  # KDE configuration files for performance
  home.file.".config/kwinrc".text = ''
    [Compositing]
    Backend=OpenGL
    GLCore=true
    GLPlatformInterface=egl
    GLPreferBufferSwap=a
    GLTextureFilter=2
    HiddenPreviews=5
    OpenGLIsUnsafe=false
    WindowsBlockCompositing=true
    
    [Effect-Blur]
    BlurStrength=5
    
    [Plugins]
    blurEnabled=true
    contrastEnabled=false
    desktopchangeosdEnabled=false
    highlightwindowEnabled=true
    kwin4_effect_dimscreenEnabled=true
    slideEnabled=false
    
    [Windows]
    RollOverDesktops=true
    SeparateScreenFocus=false
    
    [org.kde.kdecoration2]
    BorderSize=Normal
    BorderSizeAuto=false
  '';
  
  home.file.".config/plasmarc".text = ''
    [Theme]
    name=breeze-dark
    
    [Wallpapers]
    usersWallpapers=
  '';
  
  home.file.".config/kdeglobals".text = ''
    [KDE]
    AnimationDurationFactor=0.5
    
    [General]
    BrowserApplication=firefox.desktop
    
    [PreviewSettings]
    MaximumRemoteSize=0
  '';
  
  # Disable unnecessary startup services
  home.file.".config/autostart/org.kde.discover.notifier.desktop".text = ''
    [Desktop Entry]
    Hidden=true
  '';
  
  # Install useful Plasma tools
  home.packages = with pkgs; [
    kdePackages.kate
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.spectacle
    kdePackages.kio
    kdePackages.kio-extras
  ];
}
