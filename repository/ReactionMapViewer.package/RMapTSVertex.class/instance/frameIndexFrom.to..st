enumerating
frameIndexFrom: vertex1 to: vertex2
	^ ((edges contains: [ :edge | (edge oppositeOf: self) == vertex1 ])
		and: [ edges contains: [ :edge | (edge oppositeOf: self) == vertex2 ] ])
		ifTrue: [ 
			vertex1 label <= vertex2 label
				ifTrue: [ self multiframeIndex + 1 ]
				ifFalse: [ self multiframes size - self multiframeIndex ] ]
		ifFalse: [ 1 ]