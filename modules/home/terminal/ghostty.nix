{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.terminal.ghostty = {
    enable = lib.mkEnableOption "Enable Ghostty";
  };

  config = lib.mkIf config.terminal.ghostty.enable {
    programs = {
      ghostty = {
        enable = true;

        package = inputs.ghostty.packages.${pkgs.system}.ghostty;
      
        settings = {
          font-family = "JetBrains Mono";
          font-size = 12;

          shell-integration = lib.mkIf config.terminal.zsh.enable "zsh";

          theme = lib.mkIf config.desktop.noctalia.enable "noctalia";
        };
      };
    };
  };
}