#!/bin/sh

cl-builder-image --id lb-tde-meta -V ON --keep-tree OFF -v ON --image /var/calculate/linux/lb-tde-meta-`date +%Y%m%d`-x86_64.iso -f

