{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.terminal.kitty = {
    enable = lib.mkEnableOption "Enable Kitty";
  };

  config = lib.mkIf config.terminal.kitty.enable {
    programs = {
      kitty = {
        enable = true;
        settings = {
          shell = "zsh";
          confirm_os_window_close = 0;
        };
        font = {
          name = "JetBrainsMono Nerd Font";
        };
      };
    };
  };
}