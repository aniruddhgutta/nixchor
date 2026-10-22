final: prev: {
  nautilus = prev.nautilus.overrideAttrs (old: {
    buildInputs = old.buildInputs ++ (with final.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
    ]);
  });
}
