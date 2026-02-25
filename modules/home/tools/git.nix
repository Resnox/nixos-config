{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.tools.git = {
    enable = lib.mkEnableOption "Enable Git/GitHub";
  };

  config = lib.mkIf config.tools.git.enable {

    programs = {
      gh = {
        enable = true;
        gitCredentialHelper = {
          enable = true;
        };
      };

      git = {
        enable = true;
        settings = {
          user = {
            name = "Resnox";
            email = "bastien.rimbert@laposte.net";
          };
        };
      };
    };
  };
}