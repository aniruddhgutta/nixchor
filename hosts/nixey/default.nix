{
  config,
  modules,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./intel.nix
    ./packages.nix

    # TODO: port nix-flatpak to finit
    # ./flatpak.nix

    # finix modules
    modules.zzz
  ];

  # enable zzz for suspend/resume
  programs.zzz.enable = true;

  # add windows entry to limine
  programs.limine.extraEntries = lib.mkIf (config.fileSystems ? "/mnt/windows") ''
    /Windows 11
      protocol: efi_boot_entry
      entry: Windows Boot Manager
  '';

  # temporarily disable secureboot for testing
  programs.limine.secureBoot.enable = false;

  # change conservation mode passwordless
  environment.etc."doas.conf".text =
    "permit nopass :wheel cmd tee args /sys/bus/platform/devices/VPC2004:00/conservation_mode\n";
}
