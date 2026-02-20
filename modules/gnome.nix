{ pkgs, ... }:

{
  # GNOME extensions
  home.packages = with pkgs.gnomeExtensions; [
    dash-to-dock
    pip-on-top
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
      ];
    };

    # Dash to Dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      show-trash = false;
      show-drives = false;
      show-show-apps-button = false;
      show-mounts = false;
    };
  };
}
