{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.application.penpot = {
    enable = lib.mkEnableOption "Enable penpot";
  };

  config = lib.mkIf config.application.penpot.enable {
    home.packages = with pkgs; [ penpot-desktop ];
  };
}