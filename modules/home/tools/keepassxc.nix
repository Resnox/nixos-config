{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.tools.keepassxc = {
    enable = lib.mkEnableOption "Enable keepassxc";
  };

  config = lib.mkIf config.tools.keepassxc.enable {
    home.packages = with pkgs; [
      keepassxc
    ];
  };
}