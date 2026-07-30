# constructor for atctree objects

constructor for atctree objects

## Usage

``` r
atctree(
  whichlevs = NULL,
  schema = c("none", "full", "anatomical", "therapeutic", "chemical")
)
```

## Arguments

- whichlevs:

  subset of levels to use from integers 1:5

- schema:

  a conceptual subset of the ATC hierarchy, or all of it ('full'), or
  something bespoke ('none')

## Value

an object of class atctree

## Details

either schema or whichlevs should be specified; (e.g. \`schema=full\`
corresponds to \`whichlevs=1:5\`)

## Examples

``` r
h <- atctree(schema="anatomical")
# tree will contain levels 1 and 5
h <- atctree(whichlevs=c(1,2,5))
# bespoke structure

```
