{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # core
    mkpasswd
    doas-sudo-shim
    dash
    git
    git-lfs
    killall
    ps_mem
    curl
    openssh

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
