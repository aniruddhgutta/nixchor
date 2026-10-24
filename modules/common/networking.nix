{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking = {
    # let iwd manage dhcp
    dhcpcd.enable = lib.mkDefault false;

    # configure iwd
    wireless.iwd = {
      enable = true;
      settings = {
        General.EnableNetworkConfiguration = true;    # use iwd's built in dhcp client
        Network.NameResolvingService = "resolvconf";  # use openresolv (default is resolved)
      };
    };

    # campus wifi sucks
    enableIPv6 = false;

    # allow tailnet peers to reach any port on this machine
    firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
  };

  # configure bluetooth
  hardware.bluetooth = {
    enable = lib.mkDefault true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };

  # configure tailscale
  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = "/etc/tailscale-key";
    extraUpFlags = [ "--ssh" ];
    extraDaemonFlags = [ "--no-logs-no-support" ];
  };

  # configure cloudflare warp
  services.cloudflare-warp = {
    enable = lib.mkDefault true;
    package = pkgs.cloudflare-warp.override { headless = true; };
  };
}
