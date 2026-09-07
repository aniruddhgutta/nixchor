{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.affinity-nix.overlays.default ];
  environment.systemPackages = with pkgs; [
    # niri / wayland desktop
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
    libheif
    xdg-utils

    # coding / lsps
    clang-tools  # clangd, clang-format
    rustup       # rustc, cargo, rustfmt
    lldb
    markdown-oxide

    # media
    mpv
    mpd
    mpdris2-rs
    mpdscribble
    rmpc
    spotify-player

    # document / image viewers
    zathura
    swayimg

    # dev / creative
    affinity-v3
    blender
    codeblocks
    clang
    ffmpeg

    # theming
    adwaita-icon-theme
    bibata-cursors
    adw-gtk3

    # misc apps
    brave
    gnome-calculator
    senpai

    # gaming
    gamescope
    gamemode
  ];

  # enable flatpak for nix-flaptak
  services.flatpak.enable = true;
}
