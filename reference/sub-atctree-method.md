# find a subset of the tree

find a subset of the tree

## Usage

``` r
# S4 method for class 'atctree'
x[i, j = 1L]
```

## Arguments

- x:

  object of class atctree

- i:

  label (ATC code) of focal node

- j:

  generation (integer). 0: siblings, -1: children, -2: grandchildren, 1:
  parents etc

## Value

an object of class atctree

## Details

The subset method for objects of class atctree uses a focal node and a
specification of how many generations to accrue. The focal node is
specified by an ATC code at any of the five levels (e.g. i="A01"). The
generation is specified by integer j, signed positive for ancestors and
negative for descendants.

## Examples

``` r
h <- atctree(schema="full")
#more useful to use the full tree with this approach
# plot descendents of P01 (as far as grandchildren):
h["P01",-2] |> plot(stem_label=TRUE, leaf_label=TRUE)
#> Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'plot': object 'h' not found
# plot descendents of P01 (as far as great grandchildren):
h["P01",-3] |> plot(stem_label=TRUE, leaf_label=FALSE)
#> Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'plot': object 'h' not found
# plot descendents of parent of P01A:
h["P01A",1] |> plot(stem_label=TRUE, leaf_label=TRUE)
#> Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'plot': error in evaluating the argument 'h' in selecting a method for function 'parents': object 'h' not found
# plot descendents of grandparent of P01A:
h["P01A",2] |> plot(stem_label=TRUE, leaf_label=TRUE)
#> Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'plot': error in evaluating the argument 'h' in selecting a method for function 'parents': object 'h' not found
```
