{
  imports = [
    ./packages.nix
    ./services.nix
    ../fonts.nix
    ../greetd.nix
    ../pipewire.nix
  ];
  
  # enable niri, configure xdg-portals
  programs.niri.enable = true;
  xdg.portal.config.common.default = [ "gtk" ];

  # configure tuigreet
  services.greetd.settings.initial_session = {
    command = "niri-session";
    user = "vye";
  };

  # disable useless services, enable nautilus-related services
  services = {
    gnome.gnome-keyring.enable = false;
    speechd.enable = false;
    gnome.sushi.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };
}
