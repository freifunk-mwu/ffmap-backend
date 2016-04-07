#!/bin/bash

set -e

export PATH=/home/admin/bin:$PATH

WORKDIR="/home/admin/clones/ffmap-backend"
MWUWWWDIRINTERN="/var/www/meshviewer-intern-mwu"
MWUWWWDIREXTERN="/var/www/meshviewer-extern-mwu"
MWUCMNTYDATA="mwu-data"
MWUCMNTYRRD="mwu-rrd"
MZWWWDIRINTERN="/var/www/meshviewer-intern-mz"
MZWWWDIREXTERN="/var/www/meshviewer-extern-mz"
MZCMNTYDATA="mz-data"
MZCMNTYRRD="mz-rrd"
WIWWWDIRINTERN="/var/www/meshviewer-intern-wi"
WIWWWDIREXTERN="/var/www/meshviewer-extern-wi"
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
