#!/bin/sh

cl-builder-prepare --source /home/guest/iso/cls-20210405-x86_64.iso --id lb-tde-base-livedeepin -f -v ON 

cl-builder-update --id lb-tde-base-livedeepin --scan ON -f

chroot /run/calculate/mount/lb-tde-base-livedeepin

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-base-desktop -deepin 
exit

cl-builder-image --id lb-tde-base-livedeepin -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-tde-base-livedeepin-`date +%Y%m%d`-x86_64.iso -f