#!/usr/bin/env python3
"""
makerrdimages.py - script just to create statistic images
https://github.com/ffnord/ffmap-backend
"""
import argparse
import os
import sys
from datetime import datetime

from lib.rrddb import RRD

def main(params):
    os.makedirs(params['dest_dir'], exist_ok=True)

    now = datetime.utcnow().replace(microsecond=0)

    rrd = RRD(params['rrd_path'], os.path.join(params['dest_dir'], 'nodes'))
    rrd.update_images()

if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    parser.add_argument('-d', '--dest-dir', action='store',
                        help='Write output to destination directory',
                        required=True)
    parser.add_argument('--rrd-path', default=os.path.join(os.path.dirname(os.path.realpath(__file__)), 'nodedb'),
                        help='path to RRD files',required=True)

    options = vars(parser.parse_args())
    main(options)
