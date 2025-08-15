#!/usr/bin/env bash

: '
This script setups a pre-defined tmux session with the ability to customize pane,
windows, directories and well as pre-running commands or scripts.
'

#### Customizable ####
SESSION_NAME="session"
######################

function start_python_venv() {
    # start_python_venv start the python venv
    #
    # Globals:
    #   SESSION_NAME: name of the session
    # Arguments:
    #   $1: folder
    local folder="$1"
    # Start venv
    tmux send-keys -t "${SESSION_NAME}" "python3 -m venv ${folder}/.venv" C-m
    tmux send-keys -t "${SESSION_NAME}" "source ${folder}/.venv/bin/activate" C-m
}

function custom_session() {
    # custom_session customizes the session.
    #
    # Globals:
    #   SESSION_NAME: name of the session

    #### Customizable ####
    local window_name2="venv"
    local folder2="${HOME}"
    # Create a new window
    tmux new-window -n "${window_name2}" -t "${SESSION_NAME}" -c "${folder2}"
    start_python_venv "${folder2}"
    tmux send-keys -t "${SESSION_NAME}" "clear" C-m
    #####################
}

if ! tmux has-session -t "${SESSION_NAME}" 2>/dev/null; then
    # If any session is already attached, make sure to detach that one
    if tmux ls -F "#{session_attached}" | grep -q "^1$"; then
        # Get the session name
        current_session=$(tmux display-message -p "#S")
        tmux detach -s "${current_session}"
    fi
    window_name1="w1"
    folder1="${HOME}"
    # Create and name new session
    tmux new-session -d -s "${SESSION_NAME}" -n "${window_name1}" -c "${folder1}"
    tmux send-keys -t "${SESSION_NAME}" "clear" C-m

    custom_session
    tmux attach-session -t "${SESSION_NAME}"
else
    echo "Session ${SESSION_NAME} already exist"
fi
