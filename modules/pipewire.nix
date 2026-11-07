{
  pkgs,
  ...
}:

{
  # configure pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;

    # enable bluetooth enhancements via wireplumber
    wireplumber.extraConfig.bluetoothEnhancements = {
      "wireplumber.settings.bluetooth.autoswitch-to-headset-profile" = false;
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];
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
