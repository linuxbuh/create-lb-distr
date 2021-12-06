#!/bin/sh

#cl-builder-prepare --source /home/guest/iso/cls-20210405-x86_64.iso --id lb-lxde -f -v ON 
#cl-builder-prepare --source /var/calculate/linux/lb-lxde-20211123-x86_64.iso --id lb-lxde -f -v ON 

#cl-builder-update --id lb-lxde --scan ON -f -o -C ON

chroot /run/calculate/mount/lb-lxde /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF

cl-builder-update --id lb-lxde --scan ON -f -o -C ON

#chroot /run/calculate/mount/lb-lxde /bin/bash -x <<'EOF'
#cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh && bash /tmp/create-lb-distr.sh -lb-lxde -lb-apps-office -lb-apps-network -lb-apps-1c -lb-apps-rucrypto
#exit
#EOF

cl-builder-image --id lb-lxde -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-lxde-`date +%Y%m%d`-x86_64.iso -f