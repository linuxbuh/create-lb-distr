#!/bin/sh

#cl-builder-prepare --source /home/guest/iso/cls-20210405-x86_64.iso --id lb-icewm -f -v ON 
cl-builder-prepare --source /var/calculate/linux/lb-base-desktop-20210925-x86_64.iso --id lb-icewm -f -v ON 

cl-builder-update --id lb-icewm --scan ON -f -o -C ON

chroot /run/calculate/mount/lb-icewm /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF

cl-builder-update --id lb-icewm --scan ON -f -o -C ON

chroot /run/calculate/mount/lb-icewm /bin/bash -x <<'EOF'
cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh && bash /tmp/create-lb-distr.sh -lb-icewm -lb-apps-office -lb-apps-network -lb-apps-1c -lb-apps-rucrypto
exit
EOF

cl-builder-image --id lb-icewm -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-icewm-`date +%Y%m%d`-x86_64.iso -f