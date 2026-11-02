{
  modules,
  community,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports =
    (with modules; [
      iwd
      bluetooth
      nftables
    ])
    ++ (with community; [
      cloudflare-warp
      tailscale
    ]);

  # enable iwd
  services.iwd = {
    enable = true;
    settings.General = {
      # randomise mac-id
      AddressRandomization = "network";
      AddressRandomizationRange = "full";
    };
  };
  programs.resolvconf.enable = true;

  # configure bluetooth
  services.bluetooth = {
    enable = lib.mkDefault false;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };

  # configure tailscale
  services.tailscale = {
    enable = lib.mkDefault false;
    authKeyFile = "/etc/tailscale-key";
    extraUpFlags = [ "--ssh" ];
    extraDaemonFlags = [ "--no-logs-no-support" ];
  };

  # allow tailnet peers to reach any port on this machine
  providers.firewall.backend = "nftables";
  services.nftables.trustedInterfaces = [ config.services.tailscale.interfaceName ];

  # enable cloudflare warp
  services.cloudflare-warp = {
    enable = lib.mkDefault false;
    package = pkgs.cloudflare-warp.override { headless = true; };
  };
}
