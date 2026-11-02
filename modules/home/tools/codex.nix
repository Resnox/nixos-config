{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.tools.codex = {
    enable = lib.mkEnableOption "Enable codex";
  };

  config = lib.mkIf config.tools.codex.enable {
    home.packages = with pkgs; [
      codex
    ];
  };
}