# search the node texts for an expression

search the node texts for an expression

## Usage

``` r
# S4 method for class 'atctree'
look(h, txt)
```

## Arguments

- h:

  an object of class atctree

- txt:

  word or part of a word or regular expression to search for

## Value

returns a vector of nodes whose text matches

## Examples

``` r
h <- atctree(schema="full")
nds <- look(h, "inflamm")
# a search for inflammatory substances and families

# plot element nds[1] which is "A07E":
cutting(h, nds[1]) |> plot()
#> Remember you can hover over nodes to see text

{"x":{"visdat":{"1a7a6d087e1":["function () ","plotlyVisDat"]},"cur_data":"1a7a6d087e1","attrs":{"1a7a6d087e1":{"x":{},"y":{},"mode":"markers+text","hovertext":["G02CC01:ibuprofen","G02CC02:naproxen","G02CC03:benzydamine","G02CC04:flunoxaprofen","G02CC:Antiinflammatory products for vaginal administration","0:root"],"hoverinfo":"text","alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"scatter"}},"layout":{"width":500,"height":500,"margin":{"b":0,"l":0,"t":0,"r":0},"autosize":false,"shapes":[{"type":"line","opacity":0.25,"line":{"color":"#030303","width":0.29999999999999999},"x0":0,"y0":1,"x1":1.5,"y1":2},{"type":"line","opacity":0.25,"line":{"color":"#030303","width":0.29999999999999999},"x0":1,"y0":1,"x1":1.5,"y1":2},{"type":"line","opacity":0.25,"line":{"color":"#030303","width":0.29999999999999999},"x0":2,"y0":1,"x1":1.5,"y1":2},{"type":"line","opacity":0.25,"line":{"color":"#030303","width":0.29999999999999999},"x0":3,"y0":1,"x1":1.5,"y1":2},{"type":"line","opacity":0.25,"line":{"color":"#030303","width":0.29999999999999999},"x0":1.5,"y0":2,"x1":1.5,"y1":6}],"xaxis":{"domain":[0,1],"automargin":true,"title":"","showgrid":false,"showticklabels":false,"zeroline":false},"yaxis":{"domain":[0,1],"automargin":true,"title":"","showgrid":false,"showticklabels":false,"zeroline":false},"annotations":[{"text":"G02CC01","showarrow":true,"arrowsize":0.29999999999999999,"arrowwidth":0.10000000000000001,"ax":-10,"ay":-10,"font":{"size":10},"textangle":45,"x":0,"y":1},{"text":"G02CC02","showarrow":true,"arrowsize":0.29999999999999999,"arrowwidth":0.10000000000000001,"ax":-10,"ay":-10,"font":{"size":10},"textangle":45,"x":1,"y":1},{"text":"G02CC03","showarrow":true,"arrowsize":0.29999999999999999,"arrowwidth":0.10000000000000001,"ax":-10,"ay":-10,"font":{"size":10},"textangle":45,"x":2,"y":1},{"text":"G02CC04","showarrow":true,"arrowsize":0.29999999999999999,"arrowwidth":0.10000000000000001,"ax":-10,"ay":-10,"font":{"size":10},"textangle":45,"x":3,"y":1},{"text":"G02CC","showarrow":true,"arrowsize":0.29999999999999999,"arrowwidth":0.10000000000000001,"ax":-10,"ay":-10,"font":{"size":10},"textangle":45,"x":1.5,"y":2},{"text":"0","showarrow":true,"arrowsize":0.29999999999999999,"arrowwidth":0.10000000000000001,"ax":-10,"ay":-10,"font":{"size":10},"textangle":45,"x":1.5,"y":6}],"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":[0,1,2,3,1.5,1.5],"y":[1,1,1,1,2,6],"mode":"markers+text","hovertext":["G02CC01:ibuprofen","G02CC02:naproxen","G02CC03:benzydamine","G02CC04:flunoxaprofen","G02CC:Antiinflammatory products for vaginal administration","0:root"],"hoverinfo":["text","text","text","text","text","text"],"type":"scatter","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(31,119,180,1)"}},"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"line":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
```
