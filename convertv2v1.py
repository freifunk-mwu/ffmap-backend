#!/usr/bin/env python3                                                               
import json
import argparse
import os
import sys

parser = argparse.ArgumentParser()

parser.add_argument('-o', '--oldnodes', action='store',
                  help='v2 nodes file you want to convert',required=True)

parser.add_argument('-new', '--newnodes', action='store',
                  help='nodes file you want to store',required=True)

args = parser.parse_args()
options = vars(args)

oldnodes_fn = os.path.realpath(options['oldnodes'])
newnodes_fn = os.path.realpath(options['newnodes'])

newnodedb = {'nodes': dict()}

# read nodedb state from node.json
try:
    with open(oldnodes_fn, 'r', encoding=('UTF-8')) as oldnodedb_handle:
        nodedb = json.load(oldnodedb_handle)
except IOError:
    nodedb = {'nodes': dict()}

for oldnode in nodedb['nodes']:
    node_id = oldnode['nodeinfo']['node_id']
    newnodedb['nodes'][node_id] = oldnode

newnodedb['timestamp'] = nodedb['timestamp']
newnodedb['version'] = 1

# write processed data to dest dir
with open(newnodes_fn, 'w') as f:
    json.dump(newnodedb, f)
