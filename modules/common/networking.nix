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
        General = {
          # use iwd's built in dhcp client (if dhcpcd is disabled)
          EnableNetworkConfiguration = !config.dhcpcd.enable;

          # randomise mac-id
          AddressRandomization = "network";
          AddressRandomizationRange = "full";
        };

        # use openresolv (default is resolved)
        Network.NameResolvingService = "resolvconf";
      };
    };

    # campus wifi sucks
    enableIPv6 = false;

    # allow tailnet peers to reach any port on this machine
    firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
  };

  # configure bluetooth
  hardware.bluetooth = {
    enable = lib.mkDefault false;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };

  # configure tailscale
  services.tailscale = {
    enable = lib.mkDefault false;
    openFirewall = true;
    authKeyFile = "/etc/tailscale-key";
    extraUpFlags = [ "--ssh" ];
    extraDaemonFlags = [ "--no-logs-no-support" ];
  };

  # configure cloudflare warp
  services.cloudflare-warp = {
    enable = lib.mkDefault false;
    package = pkgs.cloudflare-warp.override { headless = true; };
  };
}
