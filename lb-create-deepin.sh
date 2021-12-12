#!/bin/sh

if [ -n "$1" ]
then

DATE=$1

cl-builder-break --id lb-deepin -f

cl-builder-prepare --source /var/calculate/linux/lb-base-desktop-$DATE-x86_64.iso --id lb-deepin -f -v ON 

chroot /run/calculate/mount/lb-deepin /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF

cl-builder-update --id lb-deepin --scan ON -f -o

chroot /run/calculate/mount/lb-deepin /bin/bash -x <<'EOF'

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-base-desktop -lb-deepin
exit
EOF

cl-builder-image --id lb-deepin -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-deepin-`date +%Y%m%d`-x86_64.iso -f

else
echo "Не введена дата исходного дистрибутива lb-base-desktop. Например 20211212"
fi
