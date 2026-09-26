final: prev: {
  iosevka = prev.iosevka.override {
    set = "";
    privateBuildPlan = {
      family = "Iosevka";
      noCvSs = true;
      ligations.inherits = "default-calt";
      weights.regular = {
        shape = 400;
        menu = 400;
        css = 400;
      };
      weights.bold = {
        shape = 700;
        menu = 700;
        css = 700;
      };
      widths.normal = {
        shape = 500;
        menu = 5;
        css = "normal";
      };
      slopes.upright = {
        angle = 0;
        shape = "upright";
        menu = "upright";
        css = "normal";
      };
      slopes.italic = {
        angle = 9.4;
        shape = "italic";
        menu = "italic";
        css = "italic";
      };
    };
  };
}
