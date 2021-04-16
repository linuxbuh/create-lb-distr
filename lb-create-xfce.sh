#!/bin/sh

#cl-builder-prepare --source /home/guest/iso/cls-20210405-x86_64.iso --id lb-xfce -f -v ON 
cl-builder-prepare --source /var/calculate/linux/cldx-20210412-x86_64.iso --id lb-xfce -f -v ON 

chroot /run/calculate/mount/lb-xfce
shopt -s extglob && rm -r /var/db/repos/!(calculate|distros)
emerge --sync linuxbuh
exit

#cl-builder-update --id lb-xfce --scan ON -f -o

chroot /run/calculate/mount/lb-xfce

cl-update --scan ON -f -o

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh && bash /tmp/create-lb-distr.sh -lb-add-linuxbuh -lb-xfce -lb-apps-office -lb-apps-network -lb-apps-1c

exit

cl-builder-image --id lb-xfce -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-xfce-`date +%Y%m%d`-x86_64.iso -f