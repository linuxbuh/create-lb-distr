#!/bin/sh

cl-builder-prepare --source /home/guest/iso/cls-20210405-x86_64.iso --id lb-deepin -f -v ON 

cl-builder-update --id lb-deepin --scan ON -f

chroot /run/calculate/mount/lb-deepin

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-base-desktop -lb-deepin 
exit

cl-builder-image --id lb-deepin -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-deepin-`date +%Y%m%d`-x86_64.iso -f