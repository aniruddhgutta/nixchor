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

  # enable cloudflare-warp
  services.cloudflare-warp.enable = true;

  # make tailscale on-demand
  services.tailscale.enable = true;
  systemd.services = {
    tailscaled.wantedBy = lib.mkForce [ ];
    tailscaled-autoconnect.wantedBy = lib.mkForce [ ];
  };

  # add windows entry to limine
  boot.loader.limine.extraEntries = lib.mkIf (config.fileSystems ? "/media/windows") ''
    /Windows 11
      protocol: efi_boot_entry
      entry: Windows Boot Manager
  '';

  # temporarily disable secureboot for testing
  boot.loader.limine.secureBoot.enable = false;
}
