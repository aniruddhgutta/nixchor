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
    bash
    ash
    brightnessctl
    chronyd
    fcron
    fwupd
    getty
  ]);

  # set timezone
  time.timeZone = lib.mkDefault "Asia/Kolkata";

  # TODO: switch to lighter stack after testing
  # use gnuslop for coreutils
  programs.coreutils.package = pkgs.coreutils;
  programs.bash.enable = true;

  # set udev-implementation to eudev
  services.udev.enable = true;

  # setup brightnessctl
  programs.brightnessctl.enable = true;
  finit.tasks.backlight = {
    command = "${config.programs.brightnessctl.package}/bin/brightnessctl set 20%";
    remain-after-exit = true;
    log = { };
  };

  # enable timesync with chrony
  services.chrony.enable = true;

  # set cron implementation to fcron
  services.fcron.enable = true;

  # enable finit's getty
  services.getty.enable = true;
}
