{
  pkgs,
  ...
}:

{
  # TODO: trim down after testing
  xdg = {
    autostart.enable = true;
    icons.enable = true;
    mime.enable = true;

    # install required xdg-portals
    portal = {
      enable = true;
      portals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };

  };
}
