{
  inputs,
  ...
}:

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
      "com.collaboraoffice.Office"
      "md.obsidian.Obsidian"
      "com.usebottles.bottles"
    ];

    overrides = {
      # fix un-themed cursor in some Wayland apps
      global.Environment.XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

      # allow bottles to make desktop entries
      "com.usebottles.bottles".Context.filesystems = [
        "xdg-data/applications:create"
        "xdg-desktop:create"
      ];
    };
  };

}
