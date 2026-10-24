{
  modules,
  pkgs,
  ...
}:

{
  imports = with modules;[
    pipewire
    rtkit
    wireplumber
  ];

  # configure pipewire
  programs.pipewire = {
    enable = true;

    # TODO: figure out wtf to do here
    # PLAN: we can use community-modules' pipewire, and define out own service
    # allow pipewire to use lsp-plugins for para-eqs
    # extraLv2Packages = [
    #   (pkgs.lsp-plugins.override {
    #     buildVST3 = false;
    #     buildVST2 = false;
    #     buildCLAP = false;
    #     buildLADSPA = false;
    #     buildJACK = false;
    #     buildGStreamer = false;
    #   })
    # ];
  };

  # enable bluetooth enhancements via wireplumber
  programs.wireplumber.settings = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [
        "hsp_hs"
        "hsp_ag"
        "hfp_hf"
        "hfp_ag"
      ];
    };
  };

  # pipewire uses rtkit to aquire realtime priority
  services.rtkit.enable = true;
}
