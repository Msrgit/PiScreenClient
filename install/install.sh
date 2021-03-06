#!/bin/bash
#
# PiScreenClient Installer
# Author: mark.rawling@piscreen.com
#License: GNU General Public License v3.0
#

set -e
set -E
#set -u

#Default settings
repo="msrgit/PiScreenClient"
branch="master"
default_yes=0
upgrade=0
force_yes=0

piscrds_dir="/etc/piscrds"
piscrds_sudoers="etc/sudoers.d/080_piscrds"
piscrds_dnsmasq="etc/dnsmasq.d/080_piscrds.conf"
piscrds_sysctl="/etc/sysctl.d/80_piscrds.conf"
piscrds_logs="/home/pi/piscrds_logs"

webroot_dir="/var/www/html"
git_source="https://github.com/$repo"

#Get the latest version
readonly PISCRDS_VERSION=$(curl -s "https://api.github.com/repos/$repo/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")' )

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
        -f|--force)
            force_yes=1
            ;;
        -u|--upgrade)
            upgrade=1
            ;;
        -v|--version)
            printf "PiScreen Client ${PISCRDS_VERSION} - PiScreen Digital Signage\n"
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

#Do nothing if this version is already installed.
if [ -e "$piscrds_logs/$PISCRDS_VERSION.installed" ]; then
    touch "$piscrds_logs/$PISCRDS_VERSION.installed" 
    if [ $force_yes == "0" ]; then #but only if we're not forcing it
        exit
    fi
fi
UPDATE_URL="https:/raw.githubusercontent.com/$repo/$branch/"



function _logit() {
    flag="${2:-0}"
    case $flag in
        0)
            $start="${ANSI_GREEN}"
            ;;
        1)
            $start="${ANSI_ERROR}"
            ;;
    esac
    logname=`basename "$0"`
    logname="${logname%.*}"
    echo -n "$(date) [$logname]: " >> $piscrds_logs/${logname}.log
    echo -e "$1" >> $piscrds_logs/${logname}.log
    echo -e "$start$(date) [$logname]: $1${ANSI_RESET}"
}

function _display_welcome() {
echo -e "${ANSI_RASPBERRY}\n"
echo -e
echo -e " 888888ba  oo .d88888b                        version: ${PISCRDS_VERSION}"
echo -e " 88    \`8b    88.    \"'"
echo -e "a88aaaa8P' dP \`Y88888b. .d8888b. 88d888b. .d8888b. .d8888b. 88d888b."
echo -e " 88        88       \`8b 88'  \`\"\" 88'  \`88 88ooood8 88ooood8 88'  \`88"
echo -e " 88        88 d8'   .8P 88.  ... 88       88.  ... 88.  ... 88    88"
echo -e " dP        dP  Y88888P  \`88888P' dP       \`88888P' \`88888P' dP    dP"
echo -e
echo -e "${ANSI_RESET}\n"
}

function _configure_installation() {
    if [ "$upgrade" == 1 ]; then
        opt=(Upgrade Upgrading upgrade)
    else
        opt=(Install Installing installation)
    fi
    mkdir -p "$piscrds_logs"
    _logit "Configure ${opt[2]}, version: $PISCRDS_VERSION"
}

function _update_system_packages() {
    _logit "Updating system sources"
    sudo apt update || _logit "Unable to update system sources" 1
    sudo apt full-update || _logit "Full-Update not done" 1
}

function _install_dependencies() {
    _logit "Installing dependencies"
    sudo apt install $apt_option lighttpd git hostapd dnsmasq php7.0-cgi || _logit "Unable to install depencencies" 1
}

function _enable_php_lighttpd() {
    _logit "Enabling php lighttpd"
    sudo lighttpd-enable-mod fastcgi-php || _logit "lighttpd php already enabled"
    sudo service lighttpd force-reload
    sudo systemctl restart lighttpd.service || _logit "Unable to restart littpd" 1
}

function _create_piscrds_directories() {

    _logit "Creating PiScreen directories"
    if [ -d "$piscrds_dir" ]; then
        sudo mv $piscrds_dir "$piscrds_dir.`date +%F-%R`" || _logit "Couldn't move old '$piscrds_dir' out of the way" 1
    fi
    _logit "Creating backup and network directories in '$piscrds_dir'"
    mkdir -p "$piscrds_dir/backups"
    mkdir -p "$piscrds_dir/networking"
    _logit "Adding dhcpdc.conf as base configuration"
    cat /etc/dhcpcd.conf | sudo tee -a "$piscrds_dir"/networking/defaults > /dev/null
    _logit "Changing ownership of $piscrds_dir"
    sudo chown -R $piscrds_user:$piscrds_user "$piscrds_dir" || _logit "Couldn't change file ownership for '$piscrds_dir'"
}

function _installation_complete() {
    _logit "${opt[0]}, version: $PISCRDS_VERSION, complete"
    touch "$piscrds_logs/$PISCRDS_VERSION.installed"
}

function _install_piscrds() {
    _display_welcome
    _configure_installation
    _update_system_packages
    _install_dependencies
    _enable_php_lighttpd


    _installation_complete
}


_install_piscrds

