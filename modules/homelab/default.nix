{
  modules,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./containers.nix
    ./openssh.nix

    # TODO: port to finit
    # ./services.nix

    # finix modules
    modules.autologin
  ];

  # TODO: check if needed
  # disable sleep when closed
  # services.logind.settings.Login.HandleLidSwitch = "ignore";

  # enable tailscale
  services.tailscale.enable = true;

  # enable autologin
  services.autologin = {
    enable = true;
    user = "vye";
    command = pkgs.writeShellScript "autologin.sh" ''
      exec ${lib.getExe pkgs.yash} -l
    '';
  };
}
