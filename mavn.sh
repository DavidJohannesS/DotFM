#!/bin/bash
// -----------------------------------------------------------------------------     SETUP --- //
function mvn_installed() {
    mvn -version > /dev/null 2>&1
    return $?
}
function fzf_installed()
{
    fzf --version > /dev/null 2>&1
    return $?
}
function install_fzf() {
    if command -v brew >/dev/null 2>&1; then
        echo "Using Homebrew to install fzf..."
        brew install fzf >/dev/null 2>&1
    elif command -v apt-get >/dev/null 2>&1; then
        echo "Using APT to install fzf..."
        sudo apt-get install fzf -y >/dev/null 2>&1
    elif command -v dnf >/dev/null 2>&1; then
        echo "Using DNF to install fzf..."
        sudo dnf install fzf -y >/dev/null 2>&1
    elif command -v yum >/dev/null 2>&1; then
        echo "Using Yum to install fzf..."
        sudo yum install fzf -y >/dev/null 2>&1
    elif command -v pacman >/dev/null 2>&1; then
        echo "Using Pacman to install fzf..."
        sudo pacman -S fzf >/dev/null 2>&1
    else
        echo "No suitable package manager found. Please install fzf manually."
        exit 1
    fi
}
function install_maven()
{
    if command -v brew >/dev/null 2>&1; then
        echo "Using Homebrew to install Maven..."
        brew install maven >/dev/null 2>&1
    elif command -v apt-get >/dev/null 2>&1; then
        echo "Using APT to install Maven..."
        sudo apt-get install maven -y >/dev/null 2>&1
    elif command -v dnf >/dev/null 2>&1; then
        echo "Using DNF to install Maven..."
        sudo dnf install maven -y >/dev/null 2>&1
    elif command -v yum >/dev/null 2>&1; then
        echo "Using Yum to install Maven..."
        sudo yum install maven -y >/dev/null 2>&1
    elif command -v pacman >/dev/null 2>&1; then
        echo "Using Pacman to install Maven..."
        sudo pacman -S maven >/dev/null 2>&1
    else
        echo "No suitable package manager found. Please install Maven manually."
        exit 1
    fi
}
function dep_check()
{
    if ! fzf_installed;then
        install_fzf
    elif ! mvn_installed;then
        install_maven
    fi
}
dep_check
// ---------------------------------------------------------------------------------OPTIONS--- //
export FZF_DEFAULT_OPTS="--bind 'j:down,k:up' --header='=== Maven-Ctrl Menu ==='"
opt_checkUpdates="Check for Updates"
opt_exit="Exit"
function show_options()
{
    while true; do
        echo "=> Maven-Ctrl"
        echo
        echo "Options:"
        options=("$opt_checkUpdates" "$opt_exit")
        choice=$(printf "%s\n" "${options[@]}" | fzf --prompt='')
        menu "$choice"
    done
}
function 
function check_versions()
{
    mvn versions:display-dependency-updates
}
// -----------------------------------------------------MENU--- //
function menu()
{
    case "$1" in
        "$opt_checkUpdates")
            check_versions
            read -rp "Press any key to continue"
j
            ;;
        "$opt_exit")
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}
show_options
