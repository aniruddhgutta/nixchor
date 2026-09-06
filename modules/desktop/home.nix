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
        "com.discordapp.Discord"
        "com.github.tchx84.Flatseal"
        "sh.cider.Cider"
        "com.spotify.Client"
        "com.usebottles.bottles"
        "io.github.alainm23.planify"
        "io.github.nozwock.Packet"
        "md.obsidian.Obsidian"
        "org.prismlauncher.PrismLauncher"
        "org.vinegarhq.Sober"
        "sh.ppy.osu"
      ];
    };

  };
}
