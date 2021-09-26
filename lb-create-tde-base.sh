#!/bin/sh

cl-builder-prepare --source /var/calculate/linux/lb-base-desktop-20210505-x86_64.iso --id lb-tde-base -f -v ON 

chroot /run/calculate/mount/lb-tde-base
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit

cl-builder-update --id lb-tde-base --scan ON -f -o -C ON

chroot /run/calculate/mount/lb-tde-base

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-tde-base 
exit

cl-builder-image --id lb-tde-base -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-tde-base-`date +%Y%m%d`-x86_64.iso -f