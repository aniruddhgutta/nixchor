{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

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

  # install prismlauncher, sober and osu (if flatpak is enabled)
  services.flatpak = lib.mkIf config.services.flatpak.enable {
    packages = [
      "org.prismlauncher.PrismLauncher"
      "org.vinegarhq.Sober"
      "sh.ppy.osu"
    ];

    overrides = {
      # allow sober to interact with discord rpc
      "org.vinegarhq.Sober".Context.filesystems = [
        "xdg-run/app/com.discordapp.Discord:create"
        "xdg-run/discord-ipc-0"
      ];
    };
  };
}
