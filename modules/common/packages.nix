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
    sbctl
    gnupg
    pinentry-curses
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

    # TODO: remove after testing
    # nixos defaults
    gnused
    gnutar
    gzip
    bzip2
    xz
    zstd
    diffutils
    patch
    iproute2
    iputils
    curl
    openssh
  ];
}
