#!/bin/sh

#cl-builder-prepare --source /home/guest/iso/cls-20210405-x86_64.iso --id lb-windows10 -f -v ON 
cl-builder-prepare --source /var/calculate/linux/lb-windows10-20210416-x86_64.iso --id lb-windows10 -f -v ON

chroot /run/calculate/mount/lb-windows10 
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit

cl-builder-update --id lb-windows10 --scan ON -f -o -C ON

chroot /run/calculate/mount/lb-windows10
emerge -C app-office/libreoffice mail-client/claws-mail media-gfx/calculate-wallpapers x11-themes/claws-mail-theme-calculate www-client/chromium
emerge net-libs/webkit-gtk-linuxbuh-bin:3 net-libs/webkit-gtk-linuxbuh-bin:2 app-office/linuxbuh-1c-installer sys-apps/linuxbuh-installer sys-apps/linuxbuh-persistence-mode www-client/midori x11-themes/kali-undercover x11-themes/linuxbuh-backgrounds-micro


cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh && bash /tmp/create-lb-distr.sh -lb-add-linuxbuh -lb-windows10 -lb-apps-office -lb-apps-network -lb-apps-1c

exit

cl-builder-image --id lb-windows10 -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-windows10-`date +%Y%m%d`-x86_64.iso -f

mkdir /mnt/iso
mkdir /mnt/iso1
mount -o loop /var/calculate/linux/lb-windows10-20210419a-x86_64.iso /mnt/iso
cp -r /mnt/iso/* /mnt/iso1
umount /mnt/iso
mkisofs -v -J -o /var/calculate/linux/lb-windows10-20210419-x86_64.iso /mnt/iso1
rm -r  /mnt/iso
rm -r /mnt/iso1

