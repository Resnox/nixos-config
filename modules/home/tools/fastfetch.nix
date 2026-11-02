{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.tools.fastfetch = {
    enable = lib.mkEnableOption "Enable fastfetch";
  };

  config = lib.mkIf config.tools.fastfetch.enable {
    programs.fastfetch.enable = true;
  };
}