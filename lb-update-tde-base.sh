#!/bin/sh

chroot /run/calculate/mount/lb-tde-base /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF


cl-builder-update --id lb-tde-base --scan ON -f -o -C ON

#cl-builder-image --id lb-tde-base -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-tde-base-`date +%Y%m%d`-x86_64.iso -f