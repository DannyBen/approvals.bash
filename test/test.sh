#!/usr/bin/env bash
# Run this from the root directory

# Soure the approvals script
source "approvals.bash"

# Test commands
cd ./test || exit
approve "./sample-cli-app.sh"
approve "./sample-cli-app.sh --help"
approve "./sample-cli-app.sh say"
approve "./sample-cli-app.sh say hello"
approve "./sample-cli-app.sh say hello" "alternative_fixture_file"

# Write approvals to a different directory
APPROVALS_DIR=alt-approvals
approve "./sample-cli-app.sh"