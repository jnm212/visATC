# display drug name for ATC codes

display drug name for ATC codes

## Usage

``` r
drugnames(x)
```

## Arguments

- x:

  vector of ATC codes

## Value

character vector of drug names

## Examples

``` r
# example code
drugnames(c("P01AA", "P01A"))
#>                                                    P01AA 
#>                           "Hydroxyquinoline derivatives" 
#>                                                     P01A 
#> "AGENTS AGAINST AMOEBIASIS AND OTHER PROTOZOAL DISEASES" 
```
