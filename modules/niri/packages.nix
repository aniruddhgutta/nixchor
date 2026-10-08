{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # niri
    xwayland-satellite
    awww
    waybar
    fuzzel
    mako
    swayidle
    swaylock

    # clipboard
    cliphist
    wl-clipboard

    # terminal
    foot
    wiremix
    bluetuith

    # script deps
    libnotify
    imagemagick
    playerctl
    wl-screenrec
    slurp

    # nautilus
    nautilus
    ffmpegthumbnailer
    libheif.out
    xdg-utils

    # theming
    adwaita-icon-theme
    bibata-cursors
    adw-gtk3

    # media
    mpv-unwrapped
    mpd
    mpdris2-rs
    mpdscribble
    rmpc

    # default apps
    nwg-look
    swayimg
    (pkgs.zathura.override {
      plugins = [ pkgs.zathuraPkgs.zathura_pdf_poppler ];
    })

  ];
}
