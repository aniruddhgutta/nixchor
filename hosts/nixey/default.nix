{
  config,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./intel.nix
    ./flatpak.nix
    ./packages.nix
  ];

  system.stateVersion = "26.05";

  # make tailscale on-demand
  systemd.services = {
    tailscaled.wantedBy = lib.mkForce [ ];
    tailscaled-autoconnect.wantedBy = lib.mkForce [ ];
  };

  # add windows entry to limine
  boot.loader.limine.extraEntries = lib.mkIf (config.fileSystems ? "/mnt/windows") ''
    /Windows 11
      protocol: efi_boot_entry
      entry: Windows Boot Manager
  '';
}
