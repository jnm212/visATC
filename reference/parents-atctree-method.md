# show the parents for the specified node(s) in the tree

show the parents for the specified node(s) in the tree

## Usage

``` r
# S4 method for class 'atctree'
parents(h, node, anc = 1)
```

## Arguments

- h:

  tree the node belongs to

- node:

  a node e.g. A01AX

- anc:

  level of ancestry (default 1). How many generations back or forward?

## Value

atctree object, or NA if there is no such ancestor

## Examples

``` r

# show the parents and then grandparents of node A01AA01 in a full tree
h <- atctree(schema="full")
parents(h,"A01AA01",anc=1)
#> [1] "A01AA"
parents(h,"A01AA01",anc=2)
#> [1] "A01A"

# for an anatomical tree the levels are (1,5) so the parent is just A:
h2 <- atctree(schema="anatomical")
parents(h2, "A01AA01")
#> [1] "A"

# no grandparent:
parents(h2, "A01AA01",2)
#> [1] NA
```
