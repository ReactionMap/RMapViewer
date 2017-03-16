enumerating
frameIndexFrom: vertex
	^ (edges detect: [ :edge | (edge oppositeOf: self) == vertex ] ifNone: [  ])
		ifNil: [ 1 ]
		ifNotNil: [ :edge1 | 
			(edges detect: [ :edge | edge ~~ edge1 ] ifNone: [  ])
				ifNil: [ 1 ]
				ifNotNil: [ :edge2 | 
					(edge2 oppositeOf: self)
						ifNil: [ 1 ]
						ifNotNil: [ :vertex2 | 
							vertex label <= vertex2 label
								ifTrue: [ self multiframeIndex + 1 ]
								ifFalse: [ self multiframes size - self multiframeIndex ] ] ] ]