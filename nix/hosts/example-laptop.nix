{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../modules/nixos/desktop.nix
    # ../hardware-configuration.nix  # copy from a real NixOS install
  ];

  networking.hostName = "example-laptop";

  # Replace with your user; keep home-manager user name in sync in flake.nix.
  users.users.ayham = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # Boot/network/locale are install-specific — fill from nixos-generate-config.
  # system.stateVersion must match your first install release and then stay put.
  system.stateVersion = "24.11";
}