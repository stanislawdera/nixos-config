{ pkgs, lib, hostName, ... }:

let
  # On all devices
  sharedPackages = with pkgs; [
    vscode
    zed-editor
    yubioath-flutter
    rpi-imager
  ];

  # Only on laptop
  laptopPackages = with pkgs; [
  ];

  # Only on PC
  pcPackages = with pkgs; [
  ];

in
{
  imports = [
      ./gnome.nix
      ./zsh.nix
  ];

  home.username = "staszek";
  home.homeDirectory = "/home/staszek";

  # My apps
  home.packages = sharedPackages
      ++ lib.optionals (hostName == "laptop") laptopPackages
      ++ lib.optionals (hostName == "pc") pcPackages;

  # Git
  programs.git = {
    enable = true;
    settings.user = {
      name = "Stanisław Dera";
      email = "stanislaw@dera.dev";
    };
  };

  home.stateVersion = "25.11";
}
