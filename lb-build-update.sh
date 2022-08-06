#!/bin/sh

if [ -n "$1" ]
then

DISTRIB=$1

chroot /run/calculate/mount/$DISTRIB /bin/bash -x <<'EOF'
shopt -s extglob
rm -r /var/db/repos/!(@(calculate|distros))
exit
EOF

cl-builder-update --id $DISTRIB --scan ON -f -o -C ON

else
echo "Не введено название собираемого дистрибутива. Пример команды lb-build-update.sh lb-w10"
fi
