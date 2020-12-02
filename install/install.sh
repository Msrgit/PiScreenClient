#!/bin/bash

#Default settings
repo="msrgit/PiScreenClient"

#Get the latest version
readonly PISCREEN_VERSION=

# Define terminal colours
readonly ANSI_RED="\033[0;31m"
readonly ANSI_GREEN="\033[0;32m"
readonly ANSI_YELLOW="\033[0;33m"
readonly ANSI_RASPBERRY="\033[0;35m"
readonly ANSI_ERROR="\033[1;37;41m"
readonly ANSI_RESET="\033[m"


function _display_welcome() {
echo -e "${ANSI_RASPBERRY}\n"
echo -e
echo -e " 888888ba  oo .d88888b                        version: ${PISCREEN_VERSION}"
echo -e " 88    \`8b    88.    \"'"
echo -e "a88aaaa8P' dP \`Y88888b. .d8888b. 88d888b. .d8888b. .d8888b. 88d888b."
echo -e " 88        88       \`8b 88'  \`\"\" 88'  \`88 88ooood8 88ooood8 88'  \`88"
echo -e " 88        88 d8'   .8P 88.  ... 88       88.  ... 88.  ... 88    88"
echo -e " dP        dP  Y88888P  \`88888P' dP       \`88888P' \`88888P' dP    dP"
echo -e

echo -e "${ANSI_RESET}\n"
}

function _install_psclient() {
    _display_welcome;
}


_install_psclient

