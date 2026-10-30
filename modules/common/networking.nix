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
    ++ (with community; [ tailscale ]);

  # enable iwd
  services.iwd.enable = true;
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
    # TODO: check if needed
    # openFirewall = true;
    authKeyFile = "/etc/tailscale-key";
    extraUpFlags = [ "--ssh" ];
    extraDaemonFlags = [ "--no-logs-no-support" ];
  };

  # allow tailnet peers to reach any port on this machine
  providers.firewall.backend = "nftables";
  services.nftables.trustedInterfaces = [ config.services.tailscale.interfaceName ];

  # TODO: port cloudflare-warp
  # enable cloudflare warp
  # services.cloudflare-warp = {
  #   enable = lib.mkDefault false;
  #   package = pkgs.cloudflare-warp.override { headless = true; };
  # };
}
