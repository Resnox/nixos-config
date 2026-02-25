{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.application.onlyoffice = {
    enable = lib.mkEnableOption "Enable onlyoffice";
  };

  config = lib.mkIf config.application.onlyoffice.enable {
    programs = {
      onlyoffice = {
        enable = true;
      };
    };
  };
}