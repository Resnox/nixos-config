{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.application.vscode = {
    enable = lib.mkEnableOption "Enable VSCode";
  };

  config = lib.mkIf config.application.vscode.enable {
    programs = {
      vscode = {
        enable = true;
      };
    };
  };
}