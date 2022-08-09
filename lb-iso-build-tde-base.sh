#!/bin/sh

cl-builder-image --id lb-tde-base -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-tde-base-`date +%Y%m%d`-x86_64.iso -f

