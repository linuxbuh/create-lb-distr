#!/bin/sh

if [ -n "$1" ]
then

DATE=$1

cl-builder-break --id lb-w10 -f

cl-builder-prepare --source /var/calculate/linux/cldx-$DATE-x86_64.iso --id lb-w10 -f -v ON

chroot /run/calculate/mount/lb-w10 /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF

cl-builder-update --id lb-w10 --scan ON -f -o -C ON

chroot /run/calculate/mount/lb-w10 /bin/bash -x <<'EOF'
emerge -C app-office/libreoffice mail-client/claws-mail media-gfx/calculate-wallpapers x11-themes/claws-mail-theme-calculate www-client/chromium
emerge net-libs/webkit-gtk-linuxbuh-bin:3 net-libs/webkit-gtk-linuxbuh-bin:2 app-office/linuxbuh-1c-installer sys-apps/linuxbuh-installer sys-apps/linuxbuh-persistence-mode x11-themes/kali-undercover x11-themes/linuxbuh-backgrounds-micro

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh

bash /tmp/create-lb-distr.sh -lb-add-linuxbuh -lb-w10 -lb-apps-office -lb-apps-network -lb-apps-1c -lb-apps-rucrypto

#bash /tmp/create-lb-distr.sh -lb-add-linuxbuh -lb-apps-office -lb-apps-network -lb-apps-1c -lb-apps-rucrypto

exit
EOF

cl-builder-image --id lb-w10 -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-w10-`date +%Y%m%d`-x86_64.iso -f

else
echo "Не введена дата исходного дистрибутива CLDX. Например 20211212"
fi
