#!/bin/sh

if [ -n "$1" ]
then

DATE=$1

cl-builder-break --id lb-tde-base -f

cl-builder-prepare --source /var/calculate/linux/lb-base-desktop-$DATE-x86_64.iso --id lb-tde-base -f -v ON 

chroot /run/calculate/mount/lb-tde-base /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF


cl-builder-update --id lb-tde-base --scan ON -f -o -C ON

chroot /run/calculate/mount/lb-tde-base /bin/bash -x <<'EOF'

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-tde-base
exit
EOF


cl-builder-image --id lb-tde-base -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-tde-base-`date +%Y%m%d`-x86_64.iso -f

else
echo "Не введена дата исходного дистрибутива lb-base-desktop. Например 20211212"
fi
