# helper functions for atctrees

treelevs: return levels within tree (excluding 0)

leaves: return labels of terminal elements (leaves) of tree

nlevs: number of levels in tree (excluding 0)

## Usage

``` r
# S4 method for class 'atctree'
treelevs(h)

# S4 method for class 'atctree'
leaves(h)

# S4 method for class 'atctree'
nlevs(h)
```

## Arguments

- h:

  an object of class atctree

## Value

a vector of the level of each node

vector of labels of the leaf nodes

vector of number of levels in the tree
