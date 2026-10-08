{
  lib,
  pkgs,
  ...
}:

{
  # disable defaults
  environment.defaultPackages = lib.mkForce [ ];
  programs.nano.enable = false;

  environment.systemPackages = with pkgs; [
    # core
    doas-sudo-shim
    dash
    sbctl
    git
    git-lfs
    killall

    # shell
    yash
    eza
    fzf
    jq

    # yazi
    yazi
    p7zip
    chafa
    poppler

    # cli
    rsync
    brightnessctl
    aria2
    nix-tree

    # tui
    htop
    btop
    powertop
    impala

    # text editor
    helix
    nixd
    nixfmt
    shfmt
  ];
}
