{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
    ../../modules/network.nix
  ];

  networking.hostName = "laptop";

  # Laptop specific packages
  environment.systemPackages = with pkgs; [
    powertop
  ];

  # Input device lag fix
  boot.extraModprobeConfig = ''
    options usbcore autosuspend=-1
  '';

  # Intel Iris Xe and dual monitor fix
  boot.kernelParams = [
    "i915.enable_guc=3"
    "i915.enable_fbc=1"
  ];

  # inotify for Next.js
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
  };

  # Hardware acceleration
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  system.stateVersion = "25.11";
}
