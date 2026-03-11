{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;

    extraSpecialArgs = { inherit inputs; };
    users = {
      resnox = import ./home.nix;
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    tmp.cleanOnBoot = true;
  };

  networking.hostName = "resnox-os";
  networking.networkmanager.enable = true;

  users.mutableUsers = false;
  users.users.resnox = {
    isNormalUser = true;
    extraGroups = [ "wheel" "seat" ];
    hashedPassword = "$y$j9T$.Hmv9yFCiNzB0CU48if8.1$HC83Lzz..7OitsLIuhR3CQQVsQldauxzXSrE0ZelHPD";

    # Core packages
    packages = with pkgs; [
      tree
      xwayland-satellite
    ];

    # Shell
    ignoreShellProgramCheck = true;
    shell = pkgs.zsh;
  };
  
  virtualisation.docker ={
    rootless = {
      enable = true;
      setSocketVariable = true;
    };

    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  security.polkit ={
    enable = true;
    extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (subject.isInGroup("wheel")) {
            return polkit.Result.YES;
          }
        });
      '';
  };

  security.sudo = {
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "45min";
      options = "--delete-older-than 30d";
    };
  };

  console.keyMap = "fr";

  environment.systemPackages = with pkgs; [
    nano
    git
    wget
    xdg-utils
  ];

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
      ];
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services = {
    xserver.xkb.layout = "fr";

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    tuned = {
      enable = true;
    };

    upower = {
      enable = true;
    };

    pulseaudio.enable = false;

    displayManager = {
      sessionPackages = with pkgs; [niri];

      autoLogin = {
        enable = true;
        user = "resnox";
      };

      gdm = {
        enable = true;
        wayland = true;
      };
    };

    xserver = {
      videoDrivers = [ "mesa" ];
    };

    spice-vdagentd.enable = true;
  };

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = ["wlr" "gtk"];
      };
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";

    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri";
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "25.05";
}

