#!/bin/sh

if [ -n "$1" ] || [ -n "$2" ] || [ -n "$3" ]
then

DISTRIBORIG=$1
DATE=$2
DISTRIB=$3

cl-builder-prepare --source /var/calculate/linux/$DISTRIBORIG-$DATE-x86_64.iso --id $DISTRIB -f -v ON

else
echo "Не введено название или дата исходного дистрибутива или название собираемого дистрибутива. Пример команды lb-build-prepare.sh CLDX 20211210 lb-w10"
fi
