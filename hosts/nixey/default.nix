{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "nixey";
  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "26.05";
}
