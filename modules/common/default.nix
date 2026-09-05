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

  # set timezone
  time.timeZone = "Asia/Kolkata";
}
