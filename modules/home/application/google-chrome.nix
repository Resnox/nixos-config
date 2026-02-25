{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.application.google-chrome = {
    enable = lib.mkEnableOption "Enable google chrome";
  };

  config = lib.mkIf config.application.google-chrome.enable {
    programs.google-chrome = {
      enable = true;
      commandLineArgs = [ "--ozone-platform-hint=auto" ];
    };
  };
}