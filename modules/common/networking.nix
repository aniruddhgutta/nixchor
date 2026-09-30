{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking = {
    # let iwd manage dhcp
    dhcpcd.enable = false;

    # configure iwd
    wireless.iwd = {
      enable = true;
      settings = {
        General.EnableNetworkConfiguration = true;    # use iwd's built in dhcp client
        Network.NameResolvingService = "resolvconf";  # use openresolv (default is resolved)
      };
    };

    # allow tailnet peers to reach any port on this machine
    firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
  };

  # configure tailscale
  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = "/run/secrets/tailscale_key";
    extraUpFlags = [ "--ssh" ];
  };

  # make tailscale on-demand
  systemd.services = {
    tailscaled.wantedBy = lib.mkForce [ ];
    tailscaled-autoconnect.wantedBy = lib.mkForce [ ];
  };

  # configure cloudflare warp
  services.cloudflare-warp = {
    enable = true;
    package = pkgs.cloudflare-warp.override { headless = true; };
  };

  # configure bluetooth
  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };
}
