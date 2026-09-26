{ pkgs, ... }:

{
  # configure nix
  nix = {
    # swap nix for lix
    package = pkgs.lixPackageSets.stable.lix;

    gc = {
      automatic = true;
      options = "-d";
    };

    settings = {
      # aggressive gc
      min-free = 1 * 1024 * 1024 * 1024;
      max-free = 5 * 1024 * 1024 * 1024;
      keep-outputs = false;
      keep-derivations = false;
      auto-optimise-store = true;

      # enable flakes
      experimental-features = [ "nix-command" "flakes" ];

      # enable cachix
      substituters = [
        "https://nix-community.cachix.org"
        "https://lanzaboote.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk="
      ];
    };

  };

  # allow unfree packages in nixpkgs
  nixpkgs.config.allowUnfree = true;
}
