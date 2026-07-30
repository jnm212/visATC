# summarise atctree object

shows schema, number of nodes and levels and a cross-table, excluding
the root node.

## Usage

``` r
# S4 method for class 'atctree'
show(object)
```

## Arguments

- object:

  of class acttree

## Value

prints summary to console

## Examples

``` r
h <- atctree(whichlevs=1:4)
(h)
#> 
#>  schema:  none
#>  total number of nodes:  1318
#>  total number of levels:  4
#>  number of nodes by level :
#>   1   2   3   4 
#>  14  94 271 939 
```
