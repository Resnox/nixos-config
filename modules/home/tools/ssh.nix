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

        # Utilise les valeurs explicites plutôt que les anciens
        # paramètres par défaut de Home Manager.
        enableDefaultConfig = false;

        settings = {
          "*" = {
            AddKeysToAgent = "yes";
            IdentityFile = "~/.ssh/id_ed25519";

            # Désactivé par défaut pour éviter d'exposer
            # l'agent aux machines distantes.
            ForwardAgent = false;

            # Paramètres explicites et prévisibles.
            Compression = false;
            ServerAliveInterval = 0;
            ServerAliveCountMax = 3;
            HashKnownHosts = false;
            UserKnownHostsFile = "~/.ssh/known_hosts";
            ControlMaster = "no";
            ControlPath = "~/.ssh/master-%r@%n:%p";
            ControlPersist = "no";
          };
        };

        extraConfig = ''
          # Enable auto-discovery
          CanonicalDomains monit.addr.spacefoot.net
          CanonicalizeHostname yes

          # Update certificate if connecting to a Spacefoot host
          Match host *.monit.addr.spacefoot.net exec ~/.ssh/fetch-cert.sh
          Match !host 10.10.10.10 host 10.10.*.* exec ~/.ssh/fetch-cert.sh
        '';
      };
    };
  };
}