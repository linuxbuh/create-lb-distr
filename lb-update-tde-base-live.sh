#!/bin/sh

chroot /run/calculate/mount/lb-tde-base-live /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF


cl-builder-update --id lb-tde-base-live --scan ON -f -o -C ON

cl-builder-image --id lb-tde-base-live -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-tde-base-live-`date +%Y%m%d`-x86_64.iso -f