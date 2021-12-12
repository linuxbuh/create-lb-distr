#!/bin/sh

chroot /run/calculate/mount/lb-w10 /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF

cl-builder-update --id lb-w10 --scan ON -f -o -C ON

cl-builder-image --id lb-w10 -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-w10-`date +%Y%m%d`-x86_64.iso -f

