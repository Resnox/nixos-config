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

  application.bruno.enable = true;
  application.discord.enable = true;
  application.firefox.enable = true;
  application.google-chrome.enable = true;
  application.jetbrains = {
    enable = true;
    ide = with pkgs.jetbrains; [
      webstorm
    ];
  };
  application.onlyoffice.enable = true;
  application.penpot.enable = true;
  application.teams.enable = true;
  application.thunderbird.enable = true;
  application.vscode.enable = true;

  compositor.niri ={
    enable = true;
    terminal = "ghostty";
  };

  desktop.noctalia.enable = true;

  file-manager.yazi = {
    enable = true;
    as-default = true;
  };

  terminal.ghostty.enable = true;
  terminal.starship.enable = true;
  terminal.zsh.enable = true;

  tools.ansible.enable = true;
  tools.bitwarden.enable = true;
  tools.btop.enable = true;
  tools.git.enable = true;
  tools.keepassxc.enable = true;
  tools.ssh.enable = true;
  tools.statix.enable = true;

  programs = {
    home-manager = {
      enable = true;
    };
  };

  services.lxqt-policykit-agent.enable = true;
}
