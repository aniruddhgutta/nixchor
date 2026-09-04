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

    nftables.enable = true;
  };
  services.resolved.enable = true;

  # configure networkd
  systemd.network = {
    wait-online.anyInterface = true;
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
