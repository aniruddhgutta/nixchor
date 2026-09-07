{
  lib,
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
  pkg-config,
  glib,
  libxml2,
  libnl,
  systemd,
  upower,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "intel-lpmd";
  version = "v0.1.0";

  src = fetchFromGitHub {
    owner = "intel";
    repo = "intel-lpmd";
    rev = "40d18a6cc22c37addc3e636bc9c5cf1ab5d5fbda";
    hash = "sha256-gvPO7KqDVQDHC2DRDXJG52IYhHim8vex6Yrbsy3iLBI=";
  };

  patches = [
    # https://github.com/intel/intel-lpmd/pull/121 (Arrow Lake-H (0xC5) platform config)
    ./patches/0001-arrowlake-h-config.patch
  ];

  # temporary, for coredump symbolication — revert once diagnosed
  dontStrip = true;
  env.NIX_CFLAGS_COMPILE = "-g -O0";
  hardeningDisable = [ "fortify" ];

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
    glib
  ];

  buildInputs = [
    glib
    libxml2
    libnl
    systemd
    upower
  ];

  configureFlags = [
    "--with-dbus-sys-dir=${placeholder "out"}/etc/dbus-1/system.d"
    "--with-systemdsystemunitdir=${placeholder "out"}/lib/systemd/system"
    "--sbindir=${placeholder "out"}/bin"
    "--localstatedir=/var"
    "--disable-werror"
  ];

  # install-data-hook runs `mandb`, which doesn't exist and isn't wanted in a nix build
   postPatch = ''
     substituteInPlace Makefile.am --replace-fail 'mandb || true' 'true'
     # GTK_DOC_CHECK is a dead macro call: no doc/Makefile.am, nothing
     # conditions on ENABLE_GTK_DOC. Strip rather than pull in gtk-doc.
     sed -i '/GTK_DOC_CHECK/d' configure.ac
   '';

  meta = {
    description = "Intel Low Power Mode Daemon";
    homepage = "https://github.com/intel/intel-lpmd";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.linux;
    mainProgram = "intel_lpmd";
  };
})
