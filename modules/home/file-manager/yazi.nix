{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.file-manager.yazi = {
    enable = lib.mkEnableOption "Enable Yazi";
    as-default = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.file-manager.yazi.enable {
    programs = {
      yazi = {
        enable = true;
        settings = {
          show_hidden = true;
        };
      };
    };

    xdg.portal = lib.mkIf config.file-manager.yazi.as-default {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-termfilechooser ];
      config.common."org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
    };
  };
}