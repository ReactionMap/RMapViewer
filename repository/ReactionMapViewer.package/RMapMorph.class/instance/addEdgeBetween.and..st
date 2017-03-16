adding
addEdgeBetween: anInteger1 and: anInteger2
	| v1 v2 morph |
	v1 := vertices at: anInteger1.
	v2 := vertices at: anInteger2.
	morph := RMapEdge between: v1 and: v2.
	edges add: morph.
	^ morph