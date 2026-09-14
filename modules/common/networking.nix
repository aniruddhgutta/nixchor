{ config, lib, pkgs, ... }:

{
  # configure iwd, disable networkmanager and dhcpcd
  networking = {
    networkmanager.enable = false;
    dhcpcd.enable = false;

    useNetworkd = true;
    wireless.iwd = {
      enable = true;
      settings.Settings.AutoConnect = true;
    };

    firewall = {
      enable = true;
      trustedInterfaces = [ config.services.tailscale.interfaceName ];
    };
  };
  services.resolved.enable = true;

  # configure networkd
  systemd.network = {
    wait-online.enable = false;
    networks."25-wlan" = {
      matchConfig.Type = "wlan";
      networkConfig.DHCP = "yes";
    };
  };
  boot.initrd.systemd.network.wait-online.enable = false;

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
    settings = {
    	General = {
    	  Enable = "Source,Sink,Media,Socket";
    		Experimental = true;
    	};
    };
  };
}
