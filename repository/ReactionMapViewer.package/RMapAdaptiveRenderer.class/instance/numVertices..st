accessing
numVertices: anInteger
	1 to: renderers size do: [  :i |
		(renderers at: i) key >= anInteger ifTrue: [selectedIndex := i. ^self]].
	selectedIndex := renderers size