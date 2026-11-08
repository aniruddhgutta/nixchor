{
  config,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./intel.nix
    ./packages.nix
  ];

  # enable bluetooth
  services.bluetooth.enable = true;

  # enable cloudflare-warp
  services.cloudflare-warp.enable = true;

  # enable tailscale
  services.tailscale.enable = true;

  # disable zram-swap
  services.zram-swap.enable = false;

  # disable services from starting on boot
  finit = {
    services.tailscaled.manual-start = lib.mkIf config.services.tailscale.enable true;
    services.bluetooth.manual-start = lib.mkIf config.services.bluetooth.enable true;
    tasks.tailscale-up.manual-start = lib.mkIf config.services.tailscale.enable true;
  };

  # change conservation mode passwordless
  environment.etc."doas.conf".text =
    "permit nopass :wheel cmd tee args /sys/bus/platform/devices/VPC2004:00/conservation_mode\n";

  # add windows entry to limine
  programs.limine.extraEntries = lib.mkIf (config.fileSystems ? "/media/windows") ''
    /Windows 11
      protocol: efi_boot_entry
      entry: Windows Boot Manager
  '';
}
