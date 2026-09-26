{ pkgs, ... }:

{
  # enable steam with proton-ge
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # enable gamemode
  programs.gamemode.enable = true;

  # enable gamescope
  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };

  # increase ulimit (fixes bottles' issues)
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
  ];
}
