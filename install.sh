#!/bin/bash

THEME_DIR='usr/share/grub/themes'

ROOT_UID=0
if [[ ! "${UID}" -eq "${ROOT_UID}" ]]; then
    echo 'Run as root.'
    exit 1
fi

if [[ ! -d "${THEME_DIR}/ortho_theme" ]]; then
	mkdir -p "${THEME_DIR}/ortho_theme"
	cp -a ./theme/* "${THEME_DIR}/ortho_theme"
fi

sed -i '/GRUB_TIMEOUT_STYLE=/d' /etc/default/grub
echo 'GRUB_TIMEOUT_STYLE="menu"' >> /etc/default/grub

sed -i '/GRUB_TIMEOUT=/d' /etc/default/grub
echo 'GRUB_TIMEOUT="10"' >> /etc/default/grub

sed -i '/GRUB_THEME=/d' /etc/default/grub
echo "GRUB_THEME=\"${THEME_DIR}/ortho_theme/theme.txt\"" >> /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg
