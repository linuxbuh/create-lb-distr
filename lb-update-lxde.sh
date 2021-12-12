#!/bin/sh

chroot /run/calculate/mount/lb-lxde /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF

cl-builder-update --id lb-lxde --scan ON -f -o -C ON

cl-builder-image --id lb-lxde -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-lxde-`date +%Y%m%d`-x86_64.iso -f