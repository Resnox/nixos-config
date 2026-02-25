{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.application.thunderbird = {
    enable = lib.mkEnableOption "Enable thunderbird";
  };

  config = lib.mkIf config.application.thunderbird.enable {
    programs.thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
      };
    };
  };
}