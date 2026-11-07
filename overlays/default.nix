inputs: [
  (import ./trim-bibata.nix)
  (import ./trim-iosevka.nix)
  (import ./nautilus-gstreamer.nix)
  (import ./sushi-heif.nix)
  (import ./htop-vim.nix)

  # adds pkgs.helium to systemPackages (from helium-nix)
  inputs.helium.overlays.default
]
