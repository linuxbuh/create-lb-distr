#!/bin/sh

if [ -n "$1" ]
then

DATE=$1

cl-builder-break --id lb-base-desktop -f

cl-builder-prepare --source /var/calculate/linux/cls-$DATE-x86_64.iso --id lb-base-desktop -f -v ON

cl-builder-update --id lb-base-desktop --scan ON -f -o -C ON

chroot /run/calculate/mount/lb-base-desktop /bin/bash -x <<'EOF'
cl-core-variables --set update.cl_update_other_set=on
cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-add-linuxbuh -lb-base-desktop
exit
EOF

cl-builder-update --id lb-base-desktop --scan ON -f -o -C ON

#cl-builder-image --id lb-base-desktop -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-base-desktop-`date +%Y%m%d`-x86_64.iso -f

else
echo "Не введена дата исходного дистрибутива CLS. Например 20211212"
fi
