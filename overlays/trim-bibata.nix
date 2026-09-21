final: prev: {
  bibata-cursors = prev.bibata-cursors.overrideAttrs {
    buildPhase = ''
      ctgen configs/normal/x.build.toml -p x11 -d $bitmaps/Bibata-Modern-Ice -n Bibata-Modern-Ice -c 'White and rounded edge Bibata XCursors'
    '';
  };
}
