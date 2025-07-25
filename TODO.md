
# TODO

- Config
  - [F] Convert all scripts to sh or make it POSIX compliant - Fuck POSIX let's do bash
  - [x] Convert all scripts to bash
  - [x] Remove auto import with files and use a single import with ". shell/src/file.sh"
  - [x] Fix install configs declaratively
    - Now the -d flag can be set to use de declarative install
    - [ ] Only the declarative install is working now FIXMEEEE!!
  - [x] Add tmux tpm plugins
    - [x] Remove tmp plugin folder on local ci
  - [ ] Add more lsp servers for nvim (lua, python, etc)
    - [ ] remove Mason
  - [ ] fix lazygit install. it is working but gives error on install
  - [ ] Configure nerd fonts for terminal
    - [ ] Jetbrains mono nerd fonts
  - [ ] Remove all unnecessary output from scripts
  - [x] Source the bashrc in the test ci
  - [x] Run the install script with bash install.sh to make sure bash is the one to be changed
  - [ ] Migrate to zsh
  - [x] Update README
  - [x] clean kitty conf file
  - [ ] Fix fira-code font install
  - [ ] Fix nvm install
  - [ ] Fix obsidian install
  - [ ] fix fzf test
  - [x] Change color vars to begin with underline
  - [x] change bash location to #!/usr/bin/env bash
  - [x] Make daily note to get undone todos from the day before to the current day
  - [x] fix bash_history
  - [ ] Config Ci to run quickly (maybe set only some scripts to run)
  - [x] Fix kitty install script

- Nixos
  - [ ] Rewrite config to use home-manager by rayan's style
  - [ ] Remove not used configs from rayan's config
  - [ ] Zsh
  - [ ] Fix refresh bash source-bash
  - [ ] Configure monitors with https://github.com/ryan4yin/nix-config/commit/ec485779ceb7afef5fbd12d3f80bbfe66e634f7f
  - [ ] Fix tmux config to the last version of zanoni

- Hyprland
  - [ ] Config top bar
  - [x] Config dmenu
  - [ ] Show workspaces on bar
  - [ ] Config audio selections