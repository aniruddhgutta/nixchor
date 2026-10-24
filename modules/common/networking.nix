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
    enable = lib.mkDefault true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };

  # configure tailscale
  services.tailscale = {
    enable = true;
    # TODO: check if needed
    # openFirewall = true;
    authKeyFile = "/etc/tailscale-key";
    extraUpFlags = [ "--ssh" ];
    extraDaemonFlags = [ "--no-logs-no-support" ];
  };

  # allow tailnet peers to reach any port on this machine
  services.nftables.trustedInterfaces = [ config.services.tailscale.interfaceName ];

  # TODO: port cloudflare-warp
  # enable cloudflare warp
  # services.cloudflare-warp = {
  #   enable = lib.mkDefault true;
  #   package = pkgs.cloudflare-warp.override { headless = true; };
  # };
}
