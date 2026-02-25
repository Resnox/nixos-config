{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.application.jetbrains = {
    enable = lib.mkEnableOption "Enable Jetbrains IDE";

    ide = lib.mkOption {
      type = with lib.types; listOf package;
      default = [];
    };
  };

  config = lib.mkIf config.application.jetbrains.enable {
    home.packages = config.application.jetbrains.ide;
  };
}