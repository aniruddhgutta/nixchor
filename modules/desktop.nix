{ config, lib, pkgs, ... }:

{
  # configure greetd with tuigreet
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet -t -r \
            --power-shutdown 'systemctl poweroff' \
            --power-reboot 'systemctl reboot' \
            --theme 'border=magenta;text=cyan;prompt=cyan;time=blue;action=blue;button=yellow;container=black;input=green'
        '';
      };
      initial_session = {
        command = "niri-session";
        user = "vye";
      };
    };
  };

  # enable niri, configure xdg-portals
  programs.niri.enable = true;
  xdg.portal.config.common.default = [ "gtk" ];

  # configuring nautilus
  environment.pathsToLink = [ "share/thumbnailers" ];
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "foot";
  };

  # disable useless services, enable nautilus-related services
  services = {
    gnome.gnome-keyring.enable = false;
    gvfs.enable = true;
    udisks2.enable = true;
  };

  # enable flaptak
  services.flatpak.enable = true;
}
