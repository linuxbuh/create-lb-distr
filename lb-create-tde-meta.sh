#!/bin/sh

if [ -n "$1" ]
then

DATE=$1

cl-builder-break --id lb-tde-meta -f

cl-builder-prepare --source /var/calculate/linux/lb-tde-base-$DATE-x86_64.iso --id lb-tde-meta -f -v ON 

chroot /run/calculate/mount/lb-tde-meta /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF


cl-builder-update --id lb-tde-meta --scan ON -f -o -C ON

chroot /run/calculate/mount/lb-tde-meta /bin/bash -x <<'EOF'

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh -lb-tde-meta
exit
EOF


#cl-builder-image --id lb-tde-meta -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-tde-meta-`date +%Y%m%d`-x86_64.iso -f

else
echo "Не введена дата исходного дистрибутива lb-base-desktop. Например 20211212"
fi
