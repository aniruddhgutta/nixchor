{
  modules,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./kernel.nix
    ./limine.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./tlp.nix
    ./security.nix
    ./users.nix
  ]
  # note: overlays are imported in nix.nix
  ++ (with modules; [
    brightnessctl
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

  # setup brightnessctl
  programs.brightnessctl.enable = true;
  finit.tasks.backlight = {
    command = "${config.programs.brightnessctl.package}/bin/brightnessctl set 20%";
    remain-after-exit = true;
    log = { };
  };

  # set cron implementation to fcron
  services.fcron.enable = true;

  # enable finit's getty
  services.getty.enable = true;
}
