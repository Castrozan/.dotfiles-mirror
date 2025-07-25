#!/usr/bin/env bash

. "./shell/src/print.sh"

# Test if fzf bash history was sourced
fzf_bash_history_test() {
    echo "Test fzf bash history"
}

# Test if c-f = fzf bash history
test_cf() {
    echo "Test cf"
}

# Run the test
# fzf_bash_history_test
# test_cf
print "TODO: fix fzf bash history tests" "$_RED"
print "Skip Test fzf bash history" "$_RED"
