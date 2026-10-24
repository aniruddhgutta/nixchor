{
  config,
  lib,
  ...
}:

{
  services.flatpak = lib.mkIf config.services.flatpak.enable {
    packages = [
      "net.ankiweb.Anki"
    ];
  };
}
