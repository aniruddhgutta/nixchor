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

  # hostname
  networking.hostName = "nixey";
  system.stateVersion = "26.05";

  # add windows entry to limine
  boot.loader.limine.extraEntries = lib.mkIf (config.fileSystems ? "/mnt/windows") ''
    /Windows 11
      protocol: efi_boot_entry
      entry: Windows Boot Manager
  '';
}
