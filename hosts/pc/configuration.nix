{ pkgs, config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
  ];

  networking.hostName = "pc";

  # NVIDIA stuff
  hardware.graphics = {
      enable = true;
    };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false;
  };

  # PC specific packages
  environment.systemPackages = with pkgs; [

  ];

  system.stateVersion = "25.11";
}
