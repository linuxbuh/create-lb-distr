#!/bin/sh

#cl-builder-prepare --source /home/guest/iso/cls-20210405-x86_64.iso --id lb-xfce -f -v ON 
cl-builder-prepare --source /var/calculate/linux/lb-base-desktop-20210414-x86_64.iso --id lb-xfce -f -v ON 

cl-builder-update --id lb-xfce --scan ON -f

chroot /run/calculate/mount/lb-xfce

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-xfce
exit

cl-builder-image --id lb-base-desktop -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-xfce-`date +%Y%m%d`-x86_64.iso -f