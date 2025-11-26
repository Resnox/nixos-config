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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "resnox-os";
  networking.networkmanager.enable = true;

  users.users.resnox = {
    isNormalUser = true;
    extraGroups = [ "wheel" "seat" ];
    packages = with pkgs; [
      tree
      jetbrains.webstorm
      xwayland-satellite
      keepassxc
      bitwarden-desktop
      teams-for-linux
      discord
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  security.polkit.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  console.keyMap = "fr";

  environment.systemPackages = with pkgs; [
    nano
    git
    wget

    google-chrome
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

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.tuned = {
  	enable = true;
  };

  services.upower = {
  	enable = true;
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };

  services.xserver = {
    videoDrivers = [ "mesa" ];
  };

  services.spice-vdagentd.enable = true;

  system.stateVersion = "25.05";
}

