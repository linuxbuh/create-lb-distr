#!/bin/sh

chroot /run/calculate/mount/lb-base-desktop /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF

cl-builder-update --id lb-base-desktop --scan ON -f -o -C ON

emerge @lb-base-desktop

cl-builder-image --id lb-base-desktop -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-base-desktop-`date +%Y%m%d`-x86_64.iso -f