{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.tools.ansible = {
    enable = lib.mkEnableOption "Enable ansible";
  };

  config = lib.mkIf config.tools.ansible.enable {
    home.packages = with pkgs; [
      ansible
    ];
  };
}