{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # https://devenv.sh/basics/
  env.GREET = "devenv";
  # env.DISPLAY = ":0";
  env = {
    LD_LIBRARY_PATH = with pkgs;
      lib.makeLibraryPath [
        libGL
        libGLU
        glib
        xorg.libX11
        xorg.libXcursor
        xorg.libXrandr
        xorg.libXi
        mesa
        wayland
        egl-wayland
        libdrm
      ];
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    NIXOS_OZONE_WL = "1"; # For Electron apps
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1"; # If you experience cursor issues
  };
  # env.LD_LIBRARY_PATH = "${pkgs.libGL}/lib:${pkgs.libGLU}/lib:${pkgs.glib}/lib";
  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.xorg.libSM
    pkgs.xorg.libXext
    pkgs.xorg.libXrender
    pkgs.xorg.libX11
    pkgs.alejandra
    pkgs.libGL
    pkgs.libGLU
    pkgs.glib
    pkgs.xorg.libXcursor
    pkgs.xorg.libXrandr
    pkgs.xorg.libXi
    pkgs.mesa
    pkgs.wayland
    pkgs.egl-wayland
    pkgs.libdrm
    # pkgs.cudaPackages.cudatoolkit
  ];

  languages.python = {
    enable = true;
    version = "3.11.8";
    poetry = {
      enable = true;
      activate.enable = true;
      install = {
        enable = true;
        allExtras = true;
        verbosity = "more";
      };
    };
  };
  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  # scripts.hello.exec = ''
  #   echo hello from $GREET
  # '';

  enterShell = ''
    python --version
    pip --version
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
