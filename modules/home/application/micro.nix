{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.application.micro = {
    enable = lib.mkEnableOption "Enable Micro";
  };

  config = lib.mkIf config.application.micro.enable {
    programs = {
      micro = {
        enable = true;
      };
    };
  };
}