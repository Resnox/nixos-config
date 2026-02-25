{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.application.discord = {
    enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf config.application.discord.enable {
    programs.discord = {
      enable = true;
      settings = {
        SKIP_HOST_UPDATE = true;
      };
    };
  };
}