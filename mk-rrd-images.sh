#!/bin/bash

set -e

export PATH=/home/admin/bin:$PATH

WORKDIR="/home/admin/clones/ffmap-backend"
MWUWWWDIRINTERN="/var/www/ffmwu.org/map"
MWUWWWDIREXTERN="/var/www/freifunk-mwu.de/map"
MWUCMNTYDATA="mwu-data"
MWUCMNTYRRD="mwu-rrd"
MZWWWDIRINTERN="/var/www/ffmz.org/map"
MZWWWDIREXTERN="/var/www/freifunk-mainz.de/map"
MZCMNTYDATA="mz-data"
MZCMNTYRRD="mz-rrd"
WIWWWDIRINTERN="/var/www/ffwi.org/map"
WIWWWDIREXTERN="/var/www/freifunk.net/map.wiesbaden"
WICMNTYDATA="wi-data"
WICMNTYRRD="wi-rrd"

cd "$(dirname "$0")"/

# create images
/usr/bin/python3 $WORKDIR/mk-rrd-images.py --rrd-path $MWUCMNTYRRD -d $WORKDIR/$MWUCMNTYDATA/
/usr/bin/python3 $WORKDIR/mk-rrd-images.py --rrd-path $MZCMNTYRRD -d $WORKDIR/$MZCMNTYDATA/
/usr/bin/python3 $WORKDIR/mk-rrd-images.py --rrd-path $WICMNTYRRD -d $WORKDIR/$WICMNTYDATA/


# copy files to internal map
cp -r $WORKDIR/$MWUCMNTYDATA/nodes $MWUWWWDIRINTERN/build/data/
cp -r $WORKDIR/$MZCMNTYDATA/nodes $MZWWWDIRINTERN/build/data/
cp -r $WORKDIR/$WICMNTYDATA/nodes $WIWWWDIRINTERN/build/data/

# copy files to external map
cp -r $WORKDIR/$MWUCMNTYDATA/nodes $MWUWWWDIREXTERN/build/data/
cp -r $WORKDIR/$MZCMNTYDATA/nodes $MZWWWDIREXTERN/build/data/
cp -r $WORKDIR/$WICMNTYDATA/nodes $WIWWWDIREXTERN/build/data/
