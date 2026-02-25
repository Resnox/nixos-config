{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.tools.bitwarden = {
    enable = lib.mkEnableOption "Enable bitwarden";
  };

  config = lib.mkIf config.tools.bitwarden.enable {
    home.packages = with pkgs; [
      bitwarden-desktop
    ];
  };
}