#!/bin/sh

if [ -n "$1" ]
then

DISTRIB=$1

cl-builder-break --id $DISTRIB -f

else
echo "Не введено название прерываемого дистрибутива. Пример команды lb-build-break.sh lb-w10"
fi
