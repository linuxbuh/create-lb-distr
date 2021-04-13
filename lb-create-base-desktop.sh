#!/bin/sh

#cl-builder-prepare --source /home/guest/iso/cls-20210405-x86_64.iso --id lb-base-desktop -f -v ON 

cl-builder-update --id lb-base-desktop --scan ON -f

chroot /run/calculate/mount/lb-base-desktop

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-base-desktop
exit

cl-builder-image --id lb-base-desktop -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-base-desktop-`date +%Y%m%d`-x86_64.iso -f