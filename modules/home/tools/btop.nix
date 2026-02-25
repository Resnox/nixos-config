{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.tools.btop = {
    enable = lib.mkEnableOption "Enable btop";
  };

  config = lib.mkIf config.tools.btop.enable {
    home.packages = with pkgs; [
      btop
    ];
  };
}