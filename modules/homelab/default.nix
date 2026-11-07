{
  imports = [
    ./containers.nix
    ./openssh.nix
    ./services.nix
  ];

  # disable sleep when closed
  services.logind.settings.Login.HandleLidSwitch = "ignore";

  # enable tailscale
  services.tailscale.enable = true;

  # enable autologin
  services.getty.autologinUser = "vye";
}
