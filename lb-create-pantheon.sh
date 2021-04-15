#!/bin/sh

#cl-builder-prepare --source /home/guest/iso/cls-20210405-x86_64.iso --id lb-pantheon -f -v ON 
cl-builder-prepare --source /var/calculate/linux/lb-base-desktop-20210414-x86_64.iso --id lb-pantheon -f -v ON 

cl-builder-update --id lb-pantheon --scan ON -f

chroot /run/calculate/mount/lb-pantheon

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-pantheon
exit

cl-builder-image --id lb-pantheon -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-pantheon-`date +%Y%m%d`-x86_64.iso -f