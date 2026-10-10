{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Flake root (parent of nix/).
  dots = ../../.;
in
{
  home.stateVersion = "24.11";

  # Replaces most of .config/shell/profile defaults.
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "foot";
    TERMINAL_PROG = "foot";
    BROWSER = "brave";
    MENU = "bemenu";
    STATUSBAR = "someblocks";
    SUDO_ASKPASS = "${config.home.homeDirectory}/.local/bin/dmenupass";
    PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
    ZDOTDIR = "${config.xdg.configHome}/zsh";
    QT_QPA_PLATFORMTHEME = "gtk2";
    MOZ_USE_XINPUT2 = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.local/bin/statusbar"
    "${config.home.homeDirectory}/.local/bin/cron"
  ];

  # Keep the existing zsh tree; do not let HM generate a competing .zshrc yet.
  # Source nixpkgs fast-syntax-highlighting from aliasrc/.zshrc later by
  # replacing the Arch /usr/share path with something like:
  #   source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
  # For now the plugin package is installed so you can point .zshrc at it.
  home.packages = with pkgs; [
    neovim
    lf
    fzf
    ripgrep
    brave
    mpv
    mpd
    ncmpcpp
    zathura
    newsboat
    tmux
    pass
    passExtensions.pass-otp
    libnotify
    zsh-fast-syntax-highlighting
    foot
    bemenu
    wl-clipboard
    grim
    slurp
    swaybg
    swaylock
    someblocks
  ];

  xdg.enable = true;
  xdg.configFile = {
    "nvim".source = dots + "/.config/nvim";
    "lf".source = dots + "/.config/lf";
    "mpd".source = dots + "/.config/mpd";
    "ncmpcpp".source = dots + "/.config/ncmpcpp";
    "mpv".source = dots + "/.config/mpv";
    "zathura".source = dots + "/.config/zathura";
    "newsboat".source = dots + "/.config/newsboat";
    "tmux".source = dots + "/.config/tmux";
    "fontconfig".source = dots + "/.config/fontconfig";
    "gtk-3.0".source = dots + "/.config/gtk-3.0";
    "gtk-2.0".source = dots + "/.config/gtk-2.0";
    "wget".source = dots + "/.config/wget";
    "python".source = dots + "/.config/python";
    "shell".source = dots + "/.config/shell";
    "zsh".source = dots + "/.config/zsh";
    "mimeapps.list".source = dots + "/.config/mimeapps.list";
    # Intentionally NOT linking: x11/, picom/, pulse/ with FHS paths.
  };

  # Scripts stay editable in-repo; HM symlinks the bin tree into ~/.local/bin.
  home.file.".local/bin".source = dots + "/.local/bin";

  # Default wallpaper target used by setbg (after you port it to swaybg).
  home.file.".local/share/larbs".source = dots + "/.local/share/larbs";

  # Autostart formerly in xprofile.
  systemd.user.services.mako = {
    Unit = {
      Description = "Mako notification daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.mako}/bin/mako";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}