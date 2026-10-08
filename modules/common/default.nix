{
  lib,
  ...
}:

{
  imports = [
    ./boot.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./tlp.nix
    ./security.nix
    ./users.nix
  ];
  # note: overlays are imported in nix.nix

  # set timezone
  time.timeZone = lib.mkDefault "Asia/Kolkata";

  # disable html and info documentation
  documentation = {
    doc.enable = false;
    info.enable = false;
  };
}
