{
  imports = [
    ./containers.nix
    ./openssh.nix
    ./services.nix
  ];

  # disable sleep when closed
  services.logind.settings.Login.HandleLidSwitch = "ignore";

  # disable useless services
  hardware.bluetooth.enable = false;
  services.cloudflare-warp.enable = false;

  # enable autologin
  services.getty.autologinUser = "vye";
}
