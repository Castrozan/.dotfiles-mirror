#!/usr/bin/env bash

. "./shell/src/print.sh"

# Test if bash-completion is installed
bash_completion_test() {

    if [ -f /etc/bash_completion ]; then
        print "Bash completion is installed." "$_GREEN"
    else
        print "Bash completion is not installed." "$_RED"
        exit 1
    fi
}

# Run the test
bash_completion_test
