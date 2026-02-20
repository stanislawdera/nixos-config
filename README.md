# ❄️ My NixOS config

*_A perfectly reproducible way to break my computer_*

## Enabling secure boot

1. Disable secure boot

2. Generate keys
```bash
sudo sbctl create-keys
```

3. Enable secure boot

Enable secure boot in *_setup_* mode. If there's no *_setup_* mode, enable secure boot and delete PK key.

4. Change config for host in flake.nix
```nix
laptop = mkHost {
  hostName = "laptop";
  secureBoot = true; # <- change to true
};
```

5. Rebuild system

6. Enroll keys
```bash
sudo sbctl enroll-keys --microsoft
```

7. Reboot

8. Check status
```bash
sbctl status
```
