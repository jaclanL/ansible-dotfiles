#!/usr/bin/env bash

set -e

function run_if_not_exist() {
  # run_if_not_exist if program $1 do not exist, then run command $2
  #
  # Arguments:
  #   $1: command to check
  #   $2: command to run

  if ! command -v "$1" &> /dev/null; then
    echo "$1 not found, installing..."
    $2
  fi
}

# For MacOS
if [[ "$(uname)" == "Darwin" ]]; then
  run_if_not_exist "xcode-select" "xcode-select --install"
  run_if_not_exist "brew" "curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

  # Add to PATH if not already
  if ! echo "${PATH}" | grep -q "${HOME}/opt/homebrew/bin"; then
    PATH="${PATH}:/opt/homebrew/bin"
  fi

  run_if_not_exist "pipx" "brew install pipx"

# For Linux
elif [ "$(uname -s | cut -c1-5)" = "Linux" ]; then
  run_if_not_exist "pipx" "sudo apt install pipx"

else
  echo "Setup support not implemented for given distro.."
fi
if ! echo "${PATH}" | grep -q "${HOME}/.local/bin"; then
  pipx ensurepath
  # In need of restarting the shell
  exit 0
fi
run_if_not_exist "ansible" "pipx install --include-deps ansible"
ansible-galaxy collection install -r requirements.yaml
