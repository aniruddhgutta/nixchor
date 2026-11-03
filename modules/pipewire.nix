{
  config,
  modules,
  community,
  lib,
  pkgs,
  ...
}:

let
  pw = config.programs.pipewire;
in
{
  imports = [
    ./dinit.nix

    # finix modules
    community.pipewire
    modules.rtkit
  ];

  # configure pipewire
  programs.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;

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

    # enable bluetooth enhancements via wireplumber
    wireplumber.extraConfig.bluetoothEnhancements = {
      "wireplumber.settings" = {
        "bluetooth.autoswitch-to-headset-profile" = false;
      };
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];
      };
    };
  };

  # pipewire uses rtkit to aquire realtime priority
  services.rtkit.enable = true;

  # start pipewire as a user service (when dinit is enabled)
  dinit.user.services = lib.mkIf config.dinit.enable {
    pipewire = {
      type = "process";
      command = "${pw.package}/bin/pipewire";
    };
    wireplumber = {
      type = "process";
      command = "${pw.wireplumber.package}/bin/wireplumber";
      depends-on = [ "pipewire" ];
    };
    pipewire-pulse = {
      type = "process";
      command = "${pw.package}/bin/pipewire-pulse";
      depends-on = [ "pipewire" ];
    };
  };
}
