{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.application.firefox = {
    enable = lib.mkEnableOption "Enable firefox";
  };

  config = lib.mkIf config.application.firefox.enable {
    home.packages = with pkgs; [ firefox ];
  };
}