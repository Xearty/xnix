# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "xearty";
    homeDirectory = "/home/xearty";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    firefox
    neovim
    fzf
    ripgrep
    direnv
    ocaml
    gnumake
    cmake
    xclip
    discord
    neofetch
    qbittorrent
    mpv
    libreoffice
    bluedevil
    gcc
    nerdfonts
    nim
    neovide
    llvm
    libllvm
    doas
    unzip
    rustup
    file
    # rust-analyzer
    zig
    zls
    ghc
    # clang
    # clang-tools
    vscode
    pkg-config
    openssl
    openssl.dev
    xournal
  ];

  programs.git = {
    enable = true;
    userName = "Xearty";
    userEmail = "xeartybg@gmail.com";
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      ];
    };
    initExtra = "";
  };

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    extraConfig = ''
      background_opacity 0.9
      font_family Liberation Mono
    '';
  };

  programs.starship = {
    enable = true;
    settings = {};
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
