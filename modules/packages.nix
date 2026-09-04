{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # core / system
    doas-sudo-shim
    sof-firmware
    dash
    greetd
    tuigreet
    sbctl
    git
    git-lfs
    gnupg
    pinentry-curses

    # niri / wayland desktop
    niri
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
    brightnessctl
    playerctl
    nwg-look

    # file management
    nautilus
    udisks
    libheif
    libheif.out
    yazi
    p7zip
    chafa
    poppler
    xdg-utils

    # terminal
    foot
    yash
    fzf
    eza
    android-tools
    aria2
    htop
    btop
    powertop
    jq

    # text editor
    helix
    nixd
    nixfmt
    clang-tools  # clangd, clang-format
    lldb
    rustup  # rustc, cargo, rustfmt
    markdown-oxide
    bash-language-server
    shfmt

    # media playback
    spotify-player
    mpd
    mpdris2-rs
    mpdscribble
    rmpc
    mpv
    mpvScripts.mpris
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly

    # document / image viewers
    zathura
    zathuraPkgs.zathura_pdf_poppler
    imagemagick

    # dev / creative
    blender
    codeblocks
    clang
    ffmpeg

    # theming
    papirus-icon-theme
    papirus-folders
    bibata-cursors
    adw-gtk3

    # tui apps
    wiremix
    impala
    bluetuith

    # misc apps
    brave
    gnome-calculator
    senpai

    # gaming
    gamescope
    gamemode
  ];
}
