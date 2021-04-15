#!/bin/sh

cl-builder-prepare --source /var/calculate/linux/cltde-20210409-x86_64.iso --id lb-tde-all-live -f -v ON 

cl-builder-update --id lb-tde-all-live --scan ON -f -o

chroot /run/calculate/mount/lb-tde-all-live

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-all-desktop -lb-tde-base-live -lb-tde-meta-live -lb-tde-all-live 
exit

cl-builder-image --id lb-tde-all-live -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-tde-all-live-`date +%Y%m%d`-x86_64.iso -f