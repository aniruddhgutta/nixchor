{
  pkgs,
  ...
}:

{
  # enable manpages
  environment = {
    systemPackages = with pkgs; [
      man-db
      man-pages
      man-pages-posix
    ];
    pathsToLink = [ "/share/man" ];

    # mandb/apropos only index paths listed here
    etc."man_db.conf".text = ''
      MANDB_MAP /run/current-system/sw/share/man /var/cache/man
      MANPATH_MAP /run/current-system/sw/bin /run/current-system/sw/share/man
    '';
  };
}
