#!/bin/bash
#
# PiScreenClient Installer
# Author: mark.rawling@piscreen.com
#License: GNU General Public License v3.0
#

set -e
set -E
set -u

#Default settings
repo="msrgit/PiScreenClient"
branch="master"
default_yes=0
upgrade=0

#Get the latest version
readonly PISCREEN_VERSION=$(curl -s "https://api.github.com/repos/$repo/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")' )

# Define terminal colours
readonly ANSI_RED="\033[0;31m"
readonly ANSI_GREEN="\033[0;32m"
readonly ANSI_YELLOW="\033[0;33m"
readonly ANSI_RASPBERRY="\033[0;35m"
readonly ANSI_ERROR="\033[1;37;41m"
readonly ANSI_RESET="\033[m"

#Parse command line
while :; do
    case $1 in
        -y|--yes|--apt-yes)
            default_yes=1
            apt_option="-y"
            ;;
        -u|--upgrade)
            upgrade=1
            ;;
        -v|--version)
            printf "PiScreen Client v${PISCREEN_VERSION} - PiScreen Digital Signage"
            exit 1
            ;;
        -*|--*)
            echo "Option unknown: $1"
            exit 1
            ;;
        *)
            break
            ;;
    esac
    shift
done

UPDATE_URL="https:/raw.githubusercontent.com/$repo/$branch/"

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

