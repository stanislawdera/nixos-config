{ pkgs, ... }:

{
  # GNOME extensions
  home.packages = with pkgs.gnomeExtensions; [
    dash-to-dock
    pip-on-top
    clipboard-indicator
  ];

  dconf.settings = {
    # Window buttons
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };

    # Enable Extensions
    "org/gnome/shell" = {
      enabled-extensions = with pkgs.gnomeExtensions; [
        dash-to-dock.extensionUuid
        pip-on-top.extensionUuid
        clipboard-indicator.extensionUuid
      ];
    };

    # Dash to Dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      show-trash = false;
      show-drives = false;
      show-show-apps-button = false;
      show-mounts = false;
    };

    # Clipboard history
    "org/gnome/shell/keybindings" = {
        focus-active-notification = [];
        toggle-message-tray = [];
    };
    "org/gnome/shell/extensions/clipboard-indicator" = {
          toggle-menu = ["<Super>v"];
    };
  };
}
