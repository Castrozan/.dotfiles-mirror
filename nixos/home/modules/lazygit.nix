{ ... }:
{
  programs.lazygit = {
    enable = true;

    settings = {
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --paging=never --detect-dark-light always";
        };
      };
    };
  };
}
