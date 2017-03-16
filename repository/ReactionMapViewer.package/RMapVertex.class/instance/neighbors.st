accessing
neighbors
	^ edges
		collect: [ :edge | 
			edge vertex1 == self
				ifTrue: [ edge vertex2 ]
				ifFalse: [ edge vertex1 ] ]