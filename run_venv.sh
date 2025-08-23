#!/usr/bin/env bash

set -e

function get_script_dir() {
  cd "$(dirname "$0")" >/dev/null 2>&1 && pwd
}

if [[ $0 == "./"* ]]; then
  echo "File needs to be sourced with 'source run_venv.sh'"
  exit 1
fi

repo_root=$(git -C "$(get_script_dir)" rev-parse --show-toplevel)

echo "Starting venv... @ ${repo_root}/.venv"
python3 -m venv "${repo_root}/.venv"
# shellcheck source=/dev/null
source "${repo_root}/.venv/bin/activate"

if [[ -f "${repo_root}/requirements.txt" ]]; then
  python3 -m pip install \
    --disable-pip-version-check \
    -r "${repo_root}/requirements.txt" > /dev/null
fi

if [ ! -f "${repo_root}/.git/hooks/pre-commit" ]; then
    pre-commit install
fi

echo "To stop venv: 'deactivate'"
