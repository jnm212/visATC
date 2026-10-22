# visATC (development version)

## Major changes

* new graft() function joins multiple atctree objects together (internally this required structural alterations
so that every atctree contains the root node)

* subsetting ([) method now shows the descendents of an ancestor when j>0, and does nothing when j=0. 
(Previously it only showed the direct lineage when j>0, which wasn't very informative).

## Minor changes and bug fixes

* more examples, and all rewritten with pipe operator for clarity

* fixed error in return from cutting() method

* used internally: new helper atctree methods intree() and parents(), and coercion of atctree to data.frame 

* minor alteration to layout of levels in plots

* new slot 'drugnames' for atctree class 

* look() atctree method finds nodes with a search term

* show() method now displays root node as well

# visATC 1.0.0

* Initial CRAN submission.
