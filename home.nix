{ config, inputs, pkgs, ...}:

{
  home = {
    username = "resnox";
    homeDirectory = "/home/resnox";

    stateVersion = "25.05";

    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      OZONE_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland";

      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_DESKTOP = "niri";
      NIXOS_OZONE_WL = "1";
    };

  };
  
  imports = [
    ./modules/home
  ];

  application = {
    bruno.enable = true;
    discord.enable = true;
    firefox.enable = true;
    google-chrome.enable = true;
    onlyoffice.enable = true;
    penpot.enable = true;
    tabularis.enable = true;
    teams.enable = true;
    thunderbird.enable = true;
    vscode.enable = true;
  };

  compositor.niri ={
    enable = true;
    terminal = "ghostty";
  };

  desktop.noctalia.enable = true;

  file-manager.yazi = {
    enable = true;
    as-default = true;
  };

  terminal = {
    ghostty.enable = true;
    starship.enable = true;
    zsh.enable = true;
  };

  tools = {
    ansible.enable = true;
    bitwarden.enable = true;
    btop.enable = true;
    codex.enable = true;
    fastfetch.enable = true;
    git.enable = true;
    keepassxc.enable = true;
    peazip.enable = true;
    ssh.enable = true;
    statix.enable = true;
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };

  services.lxqt-policykit-agent.enable = true;
}
