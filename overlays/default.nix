inputs: [
  (import ./trim-bibata.nix)
  (import ./trim-iosevka.nix)
  (import ./nautilus-gstreamer.nix)
  (import ./sushi-heif.nix)
  (import ./htop-vim.nix)
  (import ./intel-lpmd-arrowlake-h.nix)

  # adds pkgs.helium to systemPackages (from helium-nix)
  inputs.helium.overlays.default

  # adds davinci-resolve to systemPackages (from resolve)
  inputs.davinci.overlays.default

  # adds chimerautils
  inputs.chimerautils.overlays.default
]
