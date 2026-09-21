{ inputs, ... }:

{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;

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

    overrides = {
      # fix un-themed cursor in some Wayland apps
      global.Environment.XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

      # allow sober to interact with discord rpc
      "org.vinegarhq.Sober".Context.filesystems = [
        "xdg-run/app/com.discordapp.Discord:create"
        "xdg-run/discord-ipc-0"
      ];

      # allow bottles to make desktop entries
      "com.usebottles.bottles".Context.filesystems = [
        "xdg-data/applications:create"
        "xdg-desktop:create"
      ];
    };
  };

}
