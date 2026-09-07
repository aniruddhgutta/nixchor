{ inputs, ...}:

{
  home-manager.users.vye = { ... }:
  {
    home.stateVersion = "26.05";
    imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

    # install flatpaks
    services.flatpak = {
      enable = true;
      uninstallUnmanaged = true;
      update.onActivation = true;
      packages = [
        "com.github.tchx84.Flatseal"
        "io.github.nozwock.Packet"
        "com.discordapp.Discord"
        "sh.cider.Cider"
        "com.spotify.Client"
        "io.github.alainm23.planify"
        "org.onlyoffice.desktopeditors"
        "md.obsidian.Obsidian"
        "com.usebottles.bottles"
        "org.prismlauncher.PrismLauncher"
        "org.vinegarhq.Sober"
        "sh.ppy.osu"
      ];
    };

  };
}
