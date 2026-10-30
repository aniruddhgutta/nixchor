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
    ./services.nix
    ./xdg.nix

    ../fonts.nix
    ../pipewire.nix
    ../tuigreet.nix
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

  # fix udisks2.conf not existing
  services.udisks2.settings.udisks2.modules = lib.mkForce "*";
  environment.etc."udisks2/udisks2.conf".source =
    (pkgs.formats.ini { }).generate "udisks2.conf"
      config.services.udisks2.settings;

  # fix swaylock authentication
  security.pam.services.swaylock.text = config.security.pam.services.login.text;
}
