{ config, inputs, pkgs, ...}:

{
  home = {
    username = "resnox";
    homeDirectory = "/home/resnox";

    packages = with pkgs; [
      btop
    ];

    stateVersion = "25.05";
  };

  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri.homeModules.niri
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-termfilechooser ];
    config.common."org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
  };

  programs = {
    niri = {
      enable = true;

      # package = inputs.niri.packages.${pkgs.system}.niri-unstable;

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
                from = "#813bc2ff";
                to = "#ffa600ff";
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
        		opacity = 0.9;
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

        binds = with config.lib.niri.actions; {
          "Mod+Shift+Return".action = spawn "kitty";
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

          "Mod+Escape" = {
            action = toggle-keyboard-shortcuts-inhibit;
            allow-inhibiting = false;
          };
        };
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper = {
      	enable = true;
      };
    };

    micro = {
      enable = true;
    };

    home-manager = {
      enable = true;
    };

    noctalia-shell = {
      enable = true;

      settings = {
        bar = {
          enable = true;
          floating = true;
        };

        location = {
          name = "Charleville-Mézieres";
        };

        controlCenter = {
          position = "center";
        };

        ui = {
          panelBackgroundOpacity = 0.5;
          borderRadius = 0.5;
        };

        dock = {
          enable = true;
          radiusRatio = 0.5;
          size = 0.5;
          colorizeIcons = true;
        };

        appLauncher = {
          terminalCommand = "kitty -e";
        };
      };

      colors = {
        mError = "#872424";
        mOnError = "#ffffff";
        mOnPrimary = "#ffffff";
        mOnSecondary = "#ffffff";
        mOnSurface = "#ffffff";
        mOnSurfaceVariant = "#ffffff";
        mOnTertiary = "#111111";
        mOnHover = "#ffffff";
        mOutline = "#3c3c3c";
        mPrimary = "#d68127";
        mSecondary = "#423369";
        mShadow = "#000000";
        mSurface = "#2c1d52";
        mHover = "#1f1f1f";
        mSurfaceVariant = "#15111f";
        mTertiary = "#cccccc";
      };
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = "Resnox";
          email = "bastien.rimbert@laposte.net";
        };
      };
    };

    zsh = {
      enable = true;

      zplug = {
      	enable = true;

      	plugins = [
      	  { name = "zsh-users/zsh-autosuggestions"; }
      	];
      };
    };

    vscode = {
      enable = true;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        sudo.disabled = false;
      };
    };

    kitty = {
      enable = true;
      settings = {
        shell = "zsh";
        confirm_os_window_close = 0;
      };
      font = {
      	name = "JetBrainsMono Nerd Font";
      };
    };

    yazi = {
      enable = true;
      settings = {
        show_hidden = true;
      };
    };

    bash = {
      enable = true;
      enableCompletion = true;
    };
  };

  services.lxqt-policykit-agent.enable = true;
}
