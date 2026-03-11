{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.desktop.noctalia = {
    enable = lib.mkEnableOption "Enable Noctalia";
  };

  imports = [
    inputs.noctalia.homeModules.default
  ];

  config = lib.mkIf config.desktop.noctalia.enable {
    programs = {
      noctalia-shell = {
        enable = true;

        settings = {
          colorSchemes = {
            predefinedScheme = "Osaka jade";
            darkMode = true;
          };

          bar = {
            enable = true;
            floating = true;
            widgets = {
              left = [
                {
                  enableColorization = true;
                  id = "ControlCenter";
                  useDistroLogo = true;
                }
                {
                  id = "Workspace";
                }
              ];
              center = [
                {
                  id = "Taskbar";
                }
                {
                  id = "MediaMini";
                }
              ];
              right = [
                {
                  compactMode = true;
                  id = "SystemMonitor";
                  showCpuFreq = false;
                  showCpuTemp = true;
                  showCpuUsage = true;
                  showDiskAvailable = false;
                  showDiskUsage = true;
                  showDiskUsageAsPercent = false;
                  showGpuTemp = false;
                  showLoadAverage = false;
                  showMemoryAsPercent = false;
                  showMemoryUsage = true;
                  showNetworkStats = false;
                  showSwapUsage = false;
                }
                {
                  displayMode = "graphic";
                  id = "Battery";
                }
                {
                  id = "Volume";
                }
                {
                  id = "Brightness";
                }
                {
                  id = "plugin:screen-recorder";
                }
                {
                  defaultSettings = {
                    mode = "region";
                  };
                  id = "plugin:screenshot";
                }
                {
                  defaultSettings = {
                    refreshInterval = 5000;
                  };
                  id = "plugin:mini-docker";
                }
                {
                  defaultSettings = {
                    notecardsEnabled = true;
                    pincardsEnabled = true;
                    position = "Bottom";
                    showCloseButton = false;
                  };
                  id = "plugin:clipper";
                }
                {
                  id = "NotificationHistory";
                }
                {
                  drawerEnabled = true;
                  id = "Tray";
                }
                {
                  id = "Clock";
                  formatHorizontal = "HH mm ddd, MMM dd";
                  formatVertical = "HH mm - dd MM";
                }
              ];
            };
          };

          templates = {
            activeTemplates = [
              {
                enabled = true;
                id = "ghostty";
              }
              {
                enabled = true;
                id = "gtk";
              }
              {
                enabled = true;
                id = "niri";
              }
              {
                enabled = true;
                id = "qt";
              }
              {
                enabled = true;
                id = "code";
              }
              {
                enabled = true;
                id = "btop";
              }
              {
                enabled = true;
                id = "yazi";
              }
            ];
            enableUserTheming = false;
          };

          location = {
            name = "Charleville-Mézieres";
          };

          controlCenter = {
            position = "center";
          };

          ui = {
            panelBackgroundOpacity = 1;
            borderRadius = 0.5;
          };

          dock = {
            enable = true;
            radiusRatio = 0.5;
            size = 0.5;
            colorizeIcons = true;
          };

          appLauncher = {
            terminalCommand = lib.mkIf config.terminal.ghostty.enable "ghostty -e";
          };
        };

        plugins = {
          sources = [
            {
              enabled = true;
              name = "Official Noctalia Plugins";
              url = "https://github.com/noctalia-dev/noctalia-plugins";
            }
          ];
          states = {
            clipper = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
            mini-docker = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
            screenshot = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
            screen-recorder = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
          };
          version = 2;
        };
      };
    };

    home.packages = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      gpu-screen-recorder
    ];

    xdg.portal = {
      enable = true;

      xdgOpenUsePortal = true;

      config.common.default = "gtk";
    };
  };
}