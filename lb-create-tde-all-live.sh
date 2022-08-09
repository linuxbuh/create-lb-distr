#!/bin/sh

if [ -n "$1" ]
then

DATE=$1

cl-builder-break --id lb-tde-all-live -f

cl-builder-prepare --source /var/calculate/linux/lb-tde-meta-live-$DATE-x86_64.iso --id lb-tde-all-live -f -v ON 

chroot /run/calculate/mount/lb-tde-all-live /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF

cl-builder-update --id lb-tde-all-live --scan ON -f -o

chroot /run/calculate/mount/lb-tde-all-live /bin/bash -x <<'EOF'

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
#bash /tmp/create-lb-distr.sh -lb-all-desktop -lb-tde-base-live -lb-tde-meta-live -lb-tde-all-live
bash /tmp/create-lb-distr.sh -lb-tde-all-live
exit
EOF

#cl-builder-image --id lb-tde-all-live -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-tde-all-live-`date +%Y%m%d`-x86_64.iso -f

else
echo "Не введена дата исходного дистрибутива lb-tde-meta-live. Например 20211212"
fi
