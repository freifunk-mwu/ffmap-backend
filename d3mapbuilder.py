import json

class D3MapBuilder:
  db = None

  def __init__(self, db):
    self.db = db

  def build(self):
    output = dict()

    output['nodes'] = [{'group': x.group, 'name': x.name,
                        'macs': ', '.join(x.macs)
                       } for x in self.db.get_nodes() if x.online]
    output['links'] = [{'source': x.pair[0], 'target': x.pair[1],
                        'distance': x.distance,
                        'strength': x.strength
                       } for x in self.db.get_links()]

    return json.dumps(output)

