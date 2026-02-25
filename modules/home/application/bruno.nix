{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.application.bruno = {
    enable = lib.mkEnableOption "Enable bruno";
  };

  config = lib.mkIf config.application.bruno.enable {
    home.packages = with pkgs; [ bruno ];
  };
}