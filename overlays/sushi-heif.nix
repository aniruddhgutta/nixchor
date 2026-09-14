final: prev: {
  sushi = prev.sushi.overrideAttrs (old: {
    buildInputs = old.buildInputs ++ [ prev.libheif.lib ];
    postInstall = (old.postInstall or "") + ''
      export GDK_PIXBUF_MODULE_FILE="${prev.gnome._gdkPixbufCacheBuilder_DO_NOT_USE {
        extraLoaders = [ prev.libheif.lib ];
      }}"
    '';
  });
}
