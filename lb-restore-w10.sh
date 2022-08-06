#!/bin/sh

if [ -n "$1" ]
then

DATE=$1

cl-builder-break --id lb-w10 -f

cl-builder-prepare --source /var/calculate/linux/lb-w10-$DATE-x86_64.iso --id lb-w10 -f -v ON

else
echo "Не введена дата исходного дистрибутива CLDX. Например 20211212"
fi
