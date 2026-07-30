# class to represent a tree from the ATC hierarchy

class to represent a tree from the ATC hierarchy

## Slots

- `node`:

  node id

- `pnode`:

  parent node id

- `lab`:

  ATC code

- `plab`:

  parent ATC code

- `text`:

  ATC textual info

- `lev`:

  level of each node (root node is 0)

- `schema`:

  one of 'none', 'full', 'anatomical', 'therapeutic', 'chemical'

- `whichlevs`:

  subset of integers 1:5; should correspond to schema

- `Nnode`:

  number of nodes in the tree excluding root node

- `Nlev`:

  number of levels in the tree excluding root node
