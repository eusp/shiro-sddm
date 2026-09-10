#!/usr/bin/env bash
green='\033[0;32m'
red='\033[0;31m'
bred='\033[1;31m'
cyan='\033[0;36m'
grey='\033[2;37m'
reset="\033[0m"

THEME_NAME="shiro-sddm"
THEME_DIR="/usr/share/sddm/themes/${THEME_NAME}"
CONF_FILE="/etc/sddm.conf.d/${THEME_NAME}.conf"

SHPATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

install_dependencies () {
    if command -v pacman &>/dev/null; then
        echo -e "${grey}Installing dependencies with 'pacman'...${reset}"
        sudo pacman -S --needed sddm qt6-svg qt6-multimedia-ffmpeg qt6-virtualkeyboard
    elif command -v xbps-install &>/dev/null; then
        echo -e "${grey}Installing dependencies with 'xbps'...${reset}"
        sudo xbps-install sddm qt6-svg qt6-multimedia qt6-virtualkeyboard
    elif command -v dnf &>/dev/null; then
        echo -e "${grey}Installing dependencies with 'dnf'...${reset}"
        sudo dnf install sddm qt6-qtsvg qt6-qtmultimedia qt6-qtvirtualkeyboard
    elif command -v zypper &>/dev/null; then
        echo -e "${grey}Installing dependencies with 'zypper'...${reset}"
        sudo zypper install sddm-qt6 libQt6Svg6 qt6-multimedia qt6-multimedia-imports qt6-virtualkeyboard-imports
    else
        echo -e "\n${red}Could not install dependencies!${reset}\n"
        return 1
    fi
}

copy_files () {
    # Running from the installed copy: nothing to copy.
    if [[ "$SHPATH" == "$THEME_DIR" ]]; then
        return 0
    fi
    echo -e "${grey}Copying files from '${SHPATH}/' to '${THEME_DIR}/'...${reset}"
    sudo mkdir -p "$THEME_DIR"
    sudo cp -rf "$SHPATH"/. "$THEME_DIR"/
}

copy_fonts () {
    echo -e "${grey}Copying fonts to '/usr/share/fonts/'...${reset}"
    sudo cp -r "$THEME_DIR"/fonts/{redhat,redhat-vf} /usr/share/fonts/
}

apply_theme () {
    echo -e "${grey}Writing '${CONF_FILE}'...${reset}"
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=${THEME_NAME}\n\n[General]\nGreeterEnvironment=QML2_IMPORT_PATH=${THEME_DIR}/components/" | sudo tee "$CONF_FILE" > /dev/null

    if [[ -f /etc/sddm.conf ]] && grep -Eq '^\s*Current=' /etc/sddm.conf; then
        echo -e "${bred}[WARNING]: ${red}'/etc/sddm.conf' sets 'Current=' and overrides '${CONF_FILE}'. Comment that line out.${reset}"
    fi
}

install_dependencies ;
copy_files &&
copy_fonts ;
apply_theme &&
echo -e "\n${green} Theme successfully installed!${reset}"
