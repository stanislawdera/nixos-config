# This module configures NetworkManager to connect to an eduroam network requiring legacy TLS 1.0.
# 1. Create the environment file at /etc/secure/eduroam.env with the following contents:
#    EDUROAM_USERNAME=your_actual_username@your-university.edu
#    EDUROAM_PASSWORD=your_actual_password
# 2. Download your university's root CA certificate and save it to /etc/secure/eduroam-ca.pem.
# 3. Lock down permissions so only root can access these sensitive files:
#      sudo chown -R root:root /etc/secure
#      sudo chmod 700 /etc/secure
#      sudo chmod 600 /etc/secure/*
# 4. Replace `your-university.edu` and `radius.polsl.pl` below with your institution's specific details

{ ... }:

{
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  networking.networkmanager.ensureProfiles.environmentFiles = [ "/etc/secure/eduroam.env" ];

  networking.networkmanager.ensureProfiles.profiles = {
    eduroam = {
      connection = {
        id = "eduroam";
        type = "wifi";
      };
      wifi = {
        ssid = "eduroam";
        security = "802-11-wireless-security";
      };
      "802-11-wireless-security" = {
        key-mgmt = "wpa-eap";
      };
      "802-1x" = {
        eap = "peap";
        identity = "$EDUROAM_USERNAME";
        anonymous-identity = "anonymous@polsl.pl";
        phase2-auth = "mschapv2";
        phase1-auth-flags = 32;
        password = "$EDUROAM_PASSWORD";
        ca-cert = "/etc/secure/eduroam-ca.pem";
        domain-match = "radius.polsl.pl";
      };
    };
  };
}
