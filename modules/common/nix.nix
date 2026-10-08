{
  inputs,
  pkgs,
  ...
}:

{
  nix = {
    # swap nix for lix
    package = pkgs.lixPackageSets.stable.lix;

    settings = {
      # try freeing space upto 5gb when only 1gb is free
      min-free = 1 * 1024 * 1024 * 1024;
      max-free = 5 * 1024 * 1024 * 1024;

      # aggressive gc
      keep-outputs = false;
      keep-derivations = false;
      auto-optimise-store = true;

      # enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # enable cachix
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

  };

  # enable nh and nh-clean
  programs.nh.clean = {
    enable = true;
    extraArgs = "--keep 7 --keep-since 3d";
  };

  # allow unfree packages, import overlays
  nixpkgs = {
    config.allowUnfree = true;
    overlays = import ../../overlays inputs;
  };
}
