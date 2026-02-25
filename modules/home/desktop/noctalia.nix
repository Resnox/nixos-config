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

        colors = {
          mPrimary = "#1E9177";
          mOnPrimary = "#B8C8C4";
          mSecondary = "#167A63";
          mOnSecondary = "#B8C8C4";
          mTertiary = "#26A589";
          mOnTertiary = "#B8C8C4";
          mError = "#933636";
          mOnError = "#B8C8C4";
          mSurface = "#081512";
          mOnSurface = "#A6B5B1";
          mSurfaceVariant = "#0F251F";
          mOnSurfaceVariant = "#99A8A4";
          mOutline = "#1B6352";
          mShadow = "#040A09";
          mHover = "#26A589";
          mOnHover = "#B8C8C4";
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