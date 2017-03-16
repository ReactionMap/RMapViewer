accessing
argmaxVertex: aBlock suchThat: guardBlock
	^ (vertices
		inject: nil -> Float fmin
		into: [ :sofar :vertex | 
			(guardBlock value: vertex)
				ifTrue: [ 
					| value |
					value := aBlock value: vertex.
					sofar value < value
						ifTrue: [ vertex -> value ]
						ifFalse: [ sofar ] ]
				ifFalse: [ sofar ] ]) key