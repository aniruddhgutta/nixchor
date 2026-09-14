{ pkgs, ...}:

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
}
