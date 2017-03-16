accessing
argminVertex: aBlock suchThat: guardBlock
	^ (vertices
		inject: nil -> Float fmax
		into: [ :sofar :vertex | 
			(guardBlock value: vertex)
				ifTrue: [ 
					| value |
					value := aBlock value: vertex.
					value < sofar value
						ifTrue: [ vertex -> value ]
						ifFalse: [ sofar ] ]
				ifFalse: [ sofar ] ]) key