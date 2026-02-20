{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
  ];

  networking.hostName = "laptop";

  # Laptop specific packages
  environment.systemPackages = with pkgs; [
    powertop
  ];
}
