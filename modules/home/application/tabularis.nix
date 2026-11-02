{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.application.tabularis = {
    enable = lib.mkEnableOption "Enable tabularis";
  };

  config = lib.mkIf config.application.tabularis.enable {
    home.packages = with pkgs; [ tabularis ];
  };
}