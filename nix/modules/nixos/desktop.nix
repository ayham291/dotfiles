{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Wayland / dwl desktop baseline for this rice.
  programs.dwl = {
    enable = true;
    package = pkgs.callPackage ../../pkgs/dwl.nix { };
    extraSessionCommands = ''
      # Session env that must exist before clients start.
      export XDG_CURRENT_DESKTOP=dwl
      export XDG_SESSION_TYPE=wayland
      export QT_QPA_PLATFORM=wayland
      export SDL_VIDEODRIVER=wayland
      export MOZ_ENABLE_WAYLAND=1
      # QT still themed like the old gtk2 preference in shell/profile.
      export QT_QPA_PLATFORMTHEME=gtk2
    '';
  };

  # Portals for screen share / file pickers under wlroots.
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Audio: prefer system PipeWire over the old user pipewire.conf with /usr/bin paths.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Optional: seatd is typically pulled in by the graphics stack; keep graphics on.
  hardware.graphics.enable = true;

  # Useful Wayland companions that replace X11 LARBS deps.
  environment.systemPackages = with pkgs; [
    foot
    bemenu
    wl-clipboard
    grim
    slurp
    swaybg
    swaylock
    swayidle
    wlr-randr
    kanshi
    mako
    someblocks
  ];

  # Hint: enable a greeter later if you drop raw TTY login, e.g.:
  # services.greetd.enable = true;
}