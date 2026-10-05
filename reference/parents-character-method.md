# show the parents for the specified node(s) in the full tree

show the parents for the specified node(s) in the full tree

## Usage

``` r
# S4 method for class 'character'
parents(h)
```

## Arguments

- h:

  node(s)

## Value

parent node(s)

## Examples

``` r
parents(c("A01AA","A01","A"))
#> [1] "A01A" "A"    "0"   
```
