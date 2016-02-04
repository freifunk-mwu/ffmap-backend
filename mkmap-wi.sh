#!/bin/bash

set -e

export PATH=/home/admin/bin:$PATH

WORKDIR="/home/admin/clones/ffmap-backend"
WWWDIRINTERN="/var/www/meshviewer-intern-wi"
WWWDIREXTERN="/var/www/meshviewer-extern-wi"
CMNTYDATA="wi-data"
CMNTYRRD="wi-rrd"

if [ ! -d $WWWDIRINTERN/build/data ]; then
  mkdir $WWWDIRINTERN/build/data
fi

if [ ! -d $WWWDIREXTERN/build/data ]; then
  mkdir $WWWDIREXTERN/build/data
fi

cd "$(dirname "$0")"/

# run map backend
/usr/bin/python3 $WORKDIR/backend.py --with-rrd --with-img --rrd-path $CMNTYRRD --prune 45 -m wiBAT:/var/run/alfred-wi.sock --vpn 02:00:0a:38:00:17 02:00:0a:38:00:07 02:00:0a:38:00:d0 02:00:0a:38:00:e7 02:00:0a:38:00:2a -d $WORKDIR/$CMNTYDATA/

# remove contact info
/usr/bin/jq '.nodes = (.nodes | map(del(.nodeinfo.owner)))' < $WORKDIR/$CMNTYDATA/nodes.json > $WORKDIR/$CMNTYDATA/nodes-internet.json

# copy files to internal map
cp $WORKDIR/$CMNTYDATA/nodes.json $WWWDIRINTERN/build/data/
cp $WORKDIR/$CMNTYDATA/graph.json $WWWDIRINTERN/build/data/
cp $WORKDIR/$CMNTYDATA/nodelist.json $WWWDIRINTERN/build/data/
cp -r $WORKDIR/$CMNTYDATA/nodes $WWWDIRINTERN/build/data/

# copy files to external map
cp $WORKDIR/$CMNTYDATA/nodes-internet.json $WWWDIREXTERN/build/data/nodes.json
cp $WORKDIR/$CMNTYDATA/graph.json $WWWDIREXTERN/build/data/
cp $WORKDIR/$CMNTYDATA/nodelist.json $WWWDIREXTERN/build/data/
cp -r $WORKDIR/$CMNTYDATA/nodes $WWWDIREXTERN/build/data/
