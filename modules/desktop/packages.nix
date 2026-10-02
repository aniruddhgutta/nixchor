{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # niri / wayland desktop
    xwayland-satellite
    awww
    waybar
    fuzzel
    libnotify
    mako
    cliphist
    wl-clipboard
    wl-screenrec
    swayidle
    swaylock
    slurp
    playerctl
    nwg-look

    # cli / tui
    foot
    wiremix
    bluetuith
    android-tools
    imagemagick

    # file management
    nautilus
    ffmpegthumbnailer
    libheif.out
    xdg-utils

    # dev
    gnumake
    clang
    clang-tools

    # media
    mpv-unwrapped
    mpd
    mpdris2-rs
    mpdscribble
    rmpc

    # document / image viewers
    (pkgs.zathura.override {
      plugins = [ pkgs.zathuraPkgs.zathura_pdf_poppler ];
    })
    swayimg

    # creative
    gimp
    ffmpeg-headless
    obs-studio
    (symlinkJoin {
      name = "blender-oneapi";
      paths = [ blender-oneapi ];
      nativeBuildInputs = [ makeWrapper ];
      postBuild = "wrapProgram $out/bin/blender --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib";
    })

    # theming
    adwaita-icon-theme
    bibata-cursors
    adw-gtk3

    # misc apps
    brave-origin
    gnome-calculator
    senpai
  ];
}
