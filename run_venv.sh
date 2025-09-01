#!/usr/bin/env bash

function get_script_dir() {
  # Globals:
  #   $0: path to the script to invoke this script
  # Outputs:
  #   script_dir
  local source="${BASH_SOURCE[0]}"
  while [ -L "${source}" ]; do
      local dir
      dir="$(cd -P "$(dirname -- "${source}")" >/dev/null 2>&1 && pwd)"
      source="$(readlink -- "${source}")"
      [[ "${source}" != /* ]] && source="${dir}/${source}"
  done
  cd -P "$(dirname -- "${source}")" >/dev/null 2>&1 && pwd
}

if [[ $0 == "./"* ]]; then
  echo "File needs to be sourced with 'source run_venv.sh'"
  exit 1
fi

repo_root=$(get_script_dir)

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
