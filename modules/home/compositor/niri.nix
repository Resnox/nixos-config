{ pkgs, lib, config, inputs, nixosConfig, ... }:
{
  options.compositor.niri = {
    enable = lib.mkEnableOption "Enable Niri";
    terminal = lib.mkOption {
      type = lib.types.str;
      description = "Which terminal to use";
    };
  };

  imports = [
    inputs.niri.homeModules.niri
  ];

  config = lib.mkIf config.compositor.niri.enable {

    programs = {
      niri = {
        enable = true;

        package = inputs.niri.packages.${pkgs.system}.niri-unstable;

        settings = {
          input = {
            keyboard.xkb.layout = "fr";

            focus-follows-mouse = {
              enable = false;
            };

            touchpad = {
              tap = true;
              natural-scroll = true;
              disabled-on-external-mouse = true;
            };
          };

          layout = {
            gaps = 8;
            preset-column-widths = [
              { proportion = 0.125; }
              { proportion = 0.25; }
              { proportion = 0.5; }
              { proportion = 0.75; }
              { proportion = 1.0; }
            ];

            default-column-width = {
              proportion = 0.5;
            };

            focus-ring = {
              enable = true;
              width = 4;
              active = {
                gradient = {
                  from = "#26A589";
                  to = "#0F251F";
                  angle = 45;
                };
              };
            };

            tab-indicator = {
              enable = true;
              position = "bottom";
              place-within-column = true;
            };
          };

          window-rules = [
            {
              geometry-corner-radius = {
                bottom-left = 8.0;
                bottom-right = 8.0;
                top-left = 8.0;
                top-right = 8.0;
              };
              opacity = 0.925;
              clip-to-geometry = true;
              draw-border-with-background = false;
            }
          ];

          prefer-no-csd = true;

          spawn-at-startup = [
            { argv = [ "noctalia-shell" ]; }
            { argv = [ "lxqt-policykit-agent" ]; }
          ];

          clipboard = {
            disable-primary = true;
          };

          gestures = {
            hot-corners.enable = false;
          };

          hotkey-overlay = {
            skip-at-startup = true;
          };

          binds = with config.lib.niri.actions;
            lib.mkMerge [{
              "Mod+Shift+Return".action = spawn config.compositor.niri.terminal;
              "Mod+Shift+Q".action = close-window;

              "XF86AudioRaiseVolume" = {
                action = spawn "noctalia-shell" "ipc" "call" "volume" "increase";
                allow-when-locked = true;
              };
              "XF86AudioLowerVolume" = {
                action = spawn "noctalia-shell" "ipc" "call" "volume" "decrease";
                allow-when-locked = true;
              };
              "XF86AudioMute" = {
                action = spawn "noctalia-shell" "ipc" "call" "volume" "muteOutput";
                allow-when-locked = true;
              };
              "XF86AudioMicMute" = {
                action = spawn "noctalia-shell" "ipc" "call" "volume" "muteInput";
                allow-when-locked = true;
              };

              "XF86AudioPlay" = {
                action = spawn "noctalia-shell" "ipc" "call" "volume" "play";
                allow-when-locked = true;
              };
              "XF86AudioStop" = {
                action = spawn "noctalia-shell" "ipc" "call" "volume" "pause";
                allow-when-locked = true;
              };
              "XF86AudioPrev" = {
                action = spawn "noctalia-shell" "ipc" "call" "volume" "prev";
                allow-when-locked = true;
              };
              "XF86AudioNext" = {
                action = spawn "noctalia-shell" "ipc" "call" "volume" "next";
                allow-when-locked = true;
              };

              "XF86MonBrightnessUp" = {
                action = spawn "noctalia-shell" "ipc" "call" "brightness" "increase";
                allow-when-locked = true;
              };
              "XF86MonBrightnessDown" = {
                action = spawn "noctalia-shell" "ipc" "call" "brightness" "decrease";
                allow-when-locked = true;
              };

              "Alt+Tab".action = toggle-overview;

              "Mod+Left".action = focus-column-left;
              "Mod+Right".action = focus-column-right;
              "Mod+Up".action = focus-window-up;
              "Mod+Down".action = focus-window-down;

              "Mod+Shift+Left".action = move-column-left;
              "Mod+Shift+Right".action = move-column-right;
              "Mod+Shift+Up".action = move-window-up;
              "Mod+Shift+Down".action = move-window-down;

              "Mod+ampersand".action = focus-workspace 1;
              "Mod+eacute".action = focus-workspace 2;
              "Mod+quotedbl".action = focus-workspace 3;
              "Mod+apostrophe".action = focus-workspace 4;
              "Mod+parenLeft".action = focus-workspace 5;
              "Mod+minus".action = focus-workspace 6;
              "Mod+egrave".action = focus-workspace 7;
              "Mod+underscore".action = focus-workspace 8;
              "Mod+ccedilla".action = focus-workspace 9;

              "Mod+Shift+ampersand".action.move-column-to-workspace = 1;
              "Mod+Shift+eacute".action.move-column-to-workspace = 2;
              "Mod+Shift+quotedbl".action.move-column-to-workspace = 3;
              "Mod+Shift+apostrophe".action.move-column-to-workspace = 4;
              "Mod+Shift+parenLeft".action.move-column-to-workspace = 5;
              "Mod+Shift+minus".action.move-column-to-workspace = 6;
              "Mod+Shift+egrave".action.move-column-to-workspace = 7;
              "Mod+Shift+underscore".action.move-column-to-workspace = 8;
              "Mod+Shift+ccedilla".action.move-column-to-workspace = 9;

              "Mod+Shift+Ctrl+Left".action = consume-or-expel-window-left;
              "Mod+Shift+Ctrl+Right".action = consume-or-expel-window-right;

              "Mod+Escape".action = spawn "noctalia-shell" "ipc" "call" "controlCenter" "toggle";
              "Mod+Space".action = spawn "noctalia-shell" "ipc" "call" "launcher" "toggle";
              "Mod+L".action = spawn "noctalia-shell" "ipc" "call" "sessionMenu" "lockAndSuspend";
              "Mod+C".action = spawn "noctalia-shell" "ipc" "call" "launcher" "calculator";
              "Mod+X".action = spawn "noctalia-shell" "ipc" "call" "launcher" "clipboard";

              "Mod+WheelScrollDown" = {
                action = focus-workspace-down;
                cooldown-ms = 150;
              };
              "Mod+WheelScrollUp" = {
                action = focus-workspace-up;
                cooldown-ms = 150;
              };
              "Mod+WheelScrollLeft" = {
                action = focus-column-left;
                cooldown-ms = 150;
              };
              "Mod+WheelScrollRight" = {
                action = focus-column-right;
                cooldown-ms = 150;
              };

              "Mod+parenright".action = switch-preset-column-width-back;
              "Mod+Shift+parenright".action = set-column-width "-10%";
              "Mod+equal".action = switch-preset-column-width;
              "Mod+Shift+equal".action = set-column-width "+10%";

              "Mod+Ctrl+Space".action = center-column;
              "Mod+Shift+Space".action = toggle-window-floating;

              "Mod+Tab".action = toggle-column-tabbed-display;
              "Mod+F".action = maximize-column;

              "Mod+T".action = toggle-window-rule-opacity;
            }
            (lib.mkIf (config.file-manager.yazi.enable && config.terminal.ghostty.enable) {
              # Ouvre Yazi dans le terminal (Ghostty) uniquement quand Ghostty+Yazi sont activés
              "Mod+E".action = spawn config.compositor.niri.terminal "-e" "yazi";
            })
          ];
        };
      };
    };
  };
}