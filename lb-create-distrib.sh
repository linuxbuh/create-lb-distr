#!/bin/sh

SOURCEISO=$2
ID=$3
VERDISTR=$5

echo
while [ -n "$1" ]
do
case "$1" in
-prepare)
cl-builder-prepare --source $SOURCEISO --id $ID -f -v ON 
;;

cl-builder-update --id lb-base-desktop --scan ON -f

chroot /run/calculate/mount/lb-base-desktop

cd /tmp && wget https://raw.githubusercontent.com/linuxbuh/create-lb-distr/main/create-lb-distr.sh
bash /tmp/create-lb-distr.sh $VERDISTR
exit

-createiso)
cl-builder-image --id lb-base-desktop -V ON --keep-tree OFF  -v ON --image /var/calculate/linux/lb-base-desktop-`date +%Y%m%d`-x86_64.iso -f
;;
*) echo "$1 is not an option" ;;
esac
shift
done

