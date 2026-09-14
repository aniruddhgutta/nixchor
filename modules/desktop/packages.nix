{ pkgs, ... }:

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
    quickshell

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
    mpv
    mpd
    mpdris2-rs
    mpdscribble
    rmpc

    # document / image viewers
    zathura
    swayimg

    # creative
    gimp
    blender
    ffmpeg

    # theming
    adwaita-icon-theme
    bibata-cursors
    adw-gtk3

    # misc apps
    unstable.brave-origin
    gnome-calculator
    codeblocks
    senpai
  ];

  # enable flatpak for nix-flaptak
  services.flatpak.enable = true;
}
