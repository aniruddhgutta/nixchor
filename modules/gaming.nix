{
  modules,
  community,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = with community; [
    steam
    gamescope
  ]
  ++ (with modules; [ gamemode ]);

  programs = {
    # enable steam with proton-ge
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    # enable gamemode
    gamemode.enable = true;

    # enable gamescope
    gamescope = {
      enable = true;
      capSysNice = false;
    };
  };

  # TODO: port loginLimits if needed
  # # increase ulimit (fixes bottles' issues)
  # security.pam.loginLimits = lib.mkIf config.services.flatpak.enable [
  #   {
  #     domain = "@users";
  #     item = "memlock";
  #     type = "-";
  #     value = "unlimited";
  #   }
  # ];

  # TODO: port nix-flatpak
  # # install prismlauncher, sober and osu (if flatpak is enabled)
  # services.flatpak = lib.mkIf config.services.flatpak.enable {
  #   packages = [
  #     "com.vysp3r.ProtonPlus"
  #     "org.prismlauncher.PrismLauncher"
  #     "org.vinegarhq.Sober"
  #     "sh.ppy.osu"
  #   ];

  #   overrides = {
  #     # allow sober to interact with discord rpc
  #     "org.vinegarhq.Sober".Context.filesystems = [
  #       "xdg-run/app/com.discordapp.Discord:create"
  #       "xdg-run/discord-ipc-0"
  #     ];
  #   };
  # };
}
