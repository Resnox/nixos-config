{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.terminal.starship = {
    enable = lib.mkEnableOption "Enable Starship";
  };

  config = lib.mkIf config.terminal.starship.enable {
    programs = {
      starship = {
        enable = true;
        settings = {
          add_newline = true;
          sudo.disabled = false;
        };
      };
    };
  };
}