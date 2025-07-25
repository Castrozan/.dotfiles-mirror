#!/usr/bin/env bash

. "./declarative.sh"
. "shell/src/print.sh"
. "shell/src/is_sourced.sh"

# Function to source config by file path
# $1: config file path
source_config_by_name() {
    file="$1"

    if [ -f "$file" ]; then
        full_path="\$HOME/$_DOTFILES_DIR/$file"
        if is_sourced "$full_path"; then
            print "$full_path is already sourced in $_SH." "$_YELLOW"
        else
            # Add the source command to .bashrc
            # shellcheck disable=SC2028
            echo ". $full_path" >>"$_SH"
            print "$full_path has been sourced." "$_GREEN"
        fi
    else
        print "Config $file does not exist." "$_RED"
    fi
}

# Function to config scripts defined on _DOTFILES_CONFIGS_TO_INSTALL
# defined on the ./config.sh file
_declarative_config() {
    _configs=$_DOTFILES_CONFIGS_TO_INSTALL

    for _config in $_configs; do
        file="shell/configs/$_config.sh"

        source_config_by_name "$file"
    done
}

# Function to config all configs that are in the /shell/configs directory
_interactive_config() {
    _dir=$_CONFIGS_DIR

    for file in "$_dir"/*; do
        source_config_by_name "$file"
    done
}

# Function to install configs
install_configs() {

    # Check if configs are set to be installed declaratively
    if [ -n "$_DOTFILES_CONFIGS_TO_INSTALL" ]; then
        _declarative_config
    else
        _interactive_config
    fi
}
