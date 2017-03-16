enumerating
to: vertex framesDo: aBlock
	(edges detect: [ :edge | (edge oppositeOf: self) == vertex ] ifNone: [  ])
		ifNil: [ aBlock value: self energy ]
		ifNotNil: [ :edge1 | 
			(edges detect: [ :edge | edge ~~ edge1 ] ifNone: [  ])
				ifNil: [ aBlock value: self energy ]
				ifNotNil: [ :edge2 | 
					(edge2 oppositeOf: self)
						ifNil: [ aBlock value: self energy ]
						ifNotNil: [ :vertex2 | 
							| frames |
							frames := self multiframes.
							(vertex2 label <= vertex label
								ifTrue: [ self multiframeIndex + 1 to: frames size ]
								ifFalse: [ (self multiframeIndex + 1 min: frames size) to: 1 by: -1 ]) do: [ :index | aBlock value: (frames at: index) ] ] ] ]