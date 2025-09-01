#!/usr/bin/env bash

if [[ $0 == "./"* ]]; then
  echo "File needs to be sourced with 'source run_venv.sh'"
  exit 1
fi

repo_root="$(dirname "$(realpath "$0")")"

echo "Starting venv... @ ${repo_root}/.venv"
python3 -m venv "${repo_root}/.venv"
# shellcheck source=/dev/null
source "${repo_root}/.venv/bin/activate"

if [[ -f "${repo_root}/requirements.txt" ]]; then
  python3 -m pip install \
    --disable-pip-version-check \
    -r "${repo_root}/requirements.txt" > /dev/null
fi

# Don't install pre-commit if in GitHub Actions or if already exist
if [ -z "${GITHUB_ACTIONS}" ] && [ ! -f "${repo_root}/.git/hooks/pre-commit" ]; then
  pre-commit install
fi

echo "To stop venv: 'deactivate'"
