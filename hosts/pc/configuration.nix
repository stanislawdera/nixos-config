{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
  ];

  networking.hostName = "pc";

  # PC specific packages
  environment.systemPackages = with pkgs; [

  ];

  system.stateVersion = "25.11";
}
