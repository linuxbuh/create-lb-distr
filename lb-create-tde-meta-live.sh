#!/bin/sh

cl-builder-prepare --source /var/calculate/linux/cltde-20210409a-x86_64.iso --id lb-tde-meta-live -f -v ON 

cl-builder-update --id lb-tde-meta-live --scan ON -f -o

chroot /run/calculate/mount/lb-tde-meta-live

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-meta-desktop -lb-tde-base-live -lb-tde-meta-live 
exit

cl-builder-image --id lb-tde-meta-live -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-tde-meta-live-`date +%Y%m%d`-x86_64.iso -f