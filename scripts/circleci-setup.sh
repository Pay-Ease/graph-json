#!/bin/bash

function asdf_add_plugin() {
  if ! asdf plugin-list | grep "${1}"; then
    # Install missing plugin
    asdf plugin-add "${1}" "https://github.com/asdf-vm/asdf-${1}.git"
  else
    # Update existing plugin
    asdf plugin-update "${1}"
  fi
}

# Ensure exit codes other than 0 fail the build
set -e

# Check for asdf
if ! asdf | grep version; then
  # Install asdf into ~/.asdf if not previously installed
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.1.0
fi

# Add nodejs plugin for asdf
asdf_add_plugin 'nodejs'

# Install envs 
echo "Installing asdf environments..."
asdf install

hash -r

echo $PATH

# Exit successfully
exit 0
