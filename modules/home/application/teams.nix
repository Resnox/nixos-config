{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.application.teams = {
    enable = lib.mkEnableOption "Enable teams";
  };

  config = lib.mkIf config.application.teams.enable {
    home.packages = with pkgs; [ teams-for-linux ];
  };
}