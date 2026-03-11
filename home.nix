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

  systemd.user.sessionVariables = {
    WAYLAND_DISPLAY = "$WAYLAND_DISPLAY";
    XDG_SESSION_TYPE = "$XDG_SESSION_TYPE";
    XDG_CURRENT_DESKTOP = "$XDG_CURRENT_DESKTOP";
  };

  imports = [
    ./modules/home
  ];

  application = {
    bruno.enable = true;
    discord.enable = true;
    firefox.enable = true;
    google-chrome.enable = true;
    jetbrains = {
      enable = true;
      ide = with pkgs.jetbrains; [
        webstorm
      ];
    };
    onlyoffice.enable = true;
    penpot.enable = true;
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
    git.enable = true;
    keepassxc.enable = true;
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
