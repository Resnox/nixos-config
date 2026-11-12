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
      noctalia = {
        enable = true;

        settings = {
          theme = {
            mode = "dark";
            source = "community";
            community_palette = "Osaka jade";
            templates.builtin_ids = [ "ghostty" "gtk3" "gtk4" "niri" "kcolorscheme" "qt" "btop" ];
          };

          shell = {
            corner_radius_scale = 0.5;
            polkit_agent = true;
            panel.control_center_placement = "floating";
            launcher = {
              sort_by_usage = false;
              app_grid = true;
              categories = false;
              compact = true;
              providers.session.global = false;
              providers.windows.global = false;
            };
          };

          location.address = "Charleville-Mézieres";

          bar.main = {
            start = [ "control-center" "workspaces" ];
            center = [ "taskbar" "media" ];
            end = [
              "cpu" "cpu_temp" "disk" "ram"
              "battery" "volume" "brightness" "recorder" "screenshot"
              "clipboard" "notifications" "tray" "clock"
            ];
          };

          widget = {
            cpu = { type = "sysmon"; stat = "cpu_usage"; };
            cpu_temp = { type = "sysmon"; stat = "cpu_temp"; };
            disk = { type = "sysmon"; stat = "disk_used"; };
            ram = { type = "sysmon"; stat = "ram_used"; };
            battery.display_mode = "graphic";
            clock = {
              format = "{:%H %M %a, %b %d}";
              vertical_format = "{:%H %M - %d %m}";
            };
            recorder.type = "noctalia/screen_recorder:recorder";
          };

          dock.enabled = true;
          plugins.enabled = [ "noctalia/screen_recorder" ];
        };
      };
    };

    home.packages = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      gpu-screen-recorder
      slurp
    ];

    xdg.portal = {
      enable = true;

      xdgOpenUsePortal = true;

      config.common.default = "gtk";
    };
  };
}