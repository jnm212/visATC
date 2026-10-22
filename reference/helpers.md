# helper functions for atctrees

treelevs: return levels within tree (excluding 0)

leaves: return labels of terminal elements (leaves) of tree

nlevs: number of levels in tree (excluding 0)

check whether a node is in a tree

## Usage

``` r
# S4 method for class 'atctree'
treelevs(h)

# S4 method for class 'atctree'
leaves(h)

# S4 method for class 'atctree'
nlevs(h)

# S4 method for class 'atctree'
intree(h, node)
```

## Arguments

- h:

  an object of class atctree

- node:

  name of a node e.g. A01

## Value

a vector of the level of each node

vector of labels of the leaf nodes

vector of number of levels in the tree

logical value

## Examples

``` r
h <- atctree(schema="therapeutic")
# get the levels of the nodes in a tree:
cutting(h,"P01A") |> treelevs()
#> P01AA01 P01AA02 P01AA04 P01AA05 P01AA30 P01AA52 P01AB01 P01AB02 P01AB03 P01AB04 
#>       5       5       5       5       5       5       5       5       5       5 
#> P01AB05 P01AB06 P01AB07 P01AB08 P01AB51 P01AB52 P01AB53 P01AC01 P01AC02 P01AC03 
#>       5       5       5       5       5       5       5       5       5       5 
#> P01AC04 P01AR01 P01AR02 P01AR03 P01AR53 P01AX01 P01AX02 P01AX04 P01AX05 P01AX06 
#>       5       5       5       5       5       5       5       5       5       5 
#> P01AX07 P01AX08 P01AX09 P01AX10 P01AX11 P01AX52    P01A 
#>       5       5       5       5       5       5       3 

h <- atctree(schema="full")
# get the leaf nodes for the tree:
cutting(h,"P01A") |> leaves()
#>  [1] "P01AA01" "P01AA02" "P01AA04" "P01AA05" "P01AA30" "P01AA52" "P01AB01"
#>  [8] "P01AB02" "P01AB03" "P01AB04" "P01AB05" "P01AB06" "P01AB07" "P01AB08"
#> [15] "P01AB51" "P01AB52" "P01AB53" "P01AC01" "P01AC02" "P01AC03" "P01AC04"
#> [22] "P01AR01" "P01AR02" "P01AR03" "P01AR53" "P01AX01" "P01AX02" "P01AX04"
#> [29] "P01AX05" "P01AX06" "P01AX07" "P01AX08" "P01AX09" "P01AX10" "P01AX11"
#> [36] "P01AX52"

h <- atctree(schema="anatomical")
nlevs(h)
#> [1] 2

h2 <- atctree(whichlevs=c(1,2,5))
nlevs(h2)
#> [1] 3
h <- atctree(schema="chemical")
intree(h, "A01")
#> [1] FALSE
intree(h, "A01AA")
#> [1] TRUE
```
