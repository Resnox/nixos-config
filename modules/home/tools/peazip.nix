{ pkgs, lib, config, inputs, nixosConfig, ... }:

{
  options.tools.peazip = {
    enable = lib.mkEnableOption "Enable peazip";
  };

  config = lib.mkIf config.tools.peazip.enable {
    home.packages = with pkgs; [
      peazip
    ];
  };
}