# visATC (development version)

## Major changes

* graft() function will join multiple atctree objects together (internally this required structural alterations
so that every atctree contains the root node)

* subsetting ([) method now shows descendents of ancestor when j>0, and does nothing when j=0. 
(Previously it showed the direct lineage only, which wasn't very informative).

## Minor changes and bug fixes

* more examples, and all rewritten with pipe operator for clarity

* fixed error in return from cutting() method

* used internally: new helper atctree methods intree() and parents(), coercion of atctree to data.frame 

* look() atctree method finds nodes with a search term

* show() method displays root node as well

# visATC 1.0.0

* Initial CRAN submission.
