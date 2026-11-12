{ pkgs, lib, config, ... }:
{
  options.compositor.niri = {
    enable = lib.mkEnableOption "Enable Niri";
    terminal = lib.mkOption {
      type = lib.types.str;
      description = "Which terminal to use";
    };
  };

  config = lib.mkIf config.compositor.niri.enable {
    wayland.windowManager = {
      niri = {
        enable = true;

        package = pkgs.niri;

        settings = {
          input = {
            keyboard.xkb.layout = "fr";
            touchpad = {
              tap = {};
              natural-scroll = {};
              disabled-on-external-mouse = {};
            };
          };

          layout = {
            gaps = 8;
            preset-column-widths._children = [
              { proportion = 0.125; }
              { proportion = 0.25; }
              { proportion = 0.5; }
              { proportion = 0.75; }
              { proportion = 1.0; }
            ];
            default-column-width.proportion = 0.5;
            focus-ring = {
              width = 4;
              active-gradient._props = {
                from = "#26A589";
                to = "#0F251F";
                angle = 45;
              };
            };
            tab-indicator = {
              position = "bottom";
              place-within-column = {};
            };
          };

          prefer-no-csd = {};
          clipboard.disable-primary = {};
          gestures.hot-corners.off = {};
          hotkey-overlay.skip-at-startup = {};

          _children = [
            { spawn-at-startup = [ "noctalia-shell" ]; }
            {
              window-rule = {
                geometry-corner-radius = 8.0;
                opacity = 0.925;
                clip-to-geometry = true;
                draw-border-with-background = false;
              };
            }
          ];

          binds = lib.mkMerge [
            {
              "Mod+Shift+Return".spawn = [ config.compositor.niri.terminal ];
              "Mod+Shift+Q".close-window = {};

              "XF86AudioRaiseVolume" = {
                spawn = [ "noctalia-shell" "ipc" "call" "volume" "increase" ];
                _props.allow-when-locked = true;
              };
              "XF86AudioLowerVolume" = {
                spawn = [ "noctalia-shell" "ipc" "call" "volume" "decrease" ];
                _props.allow-when-locked = true;
              };
              "XF86AudioMute" = {
                spawn = [ "noctalia-shell" "ipc" "call" "volume" "muteOutput" ];
                _props.allow-when-locked = true;
              };
              "XF86AudioMicMute" = {
                spawn = [ "noctalia-shell" "ipc" "call" "volume" "muteInput" ];
                _props.allow-when-locked = true;
              };

              "XF86AudioPlay" = {
                spawn = [ "noctalia-shell" "ipc" "call" "volume" "play" ];
                _props.allow-when-locked = true;
              };
              "XF86AudioStop" = {
                spawn = [ "noctalia-shell" "ipc" "call" "volume" "pause" ];
                _props.allow-when-locked = true;
              };
              "XF86AudioPrev" = {
                spawn = [ "noctalia-shell" "ipc" "call" "volume" "prev" ];
                _props.allow-when-locked = true;
              };
              "XF86AudioNext" = {
                spawn = [ "noctalia-shell" "ipc" "call" "volume" "next" ];
                _props.allow-when-locked = true;
              };

              "XF86MonBrightnessUp" = {
                spawn = [ "noctalia-shell" "ipc" "call" "brightness" "increase" ];
                _props.allow-when-locked = true;
              };
              "XF86MonBrightnessDown" = {
                spawn = [ "noctalia-shell" "ipc" "call" "brightness" "decrease" ];
                _props.allow-when-locked = true;
              };

              "Alt+Tab".toggle-overview = {};

              "Mod+Left".focus-column-left = {};
              "Mod+Right".focus-column-right = {};
              "Mod+Up".focus-window-up = {};
              "Mod+Down".focus-window-down = {};

              "Mod+Shift+Left".move-column-left = {};
              "Mod+Shift+Right".move-column-right = {};
              "Mod+Shift+Up".move-window-up = {};
              "Mod+Shift+Down".move-window-down = {};

              "Mod+ampersand".focus-workspace = 1;
              "Mod+eacute".focus-workspace = 2;
              "Mod+quotedbl".focus-workspace = 3;
              "Mod+apostrophe".focus-workspace = 4;
              "Mod+parenLeft".focus-workspace = 5;
              "Mod+minus".focus-workspace = 6;
              "Mod+egrave".focus-workspace = 7;
              "Mod+underscore".focus-workspace = 8;
              "Mod+ccedilla".focus-workspace = 9;

              "Mod+Shift+ampersand".move-column-to-workspace = 1;
              "Mod+Shift+eacute".move-column-to-workspace = 2;
              "Mod+Shift+quotedbl".move-column-to-workspace = 3;
              "Mod+Shift+apostrophe".move-column-to-workspace = 4;
              "Mod+Shift+parenLeft".move-column-to-workspace = 5;
              "Mod+Shift+minus".move-column-to-workspace = 6;
              "Mod+Shift+egrave".move-column-to-workspace = 7;
              "Mod+Shift+underscore".move-column-to-workspace = 8;
              "Mod+Shift+ccedilla".move-column-to-workspace = 9;

              "Mod+Shift+Ctrl+Left".consume-or-expel-window-left = {};
              "Mod+Shift+Ctrl+Right".consume-or-expel-window-right = {};

              "Mod+Escape".spawn = [ "noctalia-shell" "ipc" "call" "controlCenter" "toggle" ];
              "Mod+Space".spawn = [ "noctalia-shell" "ipc" "call" "launcher" "toggle" ];
              "Mod+L".spawn = [ "noctalia-shell" "ipc" "call" "sessionMenu" "lockAndSuspend" ];
              "Mod+C".spawn = [ "noctalia-shell" "ipc" "call" "launcher" "calculator" ];
              "Mod+X".spawn = [ "noctalia-shell" "ipc" "call" "launcher" "clipboard" ];

              "Mod+WheelScrollDown" = {
                focus-workspace-down = {};
                _props.cooldown-ms = 150;
              };
              "Mod+WheelScrollUp" = {
                focus-workspace-up = {};
                _props.cooldown-ms = 150;
              };
              "Mod+WheelScrollLeft" = {
                focus-column-left = {};
                _props.cooldown-ms = 150;
              };
              "Mod+WheelScrollRight" = {
                focus-column-right = {};
                _props.cooldown-ms = 150;
              };

              "Mod+parenright".switch-preset-column-width-back = {};
              "Mod+Shift+parenright".set-column-width = "-10%";
              "Mod+equal".switch-preset-column-width = {};
              "Mod+Shift+equal".set-column-width = "+10%";

              "Mod+Ctrl+Space".center-column = {};
              "Mod+Shift+Space".toggle-window-floating = {};

              "Mod+Tab".toggle-column-tabbed-display = {};
              "Mod+F".maximize-column = {};

              "Mod+T".toggle-window-rule-opacity = {};
            }
            (lib.mkIf (config.file-manager.yazi.enable && config.terminal.ghostty.enable) {
              "Mod+E".spawn = [ config.compositor.niri.terminal "-e" "yazi" ];
            })
          ];
        };
      };
    };
  };
}
