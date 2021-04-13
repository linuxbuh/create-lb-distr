#!/bin/sh

#cl-builder-prepare --source /home/guest/iso/cls-20210405-x86_64.iso --id lb-tde-base-live -f -v ON 

cl-builder-update --id lb-tde-base-live --scan ON -f

chroot /run/calculate/mount/lb-tde-base-live

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-base-desktop -lb-tde-base-live 
exit

cl-builder-image --id lb-tde-base-live -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-tde-base-live-`date +%Y%m%d`-x86_64.iso -f