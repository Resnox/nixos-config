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
        forwardAgent = true;

       extraConfig = ''
          # Enable auto-discovery
          CanonicalDomains monit.addr.spacefoot.net
          CanonicalizeHostname yes

          # Update certificate if connecting to a Spacefoot host
          Match host *.monit.addr.spacefoot.net exec ~/.ssh/fetch-cert.sh
          Match !host 10.10.10.10 host 10.10.*.* exec ~/.ssh/fetch-cert.sh
        '';

        matchBlocks = {
          "*" = {
            identityFile = "~/.ssh/id_ed25519";
          };
        };
      };
    };
  };
}