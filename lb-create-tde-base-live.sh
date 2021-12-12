#!/bin/sh

cl-builder-break --id lb-tde-base-live -f

cl-builder-prepare --source /var/calculate/linux/lb-base-desktop-$1-x86_64.iso --id lb-tde-base-live -f -v ON 

chroot /run/calculate/mount/lb-tde-base-live /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF

cl-builder-update --id lb-tde-base-live --scan ON -f -o -C ON

chroot /run/calculate/mount/lb-tde-base-live /bin/bash -x <<'EOF'

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-tde-base-live
exit
EOF

#cl-builder-image --id lb-tde-base-live -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-tde-base-live-`date +%Y%m%d`-x86_64.iso -f