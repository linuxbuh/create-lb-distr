#!/bin/sh

cl-builder-image --id lb-w10 -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-w10-`date +%Y%m%d`-x86_64.iso -f

