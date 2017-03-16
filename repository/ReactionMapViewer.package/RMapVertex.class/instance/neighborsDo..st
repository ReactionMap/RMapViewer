enumerating
neighborsDo: aBlock
	edges
		do: [ :edge | 
			edge vertex1 == self
				ifTrue: [ aBlock value: edge vertex2 ]
				ifFalse: [ aBlock value: edge vertex1 ] ]