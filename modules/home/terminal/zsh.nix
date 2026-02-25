{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.terminal.zsh = {
    enable = lib.mkEnableOption "Enable zsh";
  };

  config = lib.mkIf config.terminal.zsh.enable {
    programs = {
      zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
      };
    };
  };
}