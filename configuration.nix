{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/nix.nix
    ./modules/boot.nix
    ./modules/security.nix
    ./modules/users.nix
    ./modules/graphics.nix
    ./modules/networking.nix
    ./modules/power.nix
    ./modules/audio.nix
    ./modules/fonts.nix
    ./modules/desktop.nix
    ./modules/packages.nix
  ];

  time.timeZone = "Asia/Kolkata";
  networking.hostName = "nixey";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.copySystemConfiguration = true;
  system.stateVersion = "26.05";
}
