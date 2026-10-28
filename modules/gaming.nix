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

  # increase ulimit (fixes bottles' issues)
  environment.etc."security/limits.conf".text = lib.mkIf config.services.flatpak.enable (
    lib.mkAfter "@users - memlock unlimited\n"
  );

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
