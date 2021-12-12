#!/bin/sh

chroot /run/calculate/mount/lb-icewm /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF

cl-builder-update --id lb-icewm --scan ON -f -o -C ON

cl-builder-image --id lb-icewm -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-icewm-`date +%Y%m%d`-x86_64.iso -f