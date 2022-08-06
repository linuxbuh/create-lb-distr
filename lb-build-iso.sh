#!/bin/sh

if [ -n "$1" ]
then

DISTRIB=$1

cl-builder-image --id $DISTRIB -V ON --keep-tree OFF -v ON --image /var/calculate/linux/$DISTRIB-`date +%Y%m%d`-x86_64.iso -f

else
echo "Не введено название собираемого дистрибутива. Пример команды lb-build-iso.sh lb-w10"
fi
