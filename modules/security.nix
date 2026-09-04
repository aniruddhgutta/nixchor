{ config, lib, pkgs, ... }:

{
  security = {
    # configure doas
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "vye" ];
          keepEnv = true;
          persist = true;
        }
        {
          # allow passwordless 'tee' for changing conservation mode (lenovo-only)
          groups = [ "wheel" ];
          noPass = true;
          cmd = "tee";
          args = [ "/sys/bus/platform/devices/VPC2004:00/conservation_mode" ];
        }
      ];
    };

    # enable polkit
    polkit.enable = true;

    # increase ulimit for games
    pam.loginLimits = [
      {
        domain = "@users";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
    ];
  };

  # configure gnugpg
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
