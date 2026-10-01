{
  imports = [
    ./boot.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./power.nix
    ./security.nix
    ./users.nix
  ];
  # note: overlays are imported in nix.nix

  # set timezone
  time.timeZone = "Asia/Kolkata";

  # disable html and info documentation
  documentation = {
    doc.enable = false;
    info.enable = false;
  };
}
