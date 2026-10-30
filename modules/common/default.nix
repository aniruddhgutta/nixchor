{
  modules,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./backlight.nix
    ./kernel.nix
    ./limine.nix
    ./man.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./tlp.nix
    ./security.nix
    ./users.nix
  ]
  # note: overlays are imported in nix.nix
  ++ (with modules; [
    fcron
    fwupd
    getty
  ]);

  # set timezone
  time.timeZone = lib.mkDefault "Asia/Kolkata";

  # use busybox for coreutils
  programs.coreutils.package = pkgs.busybox;

  # set udev-implementation to eudev
  services.udev.enable = true;

  # set cron implementation to fcron
  services.fcron.enable = true;

  # enable finit's getty
  services.getty.enable = true;
}
