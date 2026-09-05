{ pkgs, ... }:

{
  # configure pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;

    # enable bluetooth enhancements via wireplumber
    wireplumber.extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
      };
    };

    # allow pipewire to use lsp-plugins for para-eqs
    extraLv2Packages = [
      (pkgs.lsp-plugins.override {
        buildVST3 = false;
        buildVST2 = false;
        buildCLAP = false;
        buildLADSPA = false;
        buildJACK = false;
        buildGStreamer = false;
      })
    ];
  };

  # pipewire uses rtkit to aquire realtime priority
  security.rtkit.enable = true;
}
