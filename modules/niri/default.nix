{
  config,
  modules,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./packages.nix
    ./xdg.nix
    ../fonts.nix
    ../pipewire.nix
    ../tuigreet.nix

    # TODO: port to finit
    # ./services.nix
  ]
  ++ (with modules; [
    gvfs
    niri
    udisks2
    xwayland-satellite
  ]);
  # note: we exclude
  # - tuigreet since it's imported in tuigreet.nix
  # - elogind since it's imported by default in finix

  # enable niri with xwayland-satellite
  programs = {
    niri.enable = true;
    xwayland-satellite.enable = true;
  };

  # TODO: there must be a better way to do this
  # autolaunch niri if greetd is enabled
  services.greetd.settings.initial_session = lib.mkIf config.programs.tuigreet.enable {
    command = "${pkgs.dbus}/bin/dbus-run-session -- ${lib.getExe config.programs.niri.package} --session";
    user = "vye";
  };

  # enable various services
  services = {
    # TODO: switch to seatd for a lighter stack
    # niri
    elogind.enable = true;
    dbus.enable = true;

    # nautilus
    gvfs.enable = true;
    udisks2.enable = true;
  };
}
