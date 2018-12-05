```
#container *		{ all children of container } 
li a 			    { descendant: grab all a in li}
.ico.ico-plus		{ grab items with both classes }
li, a 			    { grab both a and li}
li > a 			    { grab only all direct children a}
ul + p 			    { adjacent: only first paragraph preceding ul }
ul ~ p 			    { all paragraphs preceding ul }
a[title] 		    { a with attribute title }
a[href=”in.gr”]     { only a with href=in.gr }
a[href*="any"] 	    { value must appear somewhere in the attribute }
a[href^="http"] 	{ attribute must start with this value }
a[href$=".jpg"] 	{ attribute must end with this value }
```
