{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.tools.statix = {
    enable = lib.mkEnableOption "Enable statix";
  };

  config = lib.mkIf config.tools.statix.enable {
    home.packages = with pkgs; [
      statix
    ];
  };
}