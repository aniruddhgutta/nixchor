{ config, lib, pkgs, ... }:

{
  # configure nix
  nix = {
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d --delete-generations 5";
    };

    settings = {
      min-free = 1 * 1024 * 1024 * 1024;
      max-free = 5 * 1024 * 1024 * 1024;
      keep-outputs = false;
      keep-derivations = false;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # sync nix-optimise with nix-gc
  systemd.services.nix-optimise.after = [ "nix-gc.service" ];

  # allow unfree packages in nixpkgs
  nixpkgs.config.allowUnfree = true;

  # disable nixos-help's html manual
  documentation.doc.enable = false;
}
