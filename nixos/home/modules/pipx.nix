{ pkgs, ... }:
{
  home.packages = with pkgs; [
    python311Packages.pipx
  ];

  # Ensure pipx bin directory is in PATH
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Configure pipx environment variables
  home.sessionVariables = {
    PIPX_HOME = "$HOME/.local/pipx";
    PIPX_BIN_DIR = "$HOME/.local/bin";
  };

  # Set up pipx directories
  home.activation = {
    pipxSetup = {
      after = [
        "writeBoundary"
        "installPackages"
      ];
      before = [ ];
      data = ''
        # Create pipx directories if they don't exist
        mkdir -p $HOME/.local/bin
        mkdir -p $HOME/.local/pipx
      '';
    };
  };
}
