{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.tools.ssh = {
    enable = lib.mkEnableOption "Enable ssh";
  };

  config = lib.mkIf config.tools.ssh.enable {
    services.ssh-agent.enable = true;

    programs = {
      ssh = {
        enable = true;
        addKeysToAgent = "yes";
      };
    };
  };
}